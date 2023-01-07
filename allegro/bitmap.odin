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


Bitmap :: struct {}
Locked_Region :: struct {
    data: rawptr,
    format: Pixel_Format,
    pitch: c.int,
    pixel_size: c.int,
}
Locked_Region_Mode :: enum c.int {
    READWRITE  = 0,
    READONLY   = 1,
    WRITEONLY  = 2,
}
Bitmap_Wrap :: enum c.int {
    DEFAULT = 0,
    REPEAT = 1,
    CLAMP = 2,
    MIRROR = 3,
}
Bitmap_Flag :: enum c.int {
    NONE = 0,
    MEMORY_BITMAP            = 0x0001,
    NO_PRESERVE_TEXTURE      = 0x0008,
    MIN_LINEAR               = 0x0040,
    MAG_LINEAR               = 0x0080,
    MIPMAP                   = 0x0100,
    VIDEO_BITMAP             = 0x0400,
    CONVERT_BITMAP           = 0x1000,
}
Bitmap_Blend_Op :: enum c.int {
    ADD                = 0,
    SRC_MINUS_DEST     = 1,
    DEST_MINUS_SRC     = 2,
    NUM_BLEND_OPERATIONS,
}
Bitmap_Blend_Mode :: enum c.int {
    ZERO                = 0,
    ONE                 = 1,
    ALPHA               = 2,
    INVERSE_ALPHA       = 3,
    SRC_COLOR           = 4,
    DEST_COLOR          = 5,
    INVERSE_SRC_COLOR   = 6,
    INVERSE_DEST_COLOR  = 7,
    CONST_COLOR         = 8,
    INVERSE_CONST_COLOR = 9,
    NUM_BLEND_MODES,
}

@(default_calling_convention="c")
foreign lib {
    @(link_name="al_init_image_addon")
    image_install :: proc() -> c.bool ---
    @(link_name="al_get_bitmap_width")
    bitmap_get_width :: proc(bmp: ^Bitmap) -> c.int ---
    @(link_name="al_get_bitmap_height")
    bitmap_get_height :: proc(bmp: ^Bitmap) -> c.int ---
    @(link_name="al_create_bitmap")
    bitmap_create :: proc(x, y: c.int) -> ^Bitmap ---
    @(link_name="al_destroy_bitmap")
    bitmap_destroy :: proc(bmp: ^Bitmap) ---
    // Get a pixel’s color value from the specified bitmap. This
    // operation is slow on non-memory bitmaps. Consider locking
    // the bitmap if you are going to use this function multiple
    // times on the same bitmap.
    @(link_name="al_get_pixel")
    bitmap_get_pixel :: proc(bmp: ^Bitmap, x, y: c.int) -> Color ---
    @(link_name="al_get_bitmap_format")
    bitmap_get_format :: proc(bmp: ^Bitmap) -> c.int ---
    @(link_name="al_set_clipping_rectangle")
    clip_rect_set :: proc(x, y, width, height: c.int) ---
    @(link_name="al_reset_clipping_rectangle")
    clip_rect_reset :: proc() ---
    @(link_name="al_get_clipping_rectangle")
    clip_rect_get :: proc(OUX_x, OUT_y, OUT_w, OUT_h: ^c.int) ---
    @(link_name="al_clone_bitmap")
    bitmap_clone :: proc(bmp: ^Bitmap) -> ^Bitmap ---
    @(link_name="al_load_bitmap")
    bitmap_load :: proc(path: cstring) -> ^Bitmap ---
    @(link_name="al_get_target_bitmap")
    bitmap_get_target :: proc() -> ^Bitmap ---
    // This function selects the bitmap to which all subsequent drawing
    // operations in the calling thread will draw to. To return to drawing
    // to a display, set the backbuffer of the display as the target bitmap,
    // using al_get_backbuffer. As a convenience, you may also use al_set_target_backbuffer.
    //
    // Each allegro bitmap maintains two transformation matrices
    // associated with it for drawing onto the bitmap. There is a view matrix 
    // and a projection matrix. When you call al_set_target_bitmap, these will
    // be made current for the bitmap, affecting global OpenGL and DirectX states
    // depending on the driver in use.
    // 
    // Each video bitmap is tied to a display. When a video bitmap is set to as
    // the target bitmap, the display that the bitmap belongs to is automatically
    // made “current” for the calling thread (if it is not current already). Then
    // drawing other bitmaps which are tied to the same display can be hardware accelerated.
    // 
    // A single display cannot be current for multiple threads simultaneously.
    // If you need to release a display, so it is not current for the calling thread,
    // call al_set_target_bitmap(NULL);
    // 
    // Setting a memory bitmap as the target bitmap will not change which display
    // is current for the calling thread.
    // 
    // On some platforms, Allegro automatically backs up the contents of
    // video bitmaps because they may be occasionally lost (see discussion in
    // al_create_bitmap’s documentation). If you’re completely recreating
    // the bitmap contents often (e.g. every frame) then you will get much
    // better performance by creating the target bitmap with ALLEGRO_NO_PRESERVE_TEXTURE flag.
    @(link_name="al_set_target_bitmap")
    bitmap_target :: proc(bmp: ^Bitmap) ---
    // Lock an entire bitmap for reading or writing. If the bitmap is a display bitmap
    // it will be updated from system memory after the bitmap is unlocked
    // (unless locked read only). Returns NULL if the bitmap cannot be locked,
    // e.g. the bitmap was locked previously and not unlocked. This function also
    // returns NULL if the format is a compressed format.
    @(link_name="al_lock_bitmap")
    bitmap_lock :: proc(bmp: ^Bitmap, format: Pixel_Format, flags: Locked_Region_Mode) -> ^Locked_Region ---
    @(link_name="al_unlock_bitmap")
    bitmap_unlock :: proc(bmp: ^Bitmap) ---
    // Draws the bitmap into the current bitmap target (or backbuffer)
    @(link_name="al_draw_bitmap")
    bitmap_draw :: proc(bmp: ^Bitmap, dx, dy: c.float, flags: c.int) ---
    // Draw a single pixel on the target bitmap. This operation
    // is slow on non-memory bitmaps. Consider locking the bitmap if you
    // are going to use this function multiple times on the same bitmap. This
    // function is not affected by the transformations or the color blenders.
    @(link_name="al_put_pixel")
    bitmap_put_pixel :: proc(dx, dy: c.int, color: Color) ---
    // Draws a single pixel at x, y. This function, unlike bitmap_put_pixel,
    // does blending and, unlike al_put_blended_pixel,
    // respects the transformations (that is, the pixel’s position is transformed,
    // but its size is unaffected - it remains a pixel). This function can be slow
    // if called often; if you need to draw a lot of pixels consider using al_draw_prim
    // with POINT_LIST from the primitives addon.
    @(link_name="al_draw_pixel")
    bitmap_set_pixel :: proc(x, y: c.float, color: Color) ---
    // Clear the target bitmap, but confined by the clipping rectangle.
    @(link_name="al_clear_to_color")
    bitmap_clear :: proc(col: Color) ---
    @(link_name="al_set_new_bitmap_flags")
    bitmap_set_default_flags :: proc(flags: Bitmap_Flag) ---
    @(link_name="al_convert_bitmap")
    bitmap_convert_to_default :: proc(bmp: ^Bitmap) ---
    @(link_name="al_get_new_bitmap_format")
    bitmap_get_default_format :: proc() -> c.int ---
    @(link_name="al_set_new_bitmap_format")
    bitmap_set_default_format :: proc(format: Pixel_Format) ---
    @(link_name="al_add_new_bitmap_flags")
    bitmap_add_default_flag :: proc(flag: Bitmap_Flag) ---
    @(link_name="al_get_new_bitmap_flags")
    bitmap_get_default_flags :: proc() -> c.int ---
    @(link_name="al_set_separate_blender")
    separate_blend_set :: proc(op: Bitmap_Blend_Op, source: Bitmap_Blend_Mode, dest: Bitmap_Blend_Mode, a_op: Bitmap_Blend_Op, a_source: Bitmap_Blend_Mode, a_dest: Bitmap_Blend_Mode) ---
    @(link_name="al_set_blender")
    blend_set :: proc(op: Bitmap_Blend_Op, source: Bitmap_Blend_Mode, dest: Bitmap_Blend_Mode) ---
    @(link_name="al_get_blender")
    blend_get :: proc(OUT_op: ^Bitmap_Blend_Op, OUT_source: ^Bitmap_Blend_Mode, OUT_dest: ^Bitmap_Blend_Mode) ---
    @(link_name="al_set_blend_color")
    blend_set_color :: proc(color: Color) ---
    @(link_name="al_get_blend_color")
    blend_get_color :: proc() -> Color ---
}