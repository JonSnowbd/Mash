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


Display_Flags :: enum c.int {
    WINDOWED                    = 1 << 0,
    FULLSCREEN                  = 1 << 1,
    OPENGL                      = 1 << 2,
    DIRECT3D_INTERNAL           = 1 << 3,
    RESIZABLE                   = 1 << 4,
    FRAMELESS                   = 1 << 5,
    NOFRAME                     = 1 << 5, /* older synonym */
    GENERATE_EXPOSE_EVENTS      = 1 << 6,
    OPENGL_3_0                  = 1 << 7,
    OPENGL_FORWARD_COMPATIBLE   = 1 << 8,
    FULLSCREEN_WINDOW           = 1 << 9,
    MINIMIZED                   = 1 << 10,
    PROGRAMMABLE_PIPELINE       = 1 << 11,
    GTK_TOPLEVEL_INTERNAL       = 1 << 12,
    MAXIMIZED                   = 1 << 13,
    OPENGL_ES_PROFILE           = 1 << 14,
    OPENGL_CORE_PROFILE         = 1 << 15,
};
Display_Options :: enum c.int {
    RED_SIZE = 0,
    GREEN_SIZE = 1,
    BLUE_SIZE = 2,
    ALPHA_SIZE = 3,
    RED_SHIFT = 4,
    GREEN_SHIFT = 5,
    BLUE_SHIFT = 6,
    ALPHA_SHIFT = 7,
    ACC_RED_SIZE = 8,
    ACC_GREEN_SIZE = 9,
    ACC_BLUE_SIZE = 10,
    ACC_ALPHA_SIZE = 11,
    STEREO = 12,
    AUX_BUFFERS = 13,
    COLOR_SIZE = 14,
    DEPTH_SIZE = 15,
    STENCIL_SIZE = 16,
    SAMPLE_BUFFERS = 17,
    SAMPLES = 18,
    RENDER_METHOD = 19,
    FLOAT_COLOR = 20,
    FLOAT_DEPTH = 21,
    SINGLE_BUFFER = 22,
    SWAP_METHOD = 23,
    COMPATIBLE_DISPLAY = 24,
    UPDATE_DISPLAY_REGION = 25,
    VSYNC = 26,
    MAX_BITMAP_SIZE = 27,
    SUPPORT_NPOT_BITMAP = 28,
    CAN_DRAW_INTO_BITMAP = 29,
    SUPPORT_SEPARATE_ALPHA = 30,
    AUTO_CONVERT_BITMAPS = 31,
    SUPPORTED_ORIENTATIONS = 32,
    OPENGL_MAJOR_VERSION = 33,
    OPENGL_MINOR_VERSION = 34,
    DEFAULT_SHADER_PLATFORM = 35,
    DISPLAY_OPTIONS_COUNT,
}

Display_Orientation :: enum c.int {
    ALLEGRO_DISPLAY_ORIENTATION_UNKNOWN = 0,
    ALLEGRO_DISPLAY_ORIENTATION_0_DEGREES = 1,
    ALLEGRO_DISPLAY_ORIENTATION_90_DEGREES = 2,
    ALLEGRO_DISPLAY_ORIENTATION_180_DEGREES = 4,
    ALLEGRO_DISPLAY_ORIENTATION_270_DEGREES = 8,
    ALLEGRO_DISPLAY_ORIENTATION_PORTRAIT = 5,
    ALLEGRO_DISPLAY_ORIENTATION_LANDSCAPE = 10,
    ALLEGRO_DISPLAY_ORIENTATION_ALL = 15,
    ALLEGRO_DISPLAY_ORIENTATION_FACE_UP = 16,
    ALLEGRO_DISPLAY_ORIENTATION_FACE_DOWN = 32,
}

Display :: struct {}

@(default_calling_convention="c")
foreign lib {
    @(link_name="al_create_display")
    display_create :: proc(w, h: c.int) -> ^Display ---
    @(link_name="al_destroy_display")
    display_destroy :: proc(IN_display: ^Display) ---
    @(link_name="al_get_display_event_source")
    display_get_event_source :: proc(IN_display: ^Display) -> ^Event_Source ---
    @(link_name="al_get_display_width")
    display_get_width :: proc(IN_display: ^Display) -> c.int ---
    @(link_name="al_get_display_height")
    display_get_height :: proc(IN_display: ^Display) -> c.int ---
    @(link_name="al_get_backbuffer")
    display_get_backbuffer :: proc(IN_display: ^Display) -> ^Bitmap ---
    @(link_name="al_get_display_refresh_rate")
    display_get_refresh_rate :: proc(IN_display: ^Display) -> c.int ---
    @(link_name="al_set_window_position")
    display_set_position :: proc(display: ^Display, x, y: c.int) ---
    @(link_name="al_resize_display")
    display_set_size :: proc(display: ^Display, w, h: c.int) ---
    @(link_name="al_get_window_position")
    display_get_position :: proc(display: ^Display, OUT_x, OUT_y: ^c.int) ---
    @(link_name="al_get_current_display")
    display_get_current :: proc() -> ^Display ---
    @(link_name="al_set_new_display_flags")
    display_set_default_flags :: proc(flag: Display_Flags) ---
    @(link_name="al_set_display_flag")
    display_set_flag :: proc(display: ^Display, flag: Display_Flags, enabled: c.bool) ---
    // Copies or updates the front and back buffers so that what has been
    // drawn previously on the currently selected display becomes visible on
    // screen. Pointers to the special back buffer bitmap remain valid and
    // retain their semantics as the back buffer, although the contents may have changed.
    @(link_name="al_flip_display")
    display_flip :: proc() ---
    @(link_name="al_set_window_title")
    display_set_title :: proc(display: ^Display, title: cstring) ---
    @(link_name="al_set_display_icon")
    display_set_icon :: proc(display: ^Display, icon: ^Bitmap) ---
    // Same as al_set_target_bitmap(al_get_backbuffer(display));
    @(link_name="al_set_target_backbuffer")
    display_target_backbuffer_as_bitmap :: proc(display: ^Display) ---
    // Wait for the beginning of a vertical retrace. Some driver/card/monitor
    // combinations may not be capable of this.
    //
    // Note how al_flip_display usually already waits for the vertical retrace,
    // so unless you are doing something special, there is no reason to call this function.
    @(link_name="al_wait_for_vsync")
    display_wait_for_vsync :: proc() -> c.bool ---
}