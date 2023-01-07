package allegro

import "core:c"

Timer   :: struct {}

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

@(default_calling_convention="c")
foreign lib {
    // Allocates and initializes a timer. If successful, a pointer to
    // a new timer object is returned, otherwise NULL is returned.
    // speed_secs is in seconds per “tick”, and must be positive.
    // The new timer is initially stopped and needs to be started
    // with al_start_timer before ALLEGRO_EVENT_TIMER events are sent.
    // 
    // Usage note: typical granularity is on the order of microseconds,
    // but with some drivers might only be milliseconds.
    @(link_name="al_create_timer")
    timer_create :: proc(interval: c.double) -> ^Timer ---
    @(link_name="al_destroy_timer")
    timer_destroy :: proc(timer: ^Timer) ---
    // Start the timer specified. From then, the timer’s counter will increment
    // at a constant rate, and it will begin generating events. Starting a
    // timer that is already started does nothing. Starting a timer that
    // was stopped will reset the timer’s counter, effectively restarting
    // the timer from the beginning.
    @(link_name="al_start_timer")
    timer_start :: proc(timer: ^Timer) ---
    // Stop the timer specified. The timer’s counter will stop incrementing
    // and it will stop generating events. Stopping a timer that is already
    // stopped does nothing.
    @(link_name="al_stop_timer")
    timer_stop :: proc(timer: ^Timer) ---
    @(link_name="al_get_timer_started")
    timer_is_started :: proc(timer: ^Timer) -> c.bool ---
    @(link_name="al_get_timer_speed")
    timer_get_speed :: proc(timer: ^Timer) -> c.double ---
    @(link_name="al_get_timer_count")
    timer_get_count :: proc(timer: ^Timer) -> c.int64_t ---
    @(link_name="al_set_timer_speed")
    timer_set_speed :: proc(timer: ^Timer, new_speed: c.double) ---
    @(link_name="al_get_timer_event_source")
    timer_get_event_source :: proc(timer: ^Timer) -> ^Event_Source ---
}