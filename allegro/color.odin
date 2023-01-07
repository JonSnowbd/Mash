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

Pixel_Format :: enum c.int {
    ANY                   = 0,
    ANY_NO_ALPHA          = 1,
    ANY_WITH_ALPHA        = 2,
    ANY_15_NO_ALPHA       = 3,
    ANY_16_NO_ALPHA       = 4,
    ANY_16_WITH_ALPHA     = 5,
    ANY_24_NO_ALPHA       = 6,
    ANY_32_NO_ALPHA       = 7,
    ANY_32_WITH_ALPHA     = 8,
    ARGB_8888             = 9,
    RGBA_8888             = 10,
    ARGB_4444             = 11,
    RGB_888               = 12, /* 24 bit format */
    RGB_565               = 13,
    RGB_555               = 14,
    RGBA_5551             = 15,
    ARGB_1555             = 16,
    ABGR_8888             = 17,
    XBGR_8888             = 18,
    BGR_888               = 19, /* 24 bit format */
    BGR_565               = 20,
    BGR_555               = 21,
    RGBX_8888             = 22,
    XRGB_8888             = 23,
    ABGR_F32              = 24,
    ABGR_8888_LE          = 25,
    RGBA_4444             = 26,
    SINGLE_CHANNEL_8      = 27,
    COMPRESSED_RGBA_DXT1  = 28,
    COMPRESSED_RGBA_DXT3  = 29,
    COMPRESSED_RGBA_DXT5  = 30,
    NUM_PIXEL_FORMATS,
}

Color :: struct {
    r, g, b, a: c.float,
}    

@(default_calling_convention="c")
foreign lib {
    // Creates a color
    // Each component is between 0 and 255, inclusively.
    @(link_name="al_map_rgba")
    rgba :: proc(r, g, b, a: c.char) -> Color ---
    // Creates a color
    // Each component is between 0 and 255, inclusively.
    @(link_name="al_map_rgb")
    rgb :: proc(r, g, b: c.char) -> Color ---
}