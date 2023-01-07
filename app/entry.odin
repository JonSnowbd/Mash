package main

import "core:fmt"
import "../allegro"
import ig "../allegro_ig"

ig_impl: ig.ig_impl_context = ---
timg: ^allegro.Bitmap = ---
rot: f32 = 0.0

ini :: proc(ctx: ^Ez_Allegro) {
    using allegro
    ig_impl = ig.allegro_ig_init(display_get_current(), nil)
    timg = bitmap_load("image2.png")
}
loop ::proc(ctx: ^Ez_Allegro) {
    using allegro

    // Builds the transform
    camera_update(&ctx.camera, 0, 0, 1.0, rot)

    // al_use_projection_transform is done here:
    camera_use_world(&ctx.camera)

    // al_draw_line:
    prim_line(0, 0, 10, 10, rgb(255,255,255), 3)
    // then the bitmap
    bitmap_draw(ig_impl.texture, 0.0, 0.0, 0)

    rot += 3.14 / 60.0
    
    // ig.allegro_ig_begin(&ig_impl)
    // if ig.igBegin("Aaa", nil, ig.Window_Flags.None) {
    //     ig.igText("Suuuup")
    //     if ig.igButton("Press me papi", {}) {
    //         fmt.println("It prints")
    //     }
    // }
    // ig.igEnd()
    // ig.allegro_ig_end(&ig_impl)
}

main :: proc() {
    ez_init(ini, loop)
}