package allegro

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

import "core:c"

/* Not sure we need it, but since ALLEGRO_VERSION_STR contains it:
 * 0 = GIT
 * 1 = first release
 * 2... = hotfixes?
 *
 * Note x.y.z (= x.y.z.0) has release number 1, and x.y.z.1 has release
 * number 2, just to confuse you.
 */
RELEASE_NUMBER :: 1
VERSION_STR :: "5.2.8"
DATE_STR :: "2022"
// yyyymmdd
DATE :: 20220605
VERSION :: 5
SUB_VERSION :: 2
WIP_VERSION :: 8
VERSION_INT :: (VERSION << 24) | (SUB_VERSION << 16) | (WIP_VERSION << 8) | RELEASE_NUMBER | 0
ON_EXIT_PROC :: #type proc "c" (ptr: rawptr) -> c.int



@(default_calling_convention="c")
foreign lib {
    // Called for you by init. Activates the base allegro system.
    @(link_name="al_install_system")
    install_system :: proc(i: c.int, exit: ON_EXIT_PROC) -> c.bool ---

    @(link_name="al_install_mouse")
    install_mouse :: proc() -> bool ---
    @(link_name="al_get_mouse_event_source")
    get_mouse_source :: proc() -> ^Event_Source ---
}

init :: proc() {
    if install_system(VERSION_INT, nil) == false {
        panic("Failed to init allegro")
    }
}

