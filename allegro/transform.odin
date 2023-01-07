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

Transform :: struct {
    m: [4][4]c.float,
}

@(default_calling_convention="c")
foreign lib {
    // Sets the projection transformation to be used for the drawing operations on the target
    // bitmap (each bitmap maintains its own projection transformation). Every drawing
    // operation after this call will be transformed using this transformation. To return
    // default behavior, call this function with an orthographic transform.
    @(link_name="al_use_projection_transform")
    transform_use_projection :: proc(IN_transform: ^Transform) ---
    @(link_name="al_identity_transform")
    transform_create_identity :: proc(OUT_transform: ^Transform) ---
    @(link_name="al_perspective_transform")
    transform_perspective :: proc(OUT_transform: ^Transform, left, top, near, right, bottom, far: c.float) ---
    // Apply this to an identity transform to create a 2d ortho.
    // If you're looking for 2d camera behaviour, the
    // order is (Identity, Rotate, Scale, Translate, Ortho)
    @(link_name="al_orthographic_transform")
    transform_ortho :: proc(transform: ^Transform, left, top, near, right, bottom, far: c.float) ---
    @(link_name="al_translate_transform")
    transform_translate_2d :: proc(OUT_transform: ^Transform, x, y: c.float) ---
    @(link_name="al_translate_transform_3d")
    transform_translate_3d :: proc(OUT_transform: ^Transform, x, y, z: c.float) ---
    @(link_name="al_rotate_transform")
    transform_rotate_2d :: proc(OUT_transform: ^Transform, theta : c.float) ---
    @(link_name="al_rotate_transform_3d")
    transform_rotate_3d :: proc(OUT_transform: ^Transform, x, y, z, angle: c.float) ---
    @(link_name="al_scale_transform")
    transform_scale_2d :: proc(OUT_transform: ^Transform, x, y: c.float) ---
    @(link_name="al_scale_transform_3d")
    transform_scale_3d :: proc(OUT_transform: ^Transform, x, y, z: c.float) ---
    @(link_name="al_horizontal_shear_transform")
    transform_shear_horizontal :: proc(OUT_transform: ^Transform, theta: c.float) ---
    @(link_name="al_vertical_shear_transform")
    transform_shear_vertical :: proc(OUT_transform: ^Transform, theta: c.float) ---
    // Builds a transformation given some parameters. This call is equivalent to calling
    // the transformations in this order: make identity, rotate, scale, translate.
    // This method is faster, however, than actually calling those functions.
    @(link_name="al_build_transform")
    transform_build :: proc(OUT_transform: ^Transform, x_pos, y_pos, x_scale, y_scale, rotation: c.float) ---
    @(link_name="al_invert_transform")
    transform_invert :: proc(IN_transform: ^Transform) ---
    // x,y are expected to be what they are right now, and they will be set to the result after the function
    // call.
    @(link_name="al_transform_coordinates")
    transform_coordinates_2d :: proc(REF_transform: ^Transform, INOUT_x, INOUT_y: ^c.float) ---
    // x,y,z are expected to be what they are right now, and they will be set to the result after the function
    // call.
    @(link_name="al_transform_coordinates_3d")
    transform_coordinates_3d :: proc(REF_transform: ^Transform, INOUT_x, INOUT_y, INOUT_z: ^c.float) ---
    //Checks if the transformation has an inverse using the supplied
    // tolerance. Tolerance should be a small value between 0 and 1,
    // with 1e-7 being sufficient for most applications.
    //
    // In this function tolerance specifies how close the determinant
    // can be to 0 (if the determinant is 0, the transformation has no inverse).
    // Thus the smaller the tolerance you specify, the “worse” transformations will
    // pass this test. Using a tolerance of 1e-7 will catch errors greater than 1/1000’s
    // of a pixel, but let smaller errors pass. That means that if you transformed a
    // point by a transformation and then transformed it again by the inverse transformation
    // that passed this check, the resultant point should less than 1/1000’s of a pixel
    // away from the original point.
    @(link_name="al_check_inverse")
    transform_can_invert :: proc(REF_transform: ^Transform, tolerance: c.float) -> c.int ---
}