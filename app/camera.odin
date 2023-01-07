package main

import "../allegro"

Camera_2D :: struct {
    projection: allegro.Transform,
    inverse: allegro.Transform,
    app_width, app_height: int,
    x, y, zoom, rot: f32,
}

// Expensive, use this whenever the display updates in size, or when you are in the context
// (have targeted) a new bitmap you wish to be using as the render target
camera_recalculate :: proc(cam: ^Camera_2D) {
    surface := allegro.bitmap_get_target()
    cam.app_width = int(allegro.bitmap_get_width(surface))
    cam.app_height = int(allegro.bitmap_get_height(surface))
}

// Updates the camera with new parameters, but doesnt set anything in allegro.
camera_update :: proc(cam: ^Camera_2D, x, y, zoom, rotation: f32) {
    cam.x = x
    cam.y = y
    cam.zoom = zoom
    cam.rot = rotation
    allegro.transform_build(&cam.projection, (-x)+(f32(cam.app_width)/2.0), (-y)+(f32(cam.app_height)/2.0), 1.0, 1.0, rotation)
    allegro.transform_ortho(&cam.projection, 0.0, 0.0, -1.0, f32(cam.app_width), f32(cam.app_height), 1.0)
    if allegro.transform_can_invert(&cam.projection, 0.000002) == 1 {
        cam.inverse = cam.projection
        allegro.transform_invert(&cam.inverse)
    } else {
        allegro.transform_create_identity(&cam.inverse)
    }
}
camera_use_world :: proc(cam: ^Camera_2D) {
    allegro.transform_use_projection(&cam.projection)
}
camera_world_to_screen :: proc(cam: ^Camera_2D, x, y: f32) -> (screen_x, screen_y: f32) {
    screen_x = x
    screen_y = y
    allegro.transform_coordinates_2d(&cam.inverse, &screen_x, &screen_y)
    return
}
camera_screen_to_world :: proc(cam: ^Camera_2D, x, y: f32) -> (screen_x, screen_y: f32) {
    screen_x = x
    screen_y = y
    allegro.transform_coordinates_2d(&cam.projection, &screen_x, &screen_y)
    return
}