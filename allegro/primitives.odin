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

ALLEGRO_VERTEX_CACHE_SIZE :: 256
ALLEGRO_PRIM_QUALITY :: 10


Primitive_Type :: enum c.int {
    LINE_LIST,
    LINE_STRIP,
    LINE_LOOP,
    TRIANGLE_LIST,
    TRIANGLE_STRIP,
    TRIANGLE_FAN,
    POINT_LIST,
    NUM_TYPES,
}
Primitive_Storage :: enum c.int {
    FLOAT_2,
    FLOAT_3,
    SHORT_2,
    FLOAT_1,
    FLOAT_4,
    UBYTE_4,
    SHORT_4,
    NORMALIZED_UBYTE_4,
    NORMALIZED_SHORT_2,
    NORMALIZED_SHORT_4,
    NORMALIZED_USHORT_2,
    NORMALIZED_USHORT_4,
    HALF_FLOAT_2,
    HALF_FLOAT_4,
}
Primitive_Attribute :: enum c.int {
    POSITION = 1,
    COLOR_ATTR,
    TEX_COORD,
    TEX_COORD_PIXEL,
}

Line_Join :: enum c.int {
    JOIN_NONE,
    JOIN_BEVEL,
    JOIN_ROUND,
    JOIN_MITER,
}
Line_Cap :: enum c.int {
    NONE,
    SQUARE,
    ROUND,
    TRIANGLE,
    CLOSED,
}
Primitive_Buffer_Flags :: enum c.int {
    STREAM       = 0x01,
    STATIC       = 0x02,
    DYNAMIC      = 0x04,
    READWRITE    = 0x08,
}

Vertex :: struct {
    x,y,z,u,v: c.float,
    color: Color,
}
Vertex_Buffer :: struct {}
Index_Buffer :: struct {}
Vertex_Element :: struct {
    attribute, storage, offset: c.int,
}
Vertex_Declaration :: struct {}


@(default_calling_convention="c")
foreign lib {
    @(link_name="al_init_primitives_addon")
    prim_install :: proc() -> c.bool ---
    @(link_name="al_shutdown_primitives_addon")
    prim_shutdown :: proc() ---
    @(link_name="al_draw_prim")
    prim_raw :: proc(verts: [^]Vertex, decl: rawptr, texture: ^Bitmap, start, end: c.int, prim_type: Primitive_Type) -> c.int ---
    @(link_name="al_draw_line")
    prim_line :: proc(x1, y1, x2, y2: c.float, color: Color, thickness: c.float) ---
    @(link_name="al_create_vertex_buffer")
    prim_create_vbuff :: proc(decl: ^Vertex_Declaration, initial_data: rawptr, num_verts: c.int, flag: Primitive_Buffer_Flags) -> ^Vertex_Buffer ---
    @(link_name="al_destroy_vertex_buffer")
    prim_destroy_vbuff :: proc(buff: ^Vertex_Buffer) ---
    @(link_name="al_lock_vertex_buffer")
    prim_lock_vbuff :: proc(buff: ^Vertex_Buffer, start, length: c.int, flag: Locked_Region_Mode) -> rawptr ---
    @(link_name="al_unlock_vertex_buffer")
    prim_unlock_vbuff :: proc(buff: ^Vertex_Buffer) ---
    @(link_name="al_create_index_buffer")
    prim_create_ibuff :: proc(index_size: c.int, initial_data: rawptr, num_indices: c.int, flag: Primitive_Buffer_Flags) -> ^Index_Buffer ---
    @(link_name="al_destroy_index_buffer")
    prim_destroy_ibuff :: proc(buff: ^Index_Buffer) ---
    @(link_name="al_lock_index_buffer")
    prim_lock_ibuff :: proc(buff: ^Index_Buffer, start, length: c.int, flag: Locked_Region_Mode) -> rawptr ---
    @(link_name="al_unlock_index_buffer")
    prim_unlock_ibuff :: proc(buff: ^Index_Buffer) ---
    @(link_name="al_draw_indexed_buffer")
    prim_draw_indexed_buffer :: proc(vert_buff: ^Vertex_Buffer, texture: ^Bitmap, index_buff: ^Index_Buffer, start, end: c.int, style: Primitive_Type) -> c.int ---
}