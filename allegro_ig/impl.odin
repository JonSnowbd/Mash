package allegro_ig

import "../allegro"
import "core:c"
import "core:mem"
import "core:fmt"

when ODIN_DEBUG == true {
    whisper :: proc(msg: string) {
        fmt.printf("Imgui_Allegro: %s\n", msg)
    }
} else {
    whisper :: proc(msg: string) {}
}


ig_impl_settings :: struct {
    font_bytes: []u8,
}
ig_impl_context :: struct {
    display: ^allegro.Display,
    queue: ^allegro.Event_Queue,
    texture: ^allegro.Bitmap,

    i_buffer: ^allegro.Index_Buffer,
    v_buffer: ^allegro.Vertex_Buffer,
    temp_buffer: []allegro.Vertex,
}

// You can pass settings as nil to create default
allegro_ig_init :: proc (current_display: ^allegro.Display, settings: ^ig_impl_settings) -> ig_impl_context {
    using allegro
    whisper("Starting!")
    item: ig_impl_context = ---
    item.temp_buffer = make([]allegro.Vertex, 4096)
    item.v_buffer = prim_create_vbuff(nil, nil, 4096, .STREAM)
    item.i_buffer = prim_create_ibuff(size_of(Draw_Idx), nil, 4096*2, .STREAM)

    if item.v_buffer == nil || item.i_buffer == nil {
        panic("Failed to create buffers for imgui")
    }

    whisper("Creating queue...")
    item.queue = equeue_create()
    item.display = current_display
    equeue_register(item.queue, get_keyboard_source())
    equeue_register(item.queue, get_mouse_source())
    equeue_register(item.queue, display_get_event_source(item.display))

    whisper("Starting imgui setup...")
    // Initiate all objects
    ctx := igCreateContext(nil)
    igSetCurrentContext(ctx)
    io := igGetIO()
    io.backend_renderer_name = "Allegro5_Impl"
    io.ini_filename = "workspace"
    io.mouse_pos = {0, 0}
    io.display_size = {f32(allegro.display_get_width(current_display)), f32(allegro.display_get_height(current_display))}

    whisper("Creating font...")
    // Font
    font_pxls: ^u8 = nil
    font_w, font_h: i32
    ImFontAtlas_GetTexDataAsRGBA32(io.fonts, &font_pxls, &font_w, &font_h, nil)

    prev_flags := bitmap_get_default_flags()
    prev_format := bitmap_get_default_format()
    bitmap_set_default_flags(.MEMORY_BITMAP | .MIN_LINEAR | .MAG_LINEAR)
    bitmap_set_default_format(.ABGR_8888_LE)
    item.texture = bitmap_create(font_w, font_h)
    if item.texture == nil {
        panic("Failed to initialize the imgui font texture")
    }
    font_region := bitmap_lock(item.texture, .ABGR_8888_LE, .WRITEONLY)

    if font_region == nil {
        panic("Failed to lock the bitmap for imgui font texture. Are you calling this before init?")
    }

    font_region.data = mem.copy(font_region.data, font_pxls, int(size_of(c.uint) * font_w * font_h))
    bitmap_unlock(item.texture)
    bitmap_set_default_flags(.NONE)
    bitmap_convert_to_default(item.texture)
    bitmap_set_default_format(allegro.Pixel_Format(prev_format))
    io.fonts.tex_id = Texture_ID(item.texture)
    
    whisper("Binding keycodes...")
    // Mappings
    io.key_map[Key.Tab] = i32(Keycode.TAB)
    io.key_map[Key.Home] = i32(Keycode.HOME)
    io.key_map[Key.Insert] = i32(Keycode.INSERT)
    io.key_map[Key.KeyPadEnter] = i32(Keycode.PAD_ENTER)
    io.key_map[Key.Escape] = i32(Keycode.ESCAPE)
    io.key_map[Key.Backspace] = i32(Keycode.BACK)
    io.key_map[Key.End] = i32(Keycode.END)
    io.key_map[Key.Enter] = i32(Keycode.ENTER)

    io.key_map[Key.LeftArrow] = i32(Keycode.LEFT)
    io.key_map[Key.RightArrow] = i32(Keycode.RIGHT)
    io.key_map[Key.UpArrow] = i32(Keycode.UP)
    io.key_map[Key.DownArrow] = i32(Keycode.DOWN)

    io.key_map[Key.PageUp] = i32(Keycode.PGUP)
    io.key_map[Key.PageDown] = i32(Keycode.PGDN)
    io.key_map[Key.Space] = i32(Keycode.SPACE)
    io.key_map[Key.V] = i32(Keycode.V)
    io.key_map[Key.X] = i32(Keycode.X)
    io.key_map[Key.Z] = i32(Keycode.Z)
    io.key_map[Key.A] = i32(Keycode.A)
    io.key_map[Key.C] = i32(Keycode.C)

    whisper("Done!")
    return item
}

_evt :: proc(impl: ^ig_impl_context, evt: ^allegro.Event, io: ^IO) {
    #partial switch evt.evt_type {
        case .MOUSE_AXES: {
            io.mouse_pos = {f32(evt.mouse_evt.x), f32(evt.mouse_evt.y)}
            io.mouse_delta = {f32(evt.mouse_evt.dx), f32(evt.mouse_evt.dy)}
        }
        case .MOUSE_BUTTON_DOWN: {
            if evt.mouse_evt.button == 1 {
                io.mouse_down[Mouse_Button.Left] = true
            }
            if evt.mouse_evt.button == 2 {
                io.mouse_down[Mouse_Button.Right] = true
            }
        }
        case .MOUSE_BUTTON_UP: {
            if evt.mouse_evt.button == 1 {
                io.mouse_down[Mouse_Button.Left] = false
            }
            if evt.mouse_evt.button == 2 {
                io.mouse_down[Mouse_Button.Right] = false
            }
        }
        case .DISPLAY_RESIZE: {
            io.display_size = {f32(evt.display_evt.width), f32(evt.display_evt.height)}
        }
        case .KEY_CHAR: {
            ImGuiIO_AddInputCharacter(io, u32(evt.keyboard_evt.keycode))
        }
    }
}
allegro_ig_begin :: proc(impl: ^ig_impl_context) {
    using allegro
    evt: Event = ---
    io := igGetIO()
    for equeue_get_next_event(impl.queue, &evt) {
        _evt(impl, &evt, io)
    }
    igNewFrame()
}
// This will override the follow settings, its up to you
// to restore them for the next frames render:
//
// `al_use_transform`, it sets its own orthographic view.
//
// `al_set_blender`, it changes how blending works, but should be fine for games still.
allegro_ig_end :: proc(impl: ^ig_impl_context) {
    igRender()
    draw_data := igGetDrawData()
    if draw_data == nil {
        return
    }
    if draw_data.display_size.x <= 0.0 || draw_data.display_size.y <= 0.0 {
        return
    }

    L := draw_data.display_pos.x
    R := draw_data.display_pos.x + draw_data.display_size.x
    T := draw_data.display_pos.y
    B := draw_data.display_pos.y + draw_data.display_size.y

    allegro.separate_blend_set(.ADD, .ALPHA, .INVERSE_ALPHA, .ADD, .ONE, .INVERSE_ALPHA)

    // setup
    transform: allegro.Transform = ---
    allegro.transform_create_identity(&transform)
    allegro.transform_ortho(&transform, L, T, 1.0, R, B, -1.0)
    allegro.transform_use_projection(&transform)
    for n := i32(0); n < draw_data.cmd_lists_count; n+=1 {
        list : ^Draw_List = draw_data.cmd_lists[n]
        texture := transmute(^allegro.Bitmap)list._cmd_header.texture_id
        font_w := f32(allegro.bitmap_get_width(texture))
        font_h := f32(allegro.bitmap_get_height(texture))

        inds := allegro.prim_lock_ibuff(impl.i_buffer, 0, list.idx_buffer.size, .WRITEONLY)
        verts := allegro.prim_lock_vbuff(impl.v_buffer, 0, list.vtx_buffer.size, .WRITEONLY)

        if inds == nil || verts == nil {
            fmt.printf("FAILURE STATE: %i verts, %i inds\n", list.vtx_buffer.size, list.idx_buffer.size)
            panic("Failed to acquire a lock for ind/vert buffer")
        }
        for i:= i32(0); i < list.vtx_buffer.size; i+=1 {
            vert : Draw_Vert = list.vtx_buffer.data[i]
            colArr := transmute([4]u8)vert.col
            impl.temp_buffer[i] = {
                vert.pos.x,
                vert.pos.y,
                0.0,
                vert.uv.x*font_w,
                vert.uv.y*font_h,
                allegro.rgba(colArr[0],colArr[1],colArr[2],colArr[3]),
            }
        }
        mem.copy(verts, &impl.temp_buffer, int(size_of(allegro.Vertex) * list.vtx_buffer.size))
        mem.copy(inds, list.idx_buffer.data, int(size_of(Draw_Idx) * list.idx_buffer.size))
        
        allegro.prim_unlock_vbuff(impl.v_buffer)
        allegro.prim_unlock_ibuff(impl.i_buffer)
        allegro.prim_draw_indexed_buffer(impl.v_buffer, nil, impl.i_buffer, 0, list.idx_buffer.size, .TRIANGLE_LIST)
        // buffer := list.
    }
}