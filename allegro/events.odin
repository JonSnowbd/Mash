package allegro

import "core:c"

when ODIN_OS == .Windows {
    foreign import lib {
        "lib/allegro.lib",
        "lib/allegro_primitives.lib",
        "lib/allegro_image.lib",
        "lib/allegro_font.lib",
        "lib/allegro_ttf.lib",
        "lib/allegro_audio.lib",
        "lib/allegro_dialog.lib",
    }
}

Event_Queue :: struct{}
Event_Source :: struct {}

Event_Type :: enum c.int {
    JOYSTICK_AXIS               =  1,
    JOYSTICK_BUTTON_DOWN        =  2,
    JOYSTICK_BUTTON_UP          =  3,
    JOYSTICK_CONFIGURATION      =  4,
 
    KEY_DOWN                    = 10,
    KEY_CHAR                    = 11,
    KEY_UP                      = 12,
 
    MOUSE_AXES                  = 20,
    MOUSE_BUTTON_DOWN           = 21,
    MOUSE_BUTTON_UP             = 22,
    MOUSE_ENTER_DISPLAY         = 23,
    MOUSE_LEAVE_DISPLAY         = 24,
    MOUSE_WARPED                = 25,
 
    TIMER                       = 30,
 
    DISPLAY_EXPOSE              = 40,
    DISPLAY_RESIZE              = 41,
    DISPLAY_CLOSE               = 42,
    DISPLAY_LOST                = 43,
    DISPLAY_FOUND               = 44,
    DISPLAY_SWITCH_IN           = 45,
    DISPLAY_SWITCH_OUT          = 46,
    DISPLAY_ORIENTATION         = 47,
    DISPLAY_HALT_DRAWING        = 48,
    DISPLAY_RESUME_DRAWING      = 49,
 
    TOUCH_BEGIN                 = 50,
    TOUCH_END                   = 51,
    TOUCH_MOVE                  = 52,
    TOUCH_CANCEL                = 53,

    DISPLAY_CONNECTED           = 60,
    DISPLAY_DISCONNECTED        = 61,
}
Any_Event :: struct {
    event_type: Event_Type,
    source: rawptr,
    timestamp: c.double,
}
Display_Event :: struct {
    event_type: Event_Type,
    source: rawptr,
    timestamp: c.double,
    x, y, width, height, orientation: c.int,
}
Joystick_Event :: struct {
    event_type: Event_Type,
    source: rawptr,
    timestamp: c.double,
    // This is of type ALLEGRO_JOYSTICK in C
    id: rawptr,
    stick: c.int,
    axis: c.int,
    pos: c.float,
    button: c.int,
}
Keyboard_Event :: struct {
    event_type: Event_Type,
    source: rawptr,
    timestamp: c.double,
    display: rawptr,
    keycode: c.int,
    // Unicode
    unichar: c.int,
    // Bitfield
    modifiers: c.uint,
    // If true, this is an echo auto-repeat
    repeat: c.bool,
}
Mouse_Event :: struct {
    event_type: Event_Type,
    source: rawptr,
    timestamp: c.double,
    display: rawptr,
    // Primary mouse position, x coordinate
    x: c.int,
    // Primary mouse position, x coordinate
    y: c.int,
    // Mouse wheel, 1d position
    z: c.int,
    // Delta movement from last frame. Mouse wheel horizontal, 1d position.
    w: c.int,
    // Delta movement from last frame. Primary mouse position, x coordinate
    dx: c.int,
    // Delta movement from last frame. Primary mouse position, x coordinate
    dy: c.int,
    // Delta movement from last frame. Mouse wheel, 1d position
    dz: c.int,
    // Delta movement from last frame. Mouse wheel horizontal, 1d position.
    dw: c.int,
    button: c.uint,
    // Pen pressure
    pressure: c.float,
}
Timer_Event :: struct {
    event_type: Event_Type,
    source: ^Timer,
    timestamp: c.double,
    count: c.int64_t,
    error: c.double,
}
Touch_Event :: struct {
    event_type: Event_Type,
    source: ^Timer,
    timestamp: c.double,
    display: rawptr,
    error: c.double,
    x: c.float,
    y: c.float,
    dx: c.float,
    dy: c.float,
    primary: c.bool,
}
User_Event :: struct {
    event_type: Event_Type,
    source: ^Timer,
    timestamp: c.double,
    internal: rawptr,
    data1: c.intptr_t,
    data2: c.intptr_t,
    data3: c.intptr_t,
    data4: c.intptr_t,
}
Event :: struct #raw_union {
    evt_type: Event_Type,
    any_evt: Any_Event,
    display_evt: Display_Event,
    joystick_evt: Joystick_Event,
    keyboard_evt: Keyboard_Event,
    mouse_evt: Mouse_Event,
    timer_evt: Timer_Event,
    touch_evt: Touch_Event,
    user_evt: User_Event,
}

@(default_calling_convention="c")
foreign lib {
    @(link_name="al_create_event_queue")
    equeue_create :: proc() -> ^Event_Queue ---
    @(link_name="al_destroy_event_queue")
    equeue_destroy :: proc(queue: ^Event_Queue) ---
    @(link_name="al_is_event_queue_empty")
    equeue_is_empty :: proc(queue: ^Event_Queue) -> c.bool ---
    @(link_name="al_is_event_queue_paused")
    equeue_is_paused :: proc(queue: ^Event_Queue) -> c.bool ---
    // Pause or resume accepting new events into the event queue (to resume, pass false
    // for pause). Events already in the queue are unaffected.
    //
    // While a queue is paused, any events which would be entered into the queue are
    // simply ignored. This is an alternative to unregistering then re-registering
    // all event sources from the event queue, if you just need to prevent events
    // piling up in the queue for a while.
    @(link_name="al_pause_event_queue")
    equeue_set_pause :: proc(queue: ^Event_Queue, pause: c.bool) -> c.bool ---
    // Return true if the event source is registered.
    @(link_name="al_is_event_source_registered")
    equeue_is_source_registered :: proc(queue: ^Event_Queue, source: ^Event_Source) -> c.bool ---
    @(link_name="al_peek_next_event")
    equeue_peek :: proc(queue: ^Event_Queue, OUT_event: ^Event) ---
    // Register the event source with the event queue specified. An event
    // source may be registered with any number of event queues simultaneously,
    // or none. Trying to register an event source with the same event queue
    // more than once does nothing.
    @(link_name="al_register_event_source")
    equeue_register :: proc(queue: ^Event_Queue, source: ^Event_Source) ---
    // Drops all events, if any, from the queue.
    @(link_name="al_flush_event_queue")
    equeue_empty :: proc(queue: ^Event_Queue) ---
    // Take the next event out of the event queue specified, and copy the contents
    // into ret_event, returning true. The original event will be removed from the
    // queue. If the event queue is empty, return false and the contents of ret_event
    // are unspecified.
    @(link_name="al_wait_for_event")
    equeue_await_event :: proc(queue: ^Event_Queue, OUT_event: ^Event) ---
    // Take the next event out of the event queue specified, and copy the contents
    // into ret_event, returning true. The original event will be removed from
    // the queue. If the event queue is empty, return false and the contents of
    // ret_event are unspecified.
    @(link_name="al_get_next_event")
    equeue_get_next_event :: proc(queue: ^Event_Queue, OUT_event: ^Event) -> bool ---
}