package main

import "../allegro"

Key_State :: enum {
    just_pressed,
    just_released,
    down,
    up,
}
Ez_Mouse_State :: enum {
    none = 0,
    left_dragging       = 1 << 1,
    left_down           = 1 << 2,
    left_clicking       = 1 << 3,
    left_release        = 1 << 4,
    right_dragging      = 1 << 5,
    right_clicking      = 1 << 6,
    right_down          = 1 << 7,
    right_release       = 1 << 8,
    left_right_dragging = 1 << 9,
}
Ez_Allegro :: struct {
    camera: Camera_2D,
    font: ^allegro.Font,
    keys: map[allegro.Keycode]Key_State,
    mouse: Ez_Mouse_State,
    mouse_x: f32,
    mouse_y: f32,
}

ez_init :: proc(app_init: proc(^Ez_Allegro), app_loop: proc(^Ez_Allegro), fps: int = 60, resizable: bool = true) {
    using allegro

    ctx : Ez_Allegro = ---

    if resizable {
    }
    
    init()
    install_keyboard()
    install_mouse()
    display_set_default_flags(.WINDOWED | .RESIZABLE)
    display := display_create(1280, 720)

    if display == nil {
        panic("Failed to init display")
    }
    if prim_install() == false {
        panic("Failed to load primitives")
    }
    if image_install() == false {
        panic("Failed to load images addon")
    }
    if font_install() == false {
        panic("Failed to load fonts addon")
    }
    if font_ttf_install() == false {
        panic("Failed to load ttf fonts addon")
    }
    
    ctx.font = font_load_builtin()
    timer := timer_create(1.0/f64(fps))
    evt: Event = ---
    queue := equeue_create()
    redraw := true

    equeue_register(queue, display_get_event_source(display))
    equeue_register(queue, timer_get_event_source(timer))
    equeue_register(queue, get_mouse_source())
    equeue_register(queue, get_keyboard_source())

    timer_start(timer)
    camera_recalculate(&ctx.camera)
    camera_update(&ctx.camera, 0.0, 0.0, 1.0, 0.0)

    app_init(&ctx)

    mainloop: for {
        equeue_await_event(queue, &evt)

        #partial switch evt.evt_type {
            case .DISPLAY_CLOSE: break mainloop;
            case .TIMER: redraw = true;
            case .MOUSE_AXES: {
                mouse: Mouse_Event = evt.mouse_evt
            }
            case .DISPLAY_RESIZE: {
                camera_recalculate(&ctx.camera)
            }
        }

        if redraw && equeue_is_empty(queue) {
            bitmap_clear(rgb(70,70,70))
            app_loop(&ctx)
            display_flip()
            redraw = false
        }
    }

    display_destroy(display)
    equeue_destroy(queue)
    timer_destroy(timer)
}