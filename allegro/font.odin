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

// A handle identifying any kind of font. Usually you will create it with al_load_font
// which supports loading all kinds of TrueType fonts supported by the FreeType library.
// If you instead pass the filename of a bitmap file, it will be loaded with
// al_load_bitmap and a font in Allegro’s bitmap font format will be created from
// it with al_grab_font_from_bitmap.
Font :: struct {}
Font_Glyph :: struct {
    bitmap: ^Bitmap,
    x,y,w,h,kerning,offset_x,offset_y,advance: c.int,
}
Font_Flags :: enum c.int {
    NONE = 0,
    NO_KERNING       = -1,
}
Font_Alignment :: enum c.int {
    ALIGN_LEFT       = 0,
    ALIGN_CENTRE     = 1,
    ALIGN_CENTER     = 1,
    ALIGN_RIGHT      = 2,
    ALIGN_INTEGER    = 4,
}
Font_Justified_Flags :: enum c.int {
    NONE = 0,
    ALIGN_INTEGER = 4,
}


@(default_calling_convention="c")
foreign lib {
    @(link_name="al_init_font_addon")
    font_install :: proc() -> c.bool ---
    @(link_name="al_is_font_addon_initialized")
    font_is_installed :: proc() -> c.bool ---
    @(link_name="al_init_ttf_addon")
    font_ttf_install :: proc() -> c.bool ---
    @(link_name="al_is_ttf_addon_initialized")
    font_ttf_is_installed :: proc() -> c.bool ---

    @(link_name="al_load_bitmap_font_flags")
    font_load_bmp :: proc(filename: cstring, flags: c.int) -> ^Font ---
    @(link_name="al_load_ttf_font")
    font_load_ttf :: proc(filename: cstring, font_size, flags: c.int) -> ^Font ---
    @(link_name="al_create_builtin_font")
    font_load_builtin :: proc() -> ^Font ---

    // Sometimes, the al_get_text_width and al_get_font_line_height
    // functions are not enough for exact text placement, so this
    // function returns some additional information.
    //
    // Returned variables (all in pixels):
    //
    // x, y - Offset to upper left corner of bounding box.
    //
    // w, h - Dimensions of bounding box.
    //
    // Note that glyphs may go to the left and upwards of
    // the X, in which case x and y will have negative values.
    @(link_name="al_get_text_dimensions")
    font_measure_string :: proc(font: ^Font, text: cstring, OUT_x, OUT_y, OUT_w, OUT_h: ^c.int) ---
    // This function does not support newline characters (\n), but you can use al_draw_multiline_text
    // for multi line text output.
    @(link_name="al_draw_text")
    font_draw :: proc(font: ^Font, color: Color, x,y: c.float, flags: Font_Alignment, text: cstring) ---
    // The max_spacing parameter is the maximum amount of horizontal space to allow between words.
    // If justisfying the text would exceed max_spacing pixels, or the string contains less than
    // two words, then the string will be drawn left aligned.
    @(link_name="al_draw_justified_text")
    font_draw_justified :: proc(font: ^Font, color: Color, x_start, x_end, y, max_spacing: c.float, flags: Font_Justified_Flags, text: cstring) ---
    // Gets all the information about a glyph, including the bitmap,
    // needed to draw it yourself. prev_codepoint is the codepoint
    // in the string before the one you want to draw and is used
    // for kerning. codepoint is the character you want to get info
    // about. You should clear the ‘glyph’ structure to 0 with memset
    // before passing it to this function for future compatibility.
    @(link_name="al_get_glyph")
    font_get_glyph :: proc(font: ^Font, previous_codepoint, codepoint: c.int, OUT_glyph: ^Font_Glyph) -> ^Font ---
    @(link_name="al_draw_glyph")
    font_draw_glyph :: proc(font: ^Font, color: Color, x,y : c.float, codepoint: c.int) ---
    @(link_name="al_get_glyph_width")
    font_get_glyph_width :: proc(font: ^Font, codepoint: c.int) -> c.int ---
}