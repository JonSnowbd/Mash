package allegro_ig;

when ODIN_OS == .Windows {
	foreign import cimgui {
		"lib/cimgui.lib",
	}
}

//ImColor 
ImColor :: struct {
	value: ImVec4,
}

//ImDrawChannel 
Draw_Channel :: struct {
	_cmd_buffer: Im_Vector(Draw_Cmd),
	_idx_buffer: Im_Vector(Draw_Idx),
}

//ImDrawCmd 
Draw_Cmd :: struct {
	clip_rect:          ImVec4,
	texture_id:         Texture_ID,
	vtx_offset:         u32,
	idx_offset:         u32,
	elem_count:         u32,
	user_callback:      Draw_Callback,
	user_callback_data: rawptr,
}

//ImDrawCmdHeader 
Draw_Cmd_Header :: struct {
	clip_rect:  ImVec4,
	texture_id: Texture_ID,
	vtx_offset: u32,
}

//ImDrawData 
Draw_Data :: struct {
	valid:             bool,
	cmd_lists_count:   i32,
	total_idx_count:   i32,
	total_vtx_count:   i32,
	cmd_lists:         [^]^Draw_List,
	display_pos:       ImVec2,
	display_size:      ImVec2,
	framebuffer_scale: ImVec2,
}

//ImDrawList 
Draw_List :: struct {
	cmd_buffer:        Im_Vector(Draw_Cmd),
	idx_buffer:        Im_Vector(Draw_Idx),
	vtx_buffer:        Im_Vector(Draw_Vert),
	flags:             Draw_List_Flags,
	_vtx_current_idx:  u32,
	_data:             ^Draw_List_Shared_Data,
	_owner_name:       cstring,
	_vtx_write_ptr:    ^Draw_Vert,
	_idx_write_ptr:    ^Draw_Idx,
	_clip_rect_stack:  Im_Vector(ImVec4),
	_texture_id_stack: Im_Vector(Texture_ID),
	_path:             Im_Vector(ImVec2),
	_cmd_header:       Draw_Cmd_Header,
	_splitter:         Draw_List_Splitter,
	_fringe_scale:     f32,
}

//ImDrawListSplitter 
Draw_List_Splitter :: struct {
	_current:  i32,
	_count:    i32,
	_channels: Im_Vector(Draw_Channel),
}

//ImDrawVert 
Draw_Vert :: struct {
	pos: ImVec2,
	uv:  ImVec2,
	col: u32,
}

//ImFont 
ImFont :: struct {
	index_advance_x:       Im_Vector(f32),
	fallback_advance_x:    f32,
	font_size:             f32,
	index_lookup:          Im_Vector(Wchar),
	glyphs:                Im_Vector(Font_Glyph),
	fallback_glyph:        ^Font_Glyph,
	container_atlas:       ^Font_Atlas,
	config_data:           ^Font_Config,
	config_data_count:     i16,
	fallback_char:         Wchar,
	ellipsis_char:         Wchar,
	dirty_lookup_tables:   bool,
	scale:                 f32,
	ascent:                f32,
	descent:               f32,
	metrics_total_surface: i32,
	used4k_pages_map:      [2]u8,
}

//ImFontAtlas 
Font_Atlas :: struct {
	flags:                 Font_Atlas_Flags,
	tex_id:                Texture_ID,
	tex_desired_width:     i32,
	tex_glyph_padding:     i32,
	locked:                bool,
	tex_pixels_use_colors: bool,
	tex_pixels_alpha8:     ^u8,
	tex_pixels_rgba32:     ^u32,
	tex_width:             i32,
	tex_height:            i32,
	tex_uv_scale:          ImVec2,
	tex_uv_white_pixel:    ImVec2,
	fonts:                 Im_Vector(^ImFont),
	custom_rects:          Im_Vector(Font_Atlas_Custom_Rect),
	config_data:           Im_Vector(Font_Config),
	tex_uv_lines:          [64]ImVec4,
	font_builder_io:       ^Font_Builder_Io,
	font_builder_flags:    u32,
	pack_id_mouse_cursors: i32,
	pack_id_lines:         i32,
}

//ImFontAtlasCustomRect 
Font_Atlas_Custom_Rect :: struct {
	width:           u16,
	height:          u16,
	x:               u16,
	y:               u16,
	glyph_id:        u32,
	glyph_advance_x: f32,
	glyph_offset:    ImVec2,
	font:            ^ImFont,
}

//ImFontConfig 
Font_Config :: struct {
	font_data:                rawptr,
	font_data_size:           i32,
	font_data_owned_by_atlas: bool,
	font_no:                  i32,
	size_pixels:              f32,
	oversample_h:             i32,
	oversample_v:             i32,
	pixel_snap_h:             bool,
	glyph_extra_spacing:      ImVec2,
	glyph_offset:             ImVec2,
	glyph_ranges:             ^Wchar,
	glyph_min_advance_x:      f32,
	glyph_max_advance_x:      f32,
	merge_mode:               bool,
	font_builder_flags:       u32,
	rasterizer_multiply:      f32,
	ellipsis_char:            Wchar,
	name:                     [40]i8,
	dst_font:                 ^ImFont,
}

//ImFontGlyphRangesBuilder 
Font_Glyph_Ranges_Builder :: struct {
	used_chars: Im_Vector(u32),
}

//ImGuiIO 
IO :: struct {
	config_flags:                            Config_Flags,
	backend_flags:                           Backend_Flags,
	display_size:                            ImVec2,
	delta_time:                              f32,
	ini_saving_rate:                         f32,
	ini_filename:                            cstring,
	log_filename:                            cstring,
	mouse_double_click_time:                 f32,
	mouse_double_click_max_dist:             f32,
	mouse_drag_threshold:                    f32,
	key_map:                                 [22]i32,
	key_repeat_delay:                        f32,
	key_repeat_rate:                         f32,
	user_data:                               rawptr,
	fonts:                                   ^Font_Atlas,
	font_global_scale:                       f32,
	font_allow_user_scaling:                 bool,
	font_default:                            ^ImFont,
	display_framebuffer_scale:               ImVec2,
	mouse_draw_cursor:                       bool,
	config_mac_osx_behaviors:                bool,
	config_input_text_cursor_blink:          bool,
	config_drag_click_to_input_text:         bool,
	config_windows_resize_from_edges:        bool,
	config_windows_move_from_title_bar_only: bool,
	config_memory_compact_timer:             f32,
	backend_platform_name:                   cstring,
	backend_renderer_name:                   cstring,
	backend_platform_user_data:              rawptr,
	backend_renderer_user_data:              rawptr,
	backend_language_user_data:              rawptr,
	get_clipboard_text_fn:                   proc "c"(user_data : rawptr) -> cstring,
	set_clipboard_text_fn:                   proc "c"(user_data : rawptr, text : cstring),
	clipboard_user_data:                     rawptr,
	ime_set_input_screen_pos_fn:             proc "c"(x, y : i32),
	ime_window_handle:                       rawptr,
	mouse_pos:                               ImVec2,
	mouse_down:                              [5]bool,
	mouse_wheel:                             f32,
	mouse_wheel_h:                           f32,
	key_ctrl:                                bool,
	key_shift:                               bool,
	key_alt:                                 bool,
	key_super:                               bool,
	keys_down:                               [512]bool,
	nav_inputs:                              [21]f32,
	want_capture_mouse:                      bool,
	want_capture_keyboard:                   bool,
	want_text_input:                         bool,
	want_set_mouse_pos:                      bool,
	want_save_ini_settings:                  bool,
	nav_active:                              bool,
	nav_visible:                             bool,
	framerate:                               f32,
	metrics_render_vertices:                 i32,
	metrics_render_indices:                  i32,
	metrics_render_windows:                  i32,
	metrics_active_windows:                  i32,
	metrics_active_allocations:              i32,
	mouse_delta:                             ImVec2,
	key_mods:                                Key_Mod_Flags,
	mouse_pos_prev:                          ImVec2,
	mouse_clicked_pos:                       [5]ImVec2,
	mouse_clicked_time:                      [5]f64,
	mouse_clicked:                           [5]bool,
	mouse_double_clicked:                    [5]bool,
	mouse_released:                          [5]bool,
	mouse_down_owned:                        [5]bool,
	mouse_down_was_double_click:             [5]bool,
	mouse_down_duration:                     [5]f32,
	mouse_down_duration_prev:                [5]f32,
	mouse_drag_max_distance_abs:             [5]ImVec2,
	mouse_drag_max_distance_sqr:             [5]f32,
	keys_down_duration:                      [512]f32,
	keys_down_duration_prev:                 [512]f32,
	nav_inputs_down_duration:                [21]f32,
	nav_inputs_down_duration_prev:           [21]f32,
	pen_pressure:                            f32,
	input_queue_surrogate:                   Wchar16,
	input_queue_characters:                  Im_Vector(Wchar),
}

//ImGuiInputTextCallbackData 
Input_Text_Callback_Data :: struct {
	event_flag:      Input_Text_Flags,
	flags:           Input_Text_Flags,
	user_data:       rawptr,
	event_char:      Wchar,
	event_key:       Key,
	buf:             cstring,
	buf_text_len:    i32,
	buf_size:        i32,
	buf_dirty:       bool,
	cursor_pos:      i32,
	selection_start: i32,
	selection_end:   i32,
}

//ImGuiListClipper 
List_Clipper :: struct {
	display_start: i32,
	display_end:   i32,
	items_count:   i32,
	step_no:       i32,
	items_frozen:  i32,
	items_height:  f32,
	start_pos_y:   f32,
}

//ImGuiOnceUponAFrame 
Once_Upon_A_Frame :: struct {
	ref_frame: i32,
}

//ImGuiPayload 
Payload :: struct {
	data:             rawptr,
	data_size:        i32,
	source_id:        ImID,
	source_parent_id: ImID,
	data_frame_count: i32,
	data_type:        [33]i8,
	preview:          bool,
	delivery:         bool,
}

//ImGuiSizeCallbackData 
Size_Callback_Data :: struct {
	user_data:    rawptr,
	pos:          ImVec2,
	current_size: ImVec2,
	desired_size: ImVec2,
}

//ImGuiStorage 
Storage :: struct {
	data: Im_Vector(Storage_Pair),
}

Storage_Pair :: struct {
    key: ImID,
    using _: struct #raw_union { 
        val_i: i32, 
        val_f: f32, 
        val_p: rawptr,
    },
}

Font_Glyph :: struct {
	colored:   u32,
	visible:   u32,
	codepoint: u32,
	advance_x: f32,
	x0:        f32,
	y0:        f32,
	x1:        f32,
	y1:        f32,
	u0:        f32,
	v0:        f32,
	u1:        f32,
	v1:        f32,
}

//ImGuiStyle 
Style :: struct {
	alpha:                          f32,
	window_padding:                 ImVec2,
	window_rounding:                f32,
	window_border_size:             f32,
	window_min_size:                ImVec2,
	window_title_align:             ImVec2,
	window_menu_button_position:    Dir,
	child_rounding:                 f32,
	child_border_size:              f32,
	popup_rounding:                 f32,
	popup_border_size:              f32,
	frame_padding:                  ImVec2,
	frame_rounding:                 f32,
	frame_border_size:              f32,
	item_spacing:                   ImVec2,
	item_inner_spacing:             ImVec2,
	cell_padding:                   ImVec2,
	touch_extra_padding:            ImVec2,
	indent_spacing:                 f32,
	columns_min_spacing:            f32,
	scrollbar_size:                 f32,
	scrollbar_rounding:             f32,
	grab_min_size:                  f32,
	grab_rounding:                  f32,
	log_slider_deadzone:            f32,
	tab_rounding:                   f32,
	tab_border_size:                f32,
	tab_min_width_for_close_button: f32,
	color_button_position:          Dir,
	button_text_align:              ImVec2,
	selectable_text_align:          ImVec2,
	display_window_padding:         ImVec2,
	display_safe_area_padding:      ImVec2,
	mouse_cursor_scale:             f32,
	anti_aliased_lines:             bool,
	anti_aliased_lines_use_tex:     bool,
	anti_aliased_fill:              bool,
	curve_tessellation_tol:         f32,
	circle_tessellation_max_error:  f32,
	colors:                         [53]ImVec4,
}

//ImGuiTableColumnSortSpecs 
Table_Column_Sort_Specs :: struct {
	column_user_id: ImID,
	column_index:   i16,
	sort_order:     i16,
	sort_direction: Sort_Direction,
}

//ImGuiTableSortSpecs 
Table_Sort_Specs :: struct {
	specs:       ^Table_Column_Sort_Specs,
	specs_count: i32,
	specs_dirty: bool,
}

//ImGuiTextBuffer 
Text_Buffer :: struct {
	buf: Im_Vector(u8),
}

//ImGuiTextFilter 
Text_Filter :: struct {
	input_buf:  [256]i8,
	filters:    Im_Vector(Text_Range),
	count_grep: i32,
}

//ImGuiTextRange 
Text_Range :: struct {
	b: cstring,
	e: cstring,
}

//ImGuiViewport 
Viewport :: struct {
	flags:     Viewport_Flags,
	pos:       ImVec2,
	size:      ImVec2,
	work_pos:  ImVec2,
	work_size: ImVec2,
}

//ImImVec2 
ImVec2 :: struct {
	x: f32,
	y: f32,
}

//ImVec4 
ImVec4 :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}


ImID :: distinct u32;

Draw_Idx :: distinct u16;

Wchar :: distinct u16;

Wchar16 :: distinct u16;

Wchar32 :: distinct u32;

Texture_ID :: distinct rawptr;

File_Handle :: distinct uintptr;

Alloc_Func :: #type proc "c" (size: i64, user_data: rawptr) -> rawptr;

Free_Func :: #type proc "c" (ptr: rawptr, user_data: rawptr);

Mem_Alloc_Func :: #type proc "c" (size: i64, user_data: rawptr) -> rawptr;

Mem_Free_Func :: #type proc "c" (ptr: rawptr, user_data: rawptr);

Items_Getter_Proc :: #type proc "c" (data: rawptr, idx: i32, out_text: ^cstring) -> bool;

Value_Getter_Proc :: #type proc "c" (data: rawptr, idx: i32) -> f32;

Draw_Callback :: #type proc "c" (parent_list: ^Draw_List, cmd: ^Draw_Cmd);

Input_Text_Callback :: #type proc "c" (data: ^Input_Text_Callback_Data) -> int;

Size_Callback :: #type proc "c" (data: ^Size_Callback_Data);

Draw_List_Shared_Data :: struct {};

Context :: struct {};

Font_Builder_Io :: struct {};

Im_Vector :: struct(T : typeid) {
    size:     i32, 
    capacity: i32,
    data:     [^]T,
}

Draw_Flags :: enum i32 {
	None                    = 0,
	Closed                  = 1 << 0,
	RoundCornersTopLeft     = 1 << 4,
	RoundCornersTopRight    = 1 << 5,
	RoundCornersBottomLeft  = 1 << 6,
	RoundCornersBottomRight = 1 << 7,
	RoundCornersNone        = 1 << 8,
	RoundCornersTop         = RoundCornersTopLeft | RoundCornersTopRight,
	RoundCornersBottom      = RoundCornersBottomLeft | RoundCornersBottomRight,
	RoundCornersLeft        = RoundCornersBottomLeft | RoundCornersTopLeft,
	RoundCornersRight       = RoundCornersBottomRight | RoundCornersTopRight,
	RoundCornersAll         = RoundCornersTopLeft | RoundCornersTopRight | RoundCornersBottomLeft | RoundCornersBottomRight,
	RoundCornersDefault     = RoundCornersAll,
	RoundCornersMask        = RoundCornersAll | RoundCornersNone,
}

Draw_List_Flags :: enum i32 {
	None                   = 0,
	AntiAliasedLines       = 1 << 0,
	AntiAliasedLinesUseTex = 1 << 1,
	AntiAliasedFill        = 1 << 2,
	AllowVtxOffset         = 1 << 3,
}

Font_Atlas_Flags :: enum i32 {
	None               = 0,
	NoPowerOfTwoHeight = 1 << 0,
	NoMouseCursors     = 1 << 1,
	NoBakedLines       = 1 << 2,
}

Backend_Flags :: enum i32 {
	None                 = 0,
	HasGamepad           = 1 << 0,
	HasMouseCursors      = 1 << 1,
	HasSetMousePos       = 1 << 2,
	RendererHasVtxOffset = 1 << 3,
}

Button_Flags :: enum i32 {
	None               = 0,
	MouseButtonLeft    = 1 << 0,
	MouseButtonRight   = 1 << 1,
	MouseButtonMiddle  = 1 << 2,
	MouseButtonMask    = MouseButtonLeft | MouseButtonRight | MouseButtonMiddle,
	MouseButtonDefault = MouseButtonLeft,
}

Col :: enum i32 {
	Text                  = 0,
	TextDisabled          = 1,
	WindowBg              = 2,
	ChildBg               = 3,
	PopupBg               = 4,
	Border                = 5,
	BorderShadow          = 6,
	FrameBg               = 7,
	FrameBgHovered        = 8,
	FrameBgActive         = 9,
	TitleBg               = 10,
	TitleBgActive         = 11,
	TitleBgCollapsed      = 12,
	MenuBarBg             = 13,
	ScrollbarBg           = 14,
	ScrollbarGrab         = 15,
	ScrollbarGrabHovered  = 16,
	ScrollbarGrabActive   = 17,
	CheckMark             = 18,
	SliderGrab            = 19,
	SliderGrabActive      = 20,
	Button                = 21,
	ButtonHovered         = 22,
	ButtonActive          = 23,
	Header                = 24,
	HeaderHovered         = 25,
	HeaderActive          = 26,
	Separator             = 27,
	SeparatorHovered      = 28,
	SeparatorActive       = 29,
	ResizeGrip            = 30,
	ResizeGripHovered     = 31,
	ResizeGripActive      = 32,
	Tab                   = 33,
	TabHovered            = 34,
	TabActive             = 35,
	TabUnfocused          = 36,
	TabUnfocusedActive    = 37,
	PlotLines             = 38,
	PlotLinesHovered      = 39,
	PlotHistogram         = 40,
	PlotHistogramHovered  = 41,
	TableHeaderBg         = 42,
	TableBorderStrong     = 43,
	TableBorderLight      = 44,
	TableRowBg            = 45,
	TableRowBgAlt         = 46,
	TextSelectedBg        = 47,
	DragDropTarget        = 48,
	NavHighlight          = 49,
	NavWindowingHighlight = 50,
	NavWindowingDimBg     = 51,
	ModalWindowDimBg      = 52,
	Count                 = 53,
}

Color_Edit_Flags :: enum i32 {
	None             = 0,
	NoAlpha          = 1 << 1,
	NoPicker         = 1 << 2,
	NoOptions        = 1 << 3,
	NoSmallPreview   = 1 << 4,
	NoInputs         = 1 << 5,
	NoTooltip        = 1 << 6,
	NoLabel          = 1 << 7,
	NoSidePreview    = 1 << 8,
	NoDragDrop       = 1 << 9,
	NoBorder         = 1 << 10,
	AlphaBar         = 1 << 16,
	AlphaPreview     = 1 << 17,
	AlphaPreviewHalf = 1 << 18,
	Hdr              = 1 << 19,
	DisplayRgb       = 1 << 20,
	DisplayHsv       = 1 << 21,
	DisplayHex       = 1 << 22,
	Uint8            = 1 << 23,
	Float            = 1 << 24,
	PickerHueBar     = 1 << 25,
	PickerHueWheel   = 1 << 26,
	InputRgb         = 1 << 27,
	InputHsv         = 1 << 28,
	OptionsDefault   = Uint8 | DisplayRgb | InputRgb | PickerHueBar,
	DisplayMask      = DisplayRgb | DisplayHsv | DisplayHex,
	DataTypeMask     = Uint8 | Float,
	PickerMask       = PickerHueWheel | PickerHueBar,
	InputMask        = InputRgb | InputHsv,
}

Combo_Flags :: enum i32 {
	None           = 0,
	PopupAlignLeft = 1 << 0,
	HeightSmall    = 1 << 1,
	HeightRegular  = 1 << 2,
	HeightLarge    = 1 << 3,
	HeightLargest  = 1 << 4,
	NoArrowButton  = 1 << 5,
	NoPreview      = 1 << 6,
	HeightMask     = HeightSmall | HeightRegular | HeightLarge | HeightLargest,
}

Cond :: enum i32 {
	None         = 0,
	Always       = 1 << 0,
	Once         = 1 << 1,
	FirstUseEver = 1 << 2,
	Appearing    = 1 << 3,
}

Config_Flags :: enum i32 {
	None                 = 0,
	NavEnableKeyboard    = 1 << 0,
	NavEnableGamepad     = 1 << 1,
	NavEnableSetMousePos = 1 << 2,
	NavNoCaptureKeyboard = 1 << 3,
	NoMouse              = 1 << 4,
	NoMouseCursorChange  = 1 << 5,
	IsSrgb               = 1 << 20,
	IsTouchScreen        = 1 << 21,
}

Data_Type :: enum i32 {
	S8     = 0,
	U8     = 1,
	S16    = 2,
	U16    = 3,
	S32    = 4,
	U32    = 5,
	S64    = 6,
	U64    = 7,
	Float  = 8,
	Double = 9,
	Count  = 10,
}

Dir :: enum i32 {
	None  = -1,
	Left  = 0,
	Right = 1,
	Up    = 2,
	Down  = 3,
	Count = 4,
}

Drag_Drop_Flags :: enum i32 {
	None                     = 0,
	SourceNoPreviewTooltip   = 1 << 0,
	SourceNoDisableHover     = 1 << 1,
	SourceNoHoldToOpenOthers = 1 << 2,
	SourceAllowNullId        = 1 << 3,
	SourceExtern             = 1 << 4,
	SourceAutoExpirePayload  = 1 << 5,
	AcceptBeforeDelivery     = 1 << 10,
	AcceptNoDrawDefaultRect  = 1 << 11,
	AcceptNoPreviewTooltip   = 1 << 12,
	AcceptPeekOnly           = AcceptBeforeDelivery | AcceptNoDrawDefaultRect,
}

Focused_Flags :: enum i32 {
	None                = 0,
	ChildWindows        = 1 << 0,
	RootWindow          = 1 << 1,
	AnyWindow           = 1 << 2,
	RootAndChildWindows = RootWindow | ChildWindows,
}

Hovered_Flags :: enum i32 {
	None                         = 0,
	ChildWindows                 = 1 << 0,
	RootWindow                   = 1 << 1,
	AnyWindow                    = 1 << 2,
	AllowWhenBlockedByPopup      = 1 << 3,
	AllowWhenBlockedByActiveItem = 1 << 5,
	AllowWhenOverlapped          = 1 << 6,
	AllowWhenDisabled            = 1 << 7,
	RectOnly                     = AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped,
	RootAndChildWindows          = RootWindow | ChildWindows,
}

Input_Text_Flags :: enum i32 {
	None                = 0,
	CharsDecimal        = 1 << 0,
	CharsHexadecimal    = 1 << 1,
	CharsUppercase      = 1 << 2,
	CharsNoBlank        = 1 << 3,
	AutoSelectAll       = 1 << 4,
	EnterReturnsTrue    = 1 << 5,
	CallbackCompletion  = 1 << 6,
	CallbackHistory     = 1 << 7,
	CallbackAlways      = 1 << 8,
	CallbackCharFilter  = 1 << 9,
	AllowTabInput       = 1 << 10,
	CtrlEnterForNewLine = 1 << 11,
	NoHorizontalScroll  = 1 << 12,
	AlwaysOverwrite     = 1 << 13,
	ReadOnly            = 1 << 14,
	Password            = 1 << 15,
	NoUndoRedo          = 1 << 16,
	CharsScientific     = 1 << 17,
	CallbackResize      = 1 << 18,
	CallbackEdit        = 1 << 19,
	Multiline           = 1 << 20,
	NoMarkEdited        = 1 << 21,
}

Key_Mod_Flags :: enum i32 {
	None  = 0,
	Ctrl  = 1 << 0,
	Shift = 1 << 1,
	Alt   = 1 << 2,
	Super = 1 << 3,
}

Key :: enum i32 {
	Tab         = 0,
	LeftArrow   = 1,
	RightArrow  = 2,
	UpArrow     = 3,
	DownArrow   = 4,
	PageUp      = 5,
	PageDown    = 6,
	Home        = 7,
	End         = 8,
	Insert      = 9,
	Delete      = 10,
	Backspace   = 11,
	Space       = 12,
	Enter       = 13,
	Escape      = 14,
	KeyPadEnter = 15,
	A           = 16,
	C           = 17,
	V           = 18,
	X           = 19,
	Y           = 20,
	Z           = 21,
	Count       = 22,
}

Mouse_Button :: enum i32 {
	Left   = 0,
	Right  = 1,
	Middle = 2,
	Count  = 5,
}

Mouse_Cursor :: enum i32 {
	None       = -1,
	Arrow      = 0,
	TextInput  = 1,
	ResizeAll  = 2,
	ResizeNs   = 3,
	ResizeEw   = 4,
	ResizeNesw = 5,
	ResizeNwse = 6,
	Hand       = 7,
	NotAllowed = 8,
	Count      = 9,
}

Nav_Input :: enum i32 {
	Activate      = 0,
	Cancel        = 1,
	Input         = 2,
	Menu          = 3,
	DpadLeft      = 4,
	DpadRight     = 5,
	DpadUp        = 6,
	DpadDown      = 7,
	LstickLeft    = 8,
	LstickRight   = 9,
	LstickUp      = 10,
	LstickDown    = 11,
	FocusPrev     = 12,
	FocusNext     = 13,
	TweakSlow     = 14,
	TweakFast     = 15,
	KeyMenu       = 16,
	KeyLeft       = 17,
	KeyRight      = 18,
	KeyUp         = 19,
	KeyDown       = 20,
	Count         = 21,
	InternalStart = KeyMenu,
}

Popup_Flags :: enum i32 {
	None                    = 0,
	MouseButtonLeft         = 0,
	MouseButtonRight        = 1,
	MouseButtonMiddle       = 2,
	MouseButtonMask         = 0x1F,
	MouseButtonDefault      = 1,
	NoOpenOverExistingPopup = 1 << 5,
	NoOpenOverItems         = 1 << 6,
	AnyPopupId              = 1 << 7,
	AnyPopupLevel           = 1 << 8,
	AnyPopup                = AnyPopupId | AnyPopupLevel,
}

Selectable_Flags :: enum i32 {
	None             = 0,
	DontClosePopups  = 1 << 0,
	SpanAllColumns   = 1 << 1,
	AllowDoubleClick = 1 << 2,
	Disabled         = 1 << 3,
	AllowItemOverlap = 1 << 4,
}

Slider_Flags :: enum i32 {
	None            = 0,
	AlwaysClamp     = 1 << 4,
	Logarithmic     = 1 << 5,
	NoRoundToFormat = 1 << 6,
	NoInput         = 1 << 7,
	InvalidMask     = 0x7000000F,
}

Sort_Direction :: enum i32 {
	None       = 0,
	Ascending  = 1,
	Descending = 2,
}

Style_Var :: enum i32 {
	Alpha               = 0,
	WindowPadding       = 1,
	WindowRounding      = 2,
	WindowBorderSize    = 3,
	WindowMinSize       = 4,
	WindowTitleAlign    = 5,
	ChildRounding       = 6,
	ChildBorderSize     = 7,
	PopupRounding       = 8,
	PopupBorderSize     = 9,
	FramePadding        = 10,
	FrameRounding       = 11,
	FrameBorderSize     = 12,
	ItemSpacing         = 13,
	ItemInnerSpacing    = 14,
	IndentSpacing       = 15,
	CellPadding         = 16,
	ScrollbarSize       = 17,
	ScrollbarRounding   = 18,
	GrabMinSize         = 19,
	GrabRounding        = 20,
	TabRounding         = 21,
	ButtonTextAlign     = 22,
	SelectableTextAlign = 23,
	Count               = 24,
}

Tab_Bar_Flags :: enum i32 {
	None                         = 0,
	Reorderable                  = 1 << 0,
	AutoSelectNewTabs            = 1 << 1,
	TabListPopupButton           = 1 << 2,
	NoCloseWithMiddleMouseButton = 1 << 3,
	NoTabListScrollingButtons    = 1 << 4,
	NoTooltip                    = 1 << 5,
	FittingPolicyResizeDown      = 1 << 6,
	FittingPolicyScroll          = 1 << 7,
	FittingPolicyMask            = FittingPolicyResizeDown | FittingPolicyScroll,
	FittingPolicyDefault         = FittingPolicyResizeDown,
}

Tab_Item_Flags :: enum i32 {
	None                         = 0,
	UnsavedDocument              = 1 << 0,
	SetSelected                  = 1 << 1,
	NoCloseWithMiddleMouseButton = 1 << 2,
	NoPushId                     = 1 << 3,
	NoTooltip                    = 1 << 4,
	NoReorder                    = 1 << 5,
	Leading                      = 1 << 6,
	Trailing                     = 1 << 7,
}

Table_Bg_Target :: enum i32 {
	None   = 0,
	RowBg0 = 1,
	RowBg1 = 2,
	CellBg = 3,
}

Table_Column_Flags :: enum i32 {
	None                 = 0,
	DefaultHide          = 1 << 0,
	DefaultSort          = 1 << 1,
	WidthStretch         = 1 << 2,
	WidthFixed           = 1 << 3,
	NoResize             = 1 << 4,
	NoReorder            = 1 << 5,
	NoHide               = 1 << 6,
	NoClip               = 1 << 7,
	NoSort               = 1 << 8,
	NoSortAscending      = 1 << 9,
	NoSortDescending     = 1 << 10,
	NoHeaderWidth        = 1 << 11,
	PreferSortAscending  = 1 << 12,
	PreferSortDescending = 1 << 13,
	IndentEnable         = 1 << 14,
	IndentDisable        = 1 << 15,
	IsEnabled            = 1 << 20,
	IsVisible            = 1 << 21,
	IsSorted             = 1 << 22,
	IsHovered            = 1 << 23,
	WidthMask            = WidthStretch | WidthFixed,
	IndentMask           = IndentEnable | IndentDisable,
	StatusMask           = IsEnabled | IsVisible | IsSorted | IsHovered,
	NoDirectResize       = 1 << 30,
}

Table_Flags :: enum i32 {
	None                       = 0,
	Resizable                  = 1 << 0,
	Reorderable                = 1 << 1,
	Hideable                   = 1 << 2,
	Sortable                   = 1 << 3,
	NoSavedSettings            = 1 << 4,
	ContextMenuInBody          = 1 << 5,
	RowBg                      = 1 << 6,
	BordersInnerH              = 1 << 7,
	BordersOuterH              = 1 << 8,
	BordersInnerV              = 1 << 9,
	BordersOuterV              = 1 << 10,
	BordersH                   = BordersInnerH | BordersOuterH,
	BordersV                   = BordersInnerV | BordersOuterV,
	BordersInner               = BordersInnerV | BordersInnerH,
	BordersOuter               = BordersOuterV | BordersOuterH,
	Borders                    = BordersInner | BordersOuter,
	NoBordersInBody            = 1 << 11,
	NoBordersInBodyUntilResize = 1 << 12,
	SizingFixedFit             = 1 << 13,
	SizingFixedSame            = 2 << 13,
	SizingStretchProp          = 3 << 13,
	SizingStretchSame          = 4 << 13,
	NoHostExtendX              = 1 << 16,
	NoHostExtendY              = 1 << 17,
	NoKeepColumnsVisible       = 1 << 18,
	PreciseWidths              = 1 << 19,
	NoClip                     = 1 << 20,
	PadOuterX                  = 1 << 21,
	NoPadOuterX                = 1 << 22,
	NoPadInnerX                = 1 << 23,
	ScrollX                    = 1 << 24,
	ScrollY                    = 1 << 25,
	SortMulti                  = 1 << 26,
	SortTristate               = 1 << 27,
	SizingMask                 = SizingFixedFit | SizingFixedSame | SizingStretchProp | SizingStretchSame,
}

Table_Row_Flags :: enum i32 {
	None    = 0,
	Headers = 1 << 0,
}

Tree_Node_Flags :: enum i32 {
	None                 = 0,
	Selected             = 1 << 0,
	Framed               = 1 << 1,
	AllowItemOverlap     = 1 << 2,
	NoTreePushOnOpen     = 1 << 3,
	NoAutoOpenOnLog      = 1 << 4,
	DefaultOpen          = 1 << 5,
	OpenOnDoubleClick    = 1 << 6,
	OpenOnArrow          = 1 << 7,
	Leaf                 = 1 << 8,
	Bullet               = 1 << 9,
	FramePadding         = 1 << 10,
	SpanAvailWidth       = 1 << 11,
	SpanFullWidth        = 1 << 12,
	NavLeftJumpsBackHere = 1 << 13,
	CollapsingHeader     = Framed | NoTreePushOnOpen | NoAutoOpenOnLog,
}

Viewport_Flags :: enum i32 {
	None              = 0,
	IsPlatformWindow  = 1 << 0,
	IsPlatformMonitor = 1 << 1,
	OwnedByApp        = 1 << 2,
}

Window_Flags :: enum i32 {
	None                      = 0,
	NoTitleBar                = 1 << 0,
	NoResize                  = 1 << 1,
	NoMove                    = 1 << 2,
	NoScrollbar               = 1 << 3,
	NoScrollWithMouse         = 1 << 4,
	NoCollapse                = 1 << 5,
	AlwaysAutoResize          = 1 << 6,
	NoBackground              = 1 << 7,
	NoSavedSettings           = 1 << 8,
	NoMouseInputs             = 1 << 9,
	MenuBar                   = 1 << 10,
	HorizontalScrollbar       = 1 << 11,
	NoFocusOnAppearing        = 1 << 12,
	NoBringToFrontOnFocus     = 1 << 13,
	AlwaysVerticalScrollbar   = 1 << 14,
	AlwaysHorizontalScrollbar = 1<< 15,
	AlwaysUseWindowPadding    = 1 << 16,
	NoNavInputs               = 1 << 18,
	NoNavFocus                = 1 << 19,
	UnsavedDocument           = 1 << 20,
	NoNav                     = NoNavInputs | NoNavFocus,
	NoDecoration              = NoTitleBar | NoResize | NoScrollbar | NoCollapse,
	NoInputs                  = NoMouseInputs | NoNavInputs | NoNavFocus,
	NavFlattened              = 1 << 23,
	ChildWindow               = 1 << 24,
	Tooltip                   = 1 << 25,
	Popup                     = 1 << 26,
	Modal                     = 1 << 27,
	ChildMenu                 = 1 << 28,
}

@(default_calling_convention="c")
foreign cimgui {
	ImColor_HSV    :: proc(pOut: ^ImColor, h: f32, s: f32, v: f32, a: f32) ---;
	ImColor_SetHSV :: proc(self: ^ImColor, h: f32, s: f32, v: f32, a: f32) ---;

	ImDrawData_Clear             :: proc(self: ^Draw_Data) ---;
	ImDrawData_DeIndexAllBuffers :: proc(self: ^Draw_Data) ---;
	ImDrawData_ScaleClipRects    :: proc(self: ^Draw_Data, fb_scale: ImVec2) ---;

	ImDrawListSplitter_Clear             :: proc(self: ^Draw_List_Splitter) ---;
	ImDrawListSplitter_ClearFreeMemory   :: proc(self: ^Draw_List_Splitter) ---;
	ImDrawListSplitter_Merge             :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List) ---;
	ImDrawListSplitter_SetCurrentChannel :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, channel_idx: i32) ---;
	ImDrawListSplitter_Split             :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, count: i32) ---;

	ImDrawList_AddBezierCubic              :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: u32, thickness: f32, num_segments: i32) ---;
	ImDrawList_AddBezierQuadratic          :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: u32, thickness: f32, num_segments: i32) ---;
	ImDrawList_AddCallback                 :: proc(self: ^Draw_List, callback: Draw_Callback, callback_data: rawptr) ---;
	ImDrawList_AddCircle                   :: proc(self: ^Draw_List, center: ImVec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;
	ImDrawList_AddCircleFilled             :: proc(self: ^Draw_List, center: ImVec2, radius: f32, col: u32, num_segments: i32) ---;
	ImDrawList_AddConvexPolyFilled         :: proc(self: ^Draw_List, points: ^ImVec2, num_points: i32, col: u32) ---;
	ImDrawList_AddDrawCmd                  :: proc(self: ^Draw_List) ---;
	ImDrawList_AddImage                    :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: u32) ---;
	ImDrawList_AddImageQuad                :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2, uv2: ImVec2, uv3: ImVec2, uv4: ImVec2, col: u32) ---;
	ImDrawList_AddImageRounded             :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: u32, rounding: f32, flags: Draw_Flags) ---;
	ImDrawList_AddLine                     :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, col: u32, thickness: f32) ---;
	ImDrawList_AddNgon                     :: proc(self: ^Draw_List, center: ImVec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;
	ImDrawList_AddNgonFilled               :: proc(self: ^Draw_List, center: ImVec2, radius: f32, col: u32, num_segments: i32) ---;
	ImDrawList_AddPolyline                 :: proc(self: ^Draw_List, points: ^ImVec2, num_points: i32, col: u32, flags: Draw_Flags, thickness: f32) ---;
	ImDrawList_AddQuad                     :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: u32, thickness: f32) ---;
	ImDrawList_AddQuadFilled               :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: u32) ---;
	ImDrawList_AddRect                     :: proc(self: ^Draw_List, p_min: ImVec2, p_max: ImVec2, col: u32, rounding: f32, flags: Draw_Flags, thickness: f32) ---;
	ImDrawList_AddRectFilled               :: proc(self: ^Draw_List, p_min: ImVec2, p_max: ImVec2, col: u32, rounding: f32, flags: Draw_Flags) ---;
	ImDrawList_AddRectFilledMultiColor     :: proc(self: ^Draw_List, p_min: ImVec2, p_max: ImVec2, col_upr_left: u32, col_upr_right: u32, col_bot_right: u32, col_bot_left: u32) ---;
	ImDrawList_AddText_ImVec2                :: proc(self: ^Draw_List, pos: ImVec2, col: u32, text_begin: cstring, text_end: cstring) ---;
	ImDrawList_AddText_FontPtr             :: proc(self: ^Draw_List, font: ^ImFont, font_size: f32, pos: ImVec2, col: u32, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip_rect: ^ImVec4) ---;
	ImDrawList_AddTriangle                 :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: u32, thickness: f32) ---;
	ImDrawList_AddTriangleFilled           :: proc(self: ^Draw_List, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: u32) ---;
	ImDrawList_ChannelsMerge               :: proc(self: ^Draw_List) ---;
	ImDrawList_ChannelsSetCurrent          :: proc(self: ^Draw_List, n: i32) ---;
	ImDrawList_ChannelsSplit               :: proc(self: ^Draw_List, count: i32) ---;
	ImDrawList_CloneOutput                 :: proc(self: ^Draw_List) -> ^Draw_List ---;
	ImDrawList_GetClipRectMax              :: proc(pOut: ^ImVec2, self: ^Draw_List) ---;
	ImDrawList_GetClipRectMin              :: proc(pOut: ^ImVec2, self: ^Draw_List) ---;
	ImDrawList_PathArcTo                   :: proc(self: ^Draw_List, center: ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;
	ImDrawList_PathArcToFast               :: proc(self: ^Draw_List, center: ImVec2, radius: f32, a_min_of_12: i32, a_max_of_12: i32) ---;
	ImDrawList_PathBezierCubicCurveTo      :: proc(self: ^Draw_List, p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: i32) ---;
	ImDrawList_PathBezierQuadraticCurveTo  :: proc(self: ^Draw_List, p2: ImVec2, p3: ImVec2, num_segments: i32) ---;
	ImDrawList_PathClear                   :: proc(self: ^Draw_List) ---;
	ImDrawList_PathFillConvex              :: proc(self: ^Draw_List, col: u32) ---;
	ImDrawList_PathLineTo                  :: proc(self: ^Draw_List, pos: ImVec2) ---;
	ImDrawList_PathLineToMergeDuplicate    :: proc(self: ^Draw_List, pos: ImVec2) ---;
	ImDrawList_PathRect                    :: proc(self: ^Draw_List, rect_min: ImVec2, rect_max: ImVec2, rounding: f32, flags: Draw_Flags) ---;
	ImDrawList_PathStroke                  :: proc(self: ^Draw_List, col: u32, flags: Draw_Flags, thickness: f32) ---;
	ImDrawList_PopClipRect                 :: proc(self: ^Draw_List) ---;
	ImDrawList_PopTextureID                :: proc(self: ^Draw_List) ---;
	ImDrawList_PrimQuadUV                  :: proc(self: ^Draw_List, a: ImVec2, b: ImVec2, c: ImVec2, d: ImVec2, uv_a: ImVec2, uv_b: ImVec2, uv_c: ImVec2, uv_d: ImVec2, col: u32) ---;
	ImDrawList_PrimRect                    :: proc(self: ^Draw_List, a: ImVec2, b: ImVec2, col: u32) ---;
	ImDrawList_PrimRectUV                  :: proc(self: ^Draw_List, a: ImVec2, b: ImVec2, uv_a: ImVec2, uv_b: ImVec2, col: u32) ---;
	ImDrawList_PrimReserve                 :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;
	ImDrawList_PrimUnreserve               :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;
	ImDrawList_PrimVtx                     :: proc(self: ^Draw_List, pos: ImVec2, uv: ImVec2, col: u32) ---;
	ImDrawList_PrimWriteIdx                :: proc(self: ^Draw_List, idx: Draw_Idx) ---;
	ImDrawList_PrimWriteVtx                :: proc(self: ^Draw_List, pos: ImVec2, uv: ImVec2, col: u32) ---;
	ImDrawList_PushClipRect                :: proc(self: ^Draw_List, clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool) ---;
	ImDrawList_PushClipRectFullScreen      :: proc(self: ^Draw_List) ---;
	ImDrawList_PushTextureID               :: proc(self: ^Draw_List, texture_id: Texture_ID) ---;
	ImDrawList__CalcCircleAutoSegmentCount :: proc(self: ^Draw_List, radius: f32) -> i32 ---;
	ImDrawList__ClearFreeMemory            :: proc(self: ^Draw_List) ---;
	ImDrawList__OnChangedClipRect          :: proc(self: ^Draw_List) ---;
	ImDrawList__OnChangedTextureID         :: proc(self: ^Draw_List) ---;
	ImDrawList__OnChangedVtxOffset         :: proc(self: ^Draw_List) ---;
	ImDrawList__PathArcToFastEx            :: proc(self: ^Draw_List, center: ImVec2, radius: f32, a_min_sample: i32, a_max_sample: i32, a_step: i32) ---;
	ImDrawList__PathArcToN                 :: proc(self: ^Draw_List, center: ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;
	ImDrawList__PopUnusedDrawCmd           :: proc(self: ^Draw_List) ---;
	ImDrawList__ResetForNewFrame           :: proc(self: ^Draw_List) ---;

	ImFontAtlasCustomRect_IsPacked :: proc(self: ^Font_Atlas_Custom_Rect) -> bool ---;

	ImFontAtlas_AddCustomRectFontGlyph                :: proc(self: ^Font_Atlas, font: ^ImFont, id: Wchar, width: i32, height: i32, advance_x: f32, offset: ImVec2) -> i32 ---;
	ImFontAtlas_AddCustomRectRegular                  :: proc(self: ^Font_Atlas, width: i32, height: i32) -> i32 ---;
	ImFontAtlas_AddFont                               :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;
	ImFontAtlas_AddFontDefault                        :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;
	ImFontAtlas_AddFontFromFileTTF                    :: proc(self: ^Font_Atlas, filename: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;
	ImFontAtlas_AddFontFromMemoryCompressedBase85TTF  :: proc(self: ^Font_Atlas, compressed_font_data_base85: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;
	ImFontAtlas_AddFontFromMemoryCompressedTTF        :: proc(self: ^Font_Atlas, compressed_font_data: rawptr, compressed_font_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;
	ImFontAtlas_AddFontFromMemoryTTF                  :: proc(self: ^Font_Atlas, font_data: rawptr, font_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;
	ImFontAtlas_Build                                 :: proc(self: ^Font_Atlas) -> bool ---;
	ImFontAtlas_CalcCustomRectUV                      :: proc(self: ^Font_Atlas, rect: ^Font_Atlas_Custom_Rect, out_uv_min: ^ImVec2, out_uv_max: ^ImVec2) ---;
	ImFontAtlas_Clear                                 :: proc(self: ^Font_Atlas) ---;
	ImFontAtlas_ClearFonts                            :: proc(self: ^Font_Atlas) ---;
	ImFontAtlas_ClearInputData                        :: proc(self: ^Font_Atlas) ---;
	ImFontAtlas_ClearTexData                          :: proc(self: ^Font_Atlas) ---;
	ImFontAtlas_GetCustomRectByIndex                  :: proc(self: ^Font_Atlas, index: i32) -> ^Font_Atlas_Custom_Rect ---;
	ImFontAtlas_GetGlyphRangesChineseFull             :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesCyrillic                :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesDefault                 :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesJapanese                :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesKorean                  :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesThai                    :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetGlyphRangesVietnamese              :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_GetMouseCursorTexData                 :: proc(self: ^Font_Atlas, cursor: Mouse_Cursor, out_offset: ^ImVec2, out_size: ^ImVec2, out_uv_border: [2]ImVec2, out_uv_fill: [2]ImVec2) -> bool ---;
	ImFontAtlas_GetTexDataAsAlpha8                    :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;
	ImFontAtlas_GetTexDataAsRGBA32                    :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;
	ImFontAtlas_IsBuilt                               :: proc(self: ^Font_Atlas) -> bool ---;
	ImFontAtlas_SetTexID                              :: proc(self: ^Font_Atlas, id: Texture_ID) ---;

	ImFontGlyphRangesBuilder_AddChar     :: proc(self: ^Font_Glyph_Ranges_Builder, c: Wchar) ---;
	ImFontGlyphRangesBuilder_AddRanges   :: proc(self: ^Font_Glyph_Ranges_Builder, ranges: ^Wchar) ---;
	ImFontGlyphRangesBuilder_AddText     :: proc(self: ^Font_Glyph_Ranges_Builder, text: cstring, text_end: cstring) ---;
	ImFontGlyphRangesBuilder_BuildRanges :: proc(self: ^Font_Glyph_Ranges_Builder, out_ranges: ^Im_Vector(Wchar)) ---;
	ImFontGlyphRangesBuilder_Clear       :: proc(self: ^Font_Glyph_Ranges_Builder) ---;
	ImFontGlyphRangesBuilder_GetBit      :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) -> bool ---;
	ImFontGlyphRangesBuilder_SetBit      :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) ---;

	ImFont_AddGlyph              :: proc(self: ^ImFont, src_cfg: ^Font_Config, c: Wchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) ---;
	ImFont_AddRemapChar          :: proc(self: ^ImFont, dst: Wchar, src: Wchar, overwrite_dst: bool) ---;
	ImFont_BuildLookupTable      :: proc(self: ^ImFont) ---;
	ImFont_CalcTextSizeA         :: proc(pOut: ^ImVec2, self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: cstring, text_end: cstring, remaining: ^cstring) ---;
	ImFont_CalcWordWrapPositionA :: proc(self: ^ImFont, scale: f32, text: cstring, text_end: cstring, wrap_width: f32) -> cstring ---;
	ImFont_ClearOutputData       :: proc(self: ^ImFont) ---;
	ImFont_FindGlyph             :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;
	ImFont_FindGlyphNoFallback   :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;
	ImFont_GetCharAdvance        :: proc(self: ^ImFont, c: Wchar) -> f32 ---;
	ImFont_GetDebugName          :: proc(self: ^ImFont) -> cstring ---;
	ImFont_GrowIndex             :: proc(self: ^ImFont, new_size: i32) ---;
	ImFont_IsGlyphRangeUnused    :: proc(self: ^ImFont, c_begin: u32, c_last: u32) -> bool ---;
	ImFont_IsLoaded              :: proc(self: ^ImFont) -> bool ---;
	ImFont_RenderChar            :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: ImVec2, col: u32, c: Wchar) ---;
	ImFont_RenderText            :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: ImVec2, col: u32, clip_rect: ImVec4, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip: bool) ---;
	ImFont_SetFallbackChar       :: proc(self: ^ImFont, c: Wchar) ---;
	ImFont_SetGlyphVisible       :: proc(self: ^ImFont, c: Wchar, visible: bool) ---;

	ImGuiIO_AddInputCharacter      :: proc(self: ^IO, c: u32) ---;
	ImGuiIO_AddInputCharacterUTF16 :: proc(self: ^IO, c: Wchar16) ---;
	ImGuiIO_AddInputCharactersUTF8 :: proc(self: ^IO, str: cstring) ---;
	ImGuiIO_ClearInputCharacters   :: proc(self: ^IO) ---;

	ImGuiInputTextCallbackData_ClearSelection :: proc(self: ^Input_Text_Callback_Data) ---;
	ImGuiInputTextCallbackData_DeleteChars    :: proc(self: ^Input_Text_Callback_Data, pos: i32, bytes_count: i32) ---;
	ImGuiInputTextCallbackData_HasSelection   :: proc(self: ^Input_Text_Callback_Data) -> bool ---;
	ImGuiInputTextCallbackData_InsertChars    :: proc(self: ^Input_Text_Callback_Data, pos: i32, text: cstring, text_end: cstring) ---;
	ImGuiInputTextCallbackData_SelectAll      :: proc(self: ^Input_Text_Callback_Data) ---;

	ImGuiListClipper_Begin :: proc(self: ^List_Clipper, items_count: i32, items_height: f32) ---;
	ImGuiListClipper_End   :: proc(self: ^List_Clipper) ---;
	ImGuiListClipper_Step  :: proc(self: ^List_Clipper) -> bool ---;

	ImGuiPayload_Clear      :: proc(self: ^Payload) ---;
	ImGuiPayload_IsDataType :: proc(self: ^Payload, type: cstring) -> bool ---;
	ImGuiPayload_IsDelivery :: proc(self: ^Payload) -> bool ---;
	ImGuiPayload_IsPreview  :: proc(self: ^Payload) -> bool ---;

	ImGuiStorage_BuildSortByKey :: proc(self: ^Storage) ---;
	ImGuiStorage_Clear          :: proc(self: ^Storage) ---;
	ImGuiStorage_GetBool        :: proc(self: ^Storage, key: ImID, default_val: bool) -> bool ---;
	ImGuiStorage_GetBoolRef     :: proc(self: ^Storage, key: ImID, default_val: bool) -> ^bool ---;
	ImGuiStorage_GetFloat       :: proc(self: ^Storage, key: ImID, default_val: f32) -> f32 ---;
	ImGuiStorage_GetFloatRef    :: proc(self: ^Storage, key: ImID, default_val: f32) -> ^f32 ---;
	ImGuiStorage_GetInt         :: proc(self: ^Storage, key: ImID, default_val: i32) -> i32 ---;
	ImGuiStorage_GetIntRef      :: proc(self: ^Storage, key: ImID, default_val: i32) -> ^i32 ---;
	ImGuiStorage_GetVoidPtr     :: proc(self: ^Storage, key: ImID) -> rawptr ---;
	ImGuiStorage_GetVoidPtrRef  :: proc(self: ^Storage, key: ImID, default_val: rawptr) -> ^rawptr ---;
	ImGuiStorage_SetAllInt      :: proc(self: ^Storage, val: i32) ---;
	ImGuiStorage_SetBool        :: proc(self: ^Storage, key: ImID, val: bool) ---;
	ImGuiStorage_SetFloat       :: proc(self: ^Storage, key: ImID, val: f32) ---;
	ImGuiStorage_SetInt         :: proc(self: ^Storage, key: ImID, val: i32) ---;
	ImGuiStorage_SetVoidPtr     :: proc(self: ^Storage, key: ImID, val: rawptr) ---;

	ImGuiStyle_ScaleAllSizes :: proc(self: ^Style, scale_factor: f32) ---;

	ImGuiTextBuffer_append  :: proc(self: ^Text_Buffer, str: cstring, str_end: cstring) ---;
	ImGuiTextBuffer_appendf :: proc(self: ^Text_Buffer, fmt_: cstring, #c_vararg args: ..any) ---;
	ImGuiTextBuffer_begin   :: proc(self: ^Text_Buffer) -> cstring ---;
	ImGuiTextBuffer_c_str   :: proc(self: ^Text_Buffer) -> cstring ---;
	ImGuiTextBuffer_clear   :: proc(self: ^Text_Buffer) ---;
	ImGuiTextBuffer_empty   :: proc(self: ^Text_Buffer) -> bool ---;
	ImGuiTextBuffer_end     :: proc(self: ^Text_Buffer) -> cstring ---;
	ImGuiTextBuffer_reserve :: proc(self: ^Text_Buffer, capacity: i32) ---;
	ImGuiTextBuffer_size    :: proc(self: ^Text_Buffer) -> i32 ---;

	ImGuiTextFilter_Build      :: proc(self: ^Text_Filter) ---;
	ImGuiTextFilter_Clear      :: proc(self: ^Text_Filter) ---;
	ImGuiTextFilter_Draw       :: proc(self: ^Text_Filter, label: cstring, width: f32) -> bool ---;
	ImGuiTextFilter_IsActive   :: proc(self: ^Text_Filter) -> bool ---;
	ImGuiTextFilter_PassFilter :: proc(self: ^Text_Filter, text: cstring, text_end: cstring) -> bool ---;

	ImGuiTextRange_empty :: proc(self: ^Text_Range) -> bool ---;
	ImGuiTextRange_split :: proc(self: ^Text_Range, separator: i8, out: ^Im_Vector(Text_Range)) ---;

	ImGuiViewport_GetCenter     :: proc(pOut: ^ImVec2, self: ^Viewport) ---;
	ImGuiViewport_GetWorkCenter :: proc(pOut: ^ImVec2, self: ^Viewport) ---;

	igAcceptDragDropPayload            :: proc(type: cstring, flags: Drag_Drop_Flags) -> ^Payload ---;
	igAlignTextToFramePadding          :: proc() ---;
	igArrowButton                      :: proc(str_id: cstring, dir: Dir) -> bool ---;
	igBegin                            :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	igBeginChild_Str                   :: proc(str_id: cstring, size: ImVec2, border: bool, flags: Window_Flags) -> bool ---;
	igBeginChild_ID                    :: proc(id: ImID, size: ImVec2, border: bool, flags: Window_Flags) -> bool ---;
	igBeginChildFrame                  :: proc(id: ImID, size: ImVec2, flags: Window_Flags) -> bool ---;
	igBeginCombo                       :: proc(label: cstring, preview_value: cstring, flags: Combo_Flags) -> bool ---;
	igBeginDragDropSource              :: proc(flags: Drag_Drop_Flags) -> bool ---;
	igBeginDragDropTarget              :: proc() -> bool ---;
	igBeginGroup                       :: proc() ---;
	igBeginListBox                     :: proc(label: cstring, size: ImVec2) -> bool ---;
	igBeginMainMenuBar                 :: proc() -> bool ---;
	igBeginMenu                        :: proc(label: cstring, enabled: bool) -> bool ---;
	igBeginMenuBar                     :: proc() -> bool ---;
	igBeginPopup                       :: proc(str_id: cstring, flags: Window_Flags) -> bool ---;
	igBeginPopupContextItem            :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igBeginPopupContextVoid            :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igBeginPopupContextWindow          :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igBeginPopupModal                  :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	igBeginTabBar                      :: proc(str_id: cstring, flags: Tab_Bar_Flags) -> bool ---;
	igBeginTabItem                     :: proc(label: cstring, p_open: ^bool, flags: Tab_Item_Flags) -> bool ---;
	igBeginTable                       :: proc(str_id: cstring, column: i32, flags: Table_Flags, outer_size: ImVec2, inner_width: f32) -> bool ---;
	igBeginTooltip                     :: proc() ---;
	igBullet                           :: proc() ---;
	igBulletText                       :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igButton                           :: proc(label: cstring, size: ImVec2) -> bool ---;
	igCalcItemWidth                    :: proc() -> f32 ---;
	igCalcListClipping                 :: proc(items_count: i32, items_height: f32, out_items_display_start: ^i32, out_items_display_end: ^i32) ---;
	igCalcTextSize                     :: proc(pOut: ^ImVec2, text: cstring, text_end: cstring, hide_text_after_double_hash: bool, wrap_width: f32) ---;
	igCaptureKeyboardFromApp           :: proc(want_capture_keyboard_value: bool) ---;
	igCaptureMouseFromApp              :: proc(want_capture_mouse_value: bool) ---;
	igCheckbox                         :: proc(label: cstring, v: ^bool) -> bool ---;
	igCheckboxFlags_IntPtr             :: proc(label: cstring, flags: ^i32, flags_value: i32) -> bool ---;
	igCheckboxFlags_UintPtr            :: proc(label: cstring, flags: ^u32, flags_value: u32) -> bool ---;
	igCloseCurrentPopup                :: proc() ---;
	igCollapsingHeader_TreeNodeFlags   :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igCollapsingHeader_BoolPtr         :: proc(label: cstring, p_visible: ^bool, flags: Tree_Node_Flags) -> bool ---;
	igColorButton                      :: proc(desc_id: cstring, col: ImVec4, flags: Color_Edit_Flags, size: ImVec2) -> bool ---;
	igColorConvertFloat4ToU32          :: proc(in_: ImVec4) -> u32 ---;
	igColorConvertHSVtoRGB             :: proc(h: f32, s: f32, v: f32, out_r: ^f32, out_g: ^f32, out_b: ^f32) ---;
	igColorConvertRGBtoHSV             :: proc(r: f32, g: f32, b: f32, out_h: ^f32, out_s: ^f32, out_v: ^f32) ---;
	igColorConvertU32ToFloat4          :: proc(pOut: ^ImVec4, in_: u32) ---;
	igColorEdit3                       :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	igColorEdit4                       :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags) -> bool ---;
	igColorPicker3                     :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	igColorPicker4                     :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags, ref_col: ^f32) -> bool ---;
	igColumns                          :: proc(count: i32, id: cstring, border: bool) ---;
	igCombo_Str_arr                    :: proc(label: cstring, current_item: ^i32, items: ^cstring, items_count: i32, popup_max_height_in_items: i32) -> bool ---
	igCombo_Str                        :: proc(label: cstring, current_item: ^i32, items_separated_by_zeros: cstring, popup_max_height_in_items: i32) -> bool ---;
	igCombo_FnBoolPtr                  :: proc(label: cstring, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> bool ---
	igCreateContext                    :: proc(shared_font_atlas: ^Font_Atlas) -> ^Context ---;
	igDebugCheckVersionAndDataLayout   :: proc(version_str: cstring, sz_io: uint, sz_style: uint, sz_Imvec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint) -> bool ---;
	igDestroyContext                   :: proc(ctx: ^Context) ---;
	igDragFloat                        :: proc(label: cstring, v: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragFloat2                       :: proc(label: cstring, v: [2]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragFloat3                       :: proc(label: cstring, v: [3]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragFloat4                       :: proc(label: cstring, v: [4]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragFloatRange2                  :: proc(label: cstring, v_current_min: ^f32, v_current_max: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	igDragInt                          :: proc(label: cstring, v: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragInt2                         :: proc(label: cstring, v: [2]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragInt3                         :: proc(label: cstring, v: [3]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragInt4                         :: proc(label: cstring, v: [4]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragIntRange2                    :: proc(label: cstring, v_current_min: ^i32, v_current_max: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	igDragScalar                       :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragScalarN                      :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igDummy                            :: proc(size: ImVec2) ---;
	igEnd                              :: proc() ---;
	igEndChild                         :: proc() ---;
	igEndChildFrame                    :: proc() ---;
	igEndCombo                         :: proc() ---;
	igEndDragDropSource                :: proc() ---;
	igEndDragDropTarget                :: proc() ---;
	igEndFrame                         :: proc() ---;
	igEndGroup                         :: proc() ---;
	igEndListBox                       :: proc() ---;
	igEndMainMenuBar                   :: proc() ---;
	igEndMenu                          :: proc() ---;
	igEndMenuBar                       :: proc() ---;
	igEndPopup                         :: proc() ---;
	igEndTabBar                        :: proc() ---;
	igEndTabItem                       :: proc() ---;
	igEndTable                         :: proc() ---;
	igEndTooltip                       :: proc() ---;
	igGetAllocatorFunctions            :: proc(p_alloc_func: ^Mem_Alloc_Func, p_free_func: ^Mem_Free_Func, p_user_data: ^rawptr) ---;
	igGetBackgroundDrawList_Nil        :: proc() -> ^Draw_List ---;
	igGetClipboardText                 :: proc() -> cstring ---;
	igGetColorU32_Col                  :: proc(idx: Col, alpha_mul: f32) -> u32 ---;
	igGetColorU32_Vec4                 :: proc(col: ImVec4) -> u32 ---;
	igGetColorU32_U32                  :: proc(col: u32) -> u32 ---;
	igGetColumnIndex                   :: proc() -> i32 ---;
	igGetColumnOffset                  :: proc(column_index: i32) -> f32 ---;
	igGetColumnWidth                   :: proc(column_index: i32) -> f32 ---;
	igGetColumnsCount                  :: proc() -> i32 ---;
	igGetContentRegionAvail            :: proc(pOut: ^ImVec2) ---;
	igGetContentRegionMax              :: proc(pOut: ^ImVec2) ---;
	igGetCurrentContext                :: proc() -> ^Context ---;
	igGetCursorPos                     :: proc(pOut: ^ImVec2) ---;
	igGetCursorPosX                    :: proc() -> f32 ---;
	igGetCursorPosY                    :: proc() -> f32 ---;
	igGetCursorScreenPos               :: proc(pOut: ^ImVec2) ---;
	igGetCursorStartPos                :: proc(pOut: ^ImVec2) ---;
	igGetDragDropPayload               :: proc() -> ^Payload ---;
	igGetDrawData                      :: proc() -> ^Draw_Data ---;
	igGetDrawListSharedData            :: proc() -> ^Draw_List_Shared_Data ---;
	igGetFont                          :: proc() -> ^ImFont ---;
	igGetFontSize                      :: proc() -> f32 ---;
	igGetFontTexUvWhitePixel           :: proc(pOut: ^ImVec2) ---;
	igGetForegroundDrawList_Nil        :: proc() -> ^Draw_List ---;
	igGetFrameCount                    :: proc() -> i32 ---;
	igGetFrameHeight                   :: proc() -> f32 ---;
	igGetFrameHeightWithSpacing        :: proc() -> f32 ---;
	igGetID_Str                        :: proc(str_id: cstring) -> ImID ---;
	igGetID_StrStr                     :: proc(str_id_begin: cstring, str_id_end: cstring) -> ImID ---;
	igGetID_Ptr                        :: proc(ptr_id: rawptr) -> ImID ---;
	igGetIO                            :: proc() -> ^IO ---;
	igGetItemRectMax                   :: proc(pOut: ^ImVec2) ---;
	igGetItemRectMin                   :: proc(pOut: ^ImVec2) ---;
	igGetItemRectSize                  :: proc(pOut: ^ImVec2) ---;
	igGetKeyIndex                      :: proc(imgui_key: Key) -> i32 ---;
	igGetKeyPressedAmount              :: proc(key_index: i32, repeat_delay: f32, rate: f32) -> i32 ---;
	igGetMainViewport                  :: proc() -> ^Viewport ---;
	igGetMouseCursor                   :: proc() -> Mouse_Cursor ---;
	igGetMouseDragDelta                :: proc(pOut: ^ImVec2, button: Mouse_Button, lock_threshold: f32) ---;
	igGetMousePos                      :: proc(pOut: ^ImVec2) ---;
	igGetMousePosOnOpeningCurrentPopup :: proc(pOut: ^ImVec2) ---;
	igGetScrollMaxX                    :: proc() -> f32 ---;
	igGetScrollMaxY                    :: proc() -> f32 ---;
	igGetScrollX                       :: proc() -> f32 ---;
	igGetScrollY                       :: proc() -> f32 ---;
	igGetStateStorage                  :: proc() -> ^Storage ---;
	igGetStyle                         :: proc() -> ^Style ---;
	igGetStyleColorName                :: proc(idx: Col) -> cstring ---;
	igGetStyleColorVec4                :: proc(idx: Col) -> ^ImVec4 ---;
	igGetTextLineHeight                :: proc() -> f32 ---;
	igGetTextLineHeightWithSpacing     :: proc() -> f32 ---;
	igGetTime                          :: proc() -> f64 ---;
	igGetTreeNodeToLabelSpacing        :: proc() -> f32 ---;
	igGetVersion                       :: proc() -> cstring ---;
	igGetWindowContentRegionMax        :: proc(pOut: ^ImVec2) ---;
	igGetWindowContentRegionMin        :: proc(pOut: ^ImVec2) ---;
	igGetWindowContentRegionWidth      :: proc() -> f32 ---;
	igGetWindowDrawList                :: proc() -> ^Draw_List ---;
	igGetWindowHeight                  :: proc() -> f32 ---;
	igGetWindowPos                     :: proc(pOut: ^ImVec2) ---;
	igGetWindowSize                    :: proc(pOut: ^ImVec2) ---;
	igGetWindowWidth                   :: proc() -> f32 ---;
	igImage                            :: proc(user_texture_id: Texture_ID, size: ImVec2, uv0: ImVec2, uv1: ImVec2, tint_col: ImVec4, border_col: ImVec4) ---;
	igImageButton                      :: proc(user_texture_id: Texture_ID, size: ImVec2, uv0: ImVec2, uv1: ImVec2, frame_padding: i32, bg_col: ImVec4, tint_col: ImVec4) -> bool ---;
	igIndent                           :: proc(indent_w: f32) ---;
	igInputDouble                      :: proc(label: cstring, v: ^f64, step: f64, step_fast: f64, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputFloat                       :: proc(label: cstring, v: ^f32, step: f32, step_fast: f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputFloat2                      :: proc(label: cstring, v: [2]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputFloat3                      :: proc(label: cstring, v: [3]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputFloat4                      :: proc(label: cstring, v: [4]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputInt                         :: proc(label: cstring, v: ^i32, step: i32, step_fast: i32, flags: Input_Text_Flags) -> bool ---;
	igInputInt2                        :: proc(label: cstring, v: [2]i32, flags: Input_Text_Flags) -> bool ---;
	igInputInt3                        :: proc(label: cstring, v: [3]i32, flags: Input_Text_Flags) -> bool ---;
	igInputInt4                        :: proc(label: cstring, v: [4]i32, flags: Input_Text_Flags) -> bool ---;
	igInputScalar                      :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputScalarN                     :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInputText                        :: proc(label: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igInputTextMultiline               :: proc(label: cstring, buf: cstring, buf_size: uint, size: ImVec2, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igInputTextWithHint                :: proc(label: cstring, hint: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igInvisibleButton                  :: proc(str_id: cstring, size: ImVec2, flags: Button_Flags) -> bool ---;
	igIsAnyItemActive                  :: proc() -> bool ---;
	igIsAnyItemFocused                 :: proc() -> bool ---;
	igIsAnyItemHovered                 :: proc() -> bool ---;
	igIsAnyMouseDown                   :: proc() -> bool ---;
	igIsItemActivated                  :: proc() -> bool ---;
	igIsItemActive                     :: proc() -> bool ---;
	igIsItemClicked                    :: proc(mouse_button: Mouse_Button) -> bool ---;
	igIsItemDeactivated                :: proc() -> bool ---;
	igIsItemDeactivatedAfterEdit       :: proc() -> bool ---;
	igIsItemEdited                     :: proc() -> bool ---;
	igIsItemFocused                    :: proc() -> bool ---;
	igIsItemHovered                    :: proc(flags: Hovered_Flags) -> bool ---;
	igIsItemToggledOpen                :: proc() -> bool ---;
	igIsItemVisible                    :: proc() -> bool ---;
	igIsKeyDown                        :: proc(user_key_index: i32) -> bool ---;
	igIsKeyPressed                     :: proc(user_key_index: i32, repeat: bool) -> bool ---;
	igIsKeyReleased                    :: proc(user_key_index: i32) -> bool ---;
	igIsMouseClicked                   :: proc(button: Mouse_Button, repeat: bool) -> bool ---;
	igIsMouseDoubleClicked             :: proc(button: Mouse_Button) -> bool ---;
	igIsMouseDown                      :: proc(button: Mouse_Button) -> bool ---;
	igIsMouseDragging                  :: proc(button: Mouse_Button, lock_threshold: f32) -> bool ---;
	igIsMouseHoveringRect              :: proc(r_min: ImVec2, r_max: ImVec2, clip: bool) -> bool ---;
	igIsMousePosValid                  :: proc(mouse_pos: ^ImVec2) -> bool ---;
	igIsMouseReleased                  :: proc(button: Mouse_Button) -> bool ---;
	igIsPopupOpen_Str                  :: proc(str_id: cstring, flags: Popup_Flags) -> bool ---;
	igIsRectVisible_Nil                :: proc(size: ImVec2) -> bool ---;
	igIsRectVisible_ImVec2               :: proc(rect_min: ImVec2, rect_max: ImVec2) -> bool ---;
	igIsWindowAppearing                :: proc() -> bool ---;
	igIsWindowCollapsed                :: proc() -> bool ---;
	igIsWindowFocused                  :: proc(flags: Focused_Flags) -> bool ---;
	igIsWindowHovered                  :: proc(flags: Hovered_Flags) -> bool ---;
	igLabelText                        :: proc(label: cstring, fmt_: cstring, #c_vararg args: ..any) ---;
	igListBox_Str_arr                  :: proc(label: cstring, current_item: ^i32, items: cstring, items_count: i32, height_in_items: i32) -> bool ---;
	igListBox_FnBoolPtr                :: proc(label: cstring, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, height_in_items: i32) -> bool ---
	igLoadIniSettingsFromDisk          :: proc(ini_filename: cstring) ---;
	igLoadIniSettingsFromMemory        :: proc(ini_data: cstring, ini_size: uint) ---;
	igLogButtons                       :: proc() ---;
	igLogFinish                        :: proc() ---;
	igLogText                          :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igLogToClipboard                   :: proc(auto_open_depth: i32) ---;
	igLogToFile                        :: proc(auto_open_depth: i32, filename: cstring) ---;
	igLogToTTY                         :: proc(auto_open_depth: i32) ---;
	igMemAlloc                         :: proc(size: uint) -> rawptr ---;
	igMemFree                          :: proc(ptr: rawptr) ---;
	igMenuItem_Bool                    :: proc(label: cstring, shortcut: cstring, selected: bool, enabled: bool) -> bool ---;
	igMenuItem_BoolPtr                 :: proc(label: cstring, shortcut: cstring, p_selected: ^bool, enabled: bool) -> bool ---;
	igNewFrame                         :: proc() ---;
	igNewLine                          :: proc() ---;
	igNextColumn                       :: proc() ---;
	igOpenPopup                        :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	igOpenPopupOnItemClick             :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	igPlotHistogram_FloatPtr           :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: i32) ---;
	igPlotHistogram_FnFloatPtr         :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2) ---
	igPlotLines_FloatPtr               :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: i32) ---;
	igPlotLines_FnFloatPtr             :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2) ---
	igPopAllowKeyboardFocus            :: proc() ---;
	igPopButtonRepeat                  :: proc() ---;
	igPopClipRect                      :: proc() ---;
	igPopFont                          :: proc() ---;
	igPopID                            :: proc() ---;
	igPopItemWidth                     :: proc() ---;
	igPopStyleColor                    :: proc(count: i32) ---;
	igPopStyleVar                      :: proc(count: i32) ---;
	igPopTextWrapPos                   :: proc() ---;
	igProgressBar                      :: proc(fraction: f32, size_arg: ImVec2, overlay: cstring) ---;
	igPushAllowKeyboardFocus           :: proc(allow_keyboard_focus: bool) ---;
	igPushButtonRepeat                 :: proc(repeat: bool) ---;
	igPushClipRect                     :: proc(clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool) ---;
	igPushFont                         :: proc(font: ^ImFont) ---;
	igPushID_Str                       :: proc(str_id: cstring) ---;
	igPushID_StrStr                    :: proc(str_id_begin: cstring, str_id_end: cstring) ---;
	igPushID_Ptr                       :: proc(ptr_id: rawptr) ---;
	igPushID_Int                       :: proc(int_id: i32) ---;
	igPushItemWidth                    :: proc(item_width: f32) ---;
	igPushStyleColor_U32               :: proc(idx: Col, col: u32) ---;
	igPushStyleColor_Vec4              :: proc(idx: Col, col: ImVec4) ---;
	igPushStyleVar_Float               :: proc(idx: Style_Var, val: f32) ---;
	igPushStyleVar_ImVec2                :: proc(idx: Style_Var, val: ImVec2) ---;
	igPushTextWrapPos                  :: proc(wrap_local_pos_x: f32) ---;
	igRadioButton_Bool                 :: proc(label: cstring, active: bool) -> bool ---;
	igRadioButton_IntPtr               :: proc(label: cstring, v: ^i32, v_button: i32) -> bool ---;
	igRender                           :: proc() ---;
	igResetMouseDragDelta              :: proc(button: Mouse_Button) ---;
	igSameLine                         :: proc(offset_from_start_x: f32, spacing: f32) ---;
	igSaveIniSettingsToDisk            :: proc(ini_filename: cstring) ---;
	igSaveIniSettingsToMemory          :: proc(out_ini_size: ^uint) -> cstring ---;
	igSelectable_Bool                  :: proc(label: cstring, selected: bool, flags: Selectable_Flags, size: ImVec2) -> bool ---;
	igSelectable_BoolPtr               :: proc(label: cstring, p_selected: ^bool, flags: Selectable_Flags, size: ImVec2) -> bool ---;
	igSeparator                        :: proc() ---;
	igSetAllocatorFunctions            :: proc(alloc_func: Alloc_Func, free_func: Free_Func) ---
	igSetClipboardText                 :: proc(text: cstring) ---;
	igSetColorEditOptions              :: proc(flags: Color_Edit_Flags) ---;
	igSetColumnOffset                  :: proc(column_index: i32, offset_x: f32) ---;
	igSetColumnWidth                   :: proc(column_index: i32, width: f32) ---;
	igSetCurrentContext                :: proc(ctx: ^Context) ---;
	igSetCursorPos                     :: proc(local_pos: ImVec2) ---;
	igSetCursorPosX                    :: proc(local_x: f32) ---;
	igSetCursorPosY                    :: proc(local_y: f32) ---;
	igSetCursorScreenPos               :: proc(pos: ImVec2) ---;
	igSetDragDropPayload               :: proc(type: cstring, data: rawptr, sz: uint, cond: Cond) -> bool ---;
	igSetItemAllowOverlap              :: proc() ---;
	igSetItemDefaultFocus              :: proc() ---;
	igSetKeyboardFocusHere             :: proc(offset: i32) ---;
	igSetMouseCursor                   :: proc(cursor_type: Mouse_Cursor) ---;
	igSetNextItemOpen                  :: proc(is_open: bool, cond: Cond) ---;
	igSetNextItemWidth                 :: proc(item_width: f32) ---;
	igSetNextWindowBgAlpha             :: proc(alpha: f32) ---;
	igSetNextWindowCollapsed           :: proc(collapsed: bool, cond: Cond) ---;
	igSetNextWindowContentSize         :: proc(size: ImVec2) ---;
	igSetNextWindowFocus               :: proc() ---;
	igSetNextWindowPos                 :: proc(pos: ImVec2, cond: Cond, pivot: ImVec2) ---;
	igSetNextWindowSize                :: proc(size: ImVec2, cond: Cond) ---;
	igSetNextWindowSizeConstraints     :: proc(size_min: ImVec2, size_max: ImVec2, custom_callback: Size_Callback, custom_callback_data: rawptr) ---;
	igSetScrollFromPosX_Float          :: proc(local_x: f32, center_x_ratio: f32) ---;
	igSetScrollFromPosY_Float          :: proc(local_y: f32, center_y_ratio: f32) ---;
	igSetScrollHereX                   :: proc(center_x_ratio: f32) ---;
	igSetScrollHereY                   :: proc(center_y_ratio: f32) ---;
	igSetScrollX_Float                 :: proc(scroll_x: f32) ---;
	igSetScrollY_Float                 :: proc(scroll_y: f32) ---;
	igSetStateStorage                  :: proc(storage: ^Storage) ---;
	igSetTabItemClosed                 :: proc(tab_or_docked_window_label: cstring) ---;
	igSetTooltip                       :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igSetWindowCollapsed_Bool          :: proc(collapsed: bool, cond: Cond) ---;
	igSetWindowCollapsed_Str           :: proc(name: cstring, collapsed: bool, cond: Cond) ---;
	igSetWindowFocus_Nil               :: proc() ---;
	igSetWindowFocus_Str               :: proc(name: cstring) ---;
	igSetWindowFontScale               :: proc(scale: f32) ---;
	igSetWindowPos_ImVec2                :: proc(pos: ImVec2, cond: Cond) ---;
	igSetWindowPos_Str                 :: proc(name: cstring, pos: ImVec2, cond: Cond) ---;
	igSetWindowSize_ImVec2               :: proc(size: ImVec2, cond: Cond) ---;
	igSetWindowSize_Str                :: proc(name: cstring, size: ImVec2, cond: Cond) ---;
	igShowAboutWindow                  :: proc(p_open: ^bool) ---;
	igShowDemoWindow                   :: proc(p_open: ^bool) ---;
	igShowFontSelector                 :: proc(label: cstring) ---;
	igShowMetricsWindow                :: proc(p_open: ^bool) ---;
	igShowStyleEditor                  :: proc(ref: ^Style) ---;
	igShowStyleSelector                :: proc(label: cstring) -> bool ---;
	igShowUserGuide                    :: proc() ---;
	igSliderAngle                      :: proc(label: cstring, v_rad: ^f32, v_degrees_min: f32, v_degrees_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderFloat                      :: proc(label: cstring, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderFloat2                     :: proc(label: cstring, v: [2]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderFloat3                     :: proc(label: cstring, v: [3]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderFloat4                     :: proc(label: cstring, v: [4]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderInt                        :: proc(label: cstring, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderInt2                       :: proc(label: cstring, v: [2]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderInt3                       :: proc(label: cstring, v: [3]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderInt4                       :: proc(label: cstring, v: [4]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderScalar                     :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderScalarN                    :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igSmallButton                      :: proc(label: cstring) -> bool ---;
	igSpacing                          :: proc() ---;
	igStyleColorsClassic               :: proc(dst: ^Style) ---;
	igStyleColorsDark                  :: proc(dst: ^Style) ---;
	igStyleColorsLight                 :: proc(dst: ^Style) ---;
	igTabItemButton                    :: proc(label: cstring, flags: Tab_Item_Flags) -> bool ---;
	igTableGetColumnCount              :: proc() -> i32 ---;
	igTableGetColumnFlags              :: proc(column_n: i32) -> Table_Column_Flags ---;
	igTableGetColumnIndex              :: proc() -> i32 ---;
	igTableGetColumnName_Int           :: proc(column_n: i32) -> cstring ---;
	igTableGetRowIndex                 :: proc() -> i32 ---;
	igTableGetSortSpecs                :: proc() -> ^Table_Sort_Specs ---;
	igTableHeader                      :: proc(label: cstring) ---;
	igTableHeadersRow                  :: proc() ---;
	igTableNextColumn                  :: proc() -> bool ---;
	igTableNextRow                     :: proc(row_flags: Table_Row_Flags, min_row_height: f32) ---;
	igTableSetBgColor                  :: proc(target: Table_Bg_Target, color: u32, column_n: i32) ---;
	igTableSetColumnIndex              :: proc(column_n: i32) -> bool ---;
	igTableSetupColumn                 :: proc(label: cstring, flags: Table_Column_Flags, init_width_or_weight: f32, user_id: ImID) ---;
	igTableSetupScrollFreeze           :: proc(cols: i32, rows: i32) ---;
	igText                             :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igTextColored                      :: proc(col: ImVec4, fmt_: cstring, #c_vararg args: ..any) ---;
	igTextDisabled                     :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igTextUnformatted                  :: proc(text: cstring, text_end: cstring) ---;
	igTextWrapped                      :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igTreeNode_Str                     :: proc(label: cstring) -> bool ---;
	igTreeNode_StrStr                  :: proc(str_id: cstring, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNode_Ptr                     :: proc(ptr_id: rawptr, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNodeEx_Str                   :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igTreeNodeEx_StrStr                :: proc(str_id: cstring, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNodeEx_Ptr                   :: proc(ptr_id: rawptr, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreePop                          :: proc() ---;
	igTreePush_Str                     :: proc(str_id: cstring) ---;
	igTreePush_Ptr                     :: proc(ptr_id: rawptr) ---;
	igUnindent                         :: proc(indent_w: f32) ---;
	igVSliderFloat                     :: proc(label: cstring, size: ImVec2, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igVSliderInt                       :: proc(label: cstring, size: ImVec2, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igVSliderScalar                    :: proc(label: cstring, size: ImVec2, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igValue_Bool                       :: proc(prefix: cstring, b: bool) ---;
	igValue_Int                        :: proc(prefix: cstring, v: i32) ---;
	igValue_Uint                       :: proc(prefix: cstring, v: u32) ---;
	igValue_Float                      :: proc(prefix: cstring, v: f32, float_format: cstring) ---;

}