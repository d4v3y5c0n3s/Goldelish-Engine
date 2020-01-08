(*
###  renderer.dats  ###


*)

staload "g_graphics.sats"
staload "g_entity.sats"

staload "assets/shader.sats"
staload "assets/texture.sats"
staload "assets/material.sats"
staload "assets/renderable.sats"
staload "assets/terrain.sats"
staload "assets/cmesh.sats"

staload "rendering/sky.sats"

implement render_object_instance ( i ) =
{
}

implement render_object_static ( s ) =
{
}

implement render_object_animated ( a ) =
{
}

implement render_object_light ( l ) =
{
}

implement render_object_axis ( a ) =
{
}

implement render_object_landscape ( l ) =
{
}

implement render_object_particles ( p ) =
{
}

implement render_object_paint ( paint_axis, paint_radius ) =
{
}

implement render_object_sphere ( s ) =
{
}

implement render_object_cmesh ( cm, world ) =
{
}

implement render_object_ellipsoid ( e ) =
{
}

implement render_object_frustum ( f ) =
{
}

implement render_object_plane ( p ) =
{
}

implement render_object_line ( start, end, color, thickness ) =
{
}

implement render_object_point ( pos, color, size ) =
{
}

val quad_position = [
    ~1, ~1, 0,
    1, ~1, 0,
    1, 1, 0,
    ~1, ~1, 0,
    ~1, 1, 0,
    1, 1, 0
]//  array of floats

val quad_texcoord = [
    0, 0,
    1, 0,
    1, 1,
    0, 0,
    0, 1,
    1, 1
]//  array of floats

implement renderer_new ( options ) =
{
}

implement renderer_delete ( dr ) =
{
}

implement renderer_set_camera ( dr, cam ) =
{
}

implement renderer_set_color_correction ( dr, t ) =
{
}

implement renderer_set_vignetting ( dr, v ) =
{
}

implement renderer_set_glitch ( dr, glitch ) =
{
}

implement renderer_set_skydome_enabled ( dr, enabled ) =
{
}

implement renderer_set_sea_enabled ( dr, enabled ) =
{
}

implement renderer_set_tod ( dr, tod, seed ) =
{
}

implement renderer_add_dyn_light ( dr, l ) =
{
}

implement renderer_add ( dr, ro ) =
{
}

implement round_to ( x, multiple ) =
{
}

implement shadow_mapper_transforms ( dr, i, view, proj, nearclip, farclip ) =
{
}

implement render_shadows_vegetation ( dr, i, io ) =
{
}

implement render_shadows_static ( dr, i, s ) =
{
}

implement render_shadows_instance ( dr, i, io ) =
{
}

val MAX_BONES = 64

val bone_matrices: mat4 = ()//[MAX_BONES]
val quat_reals: vec4 = ()//[MAX_BONES]
val quat_duals: vec4 = ()//[MAX_BONES]

implement render_shadows_animated ( dr, i, ao ) =
{
}

implement render_shadows_landscape_blobtree ( dr, i, shader, lbt, terr ) =
{
}

implement render_shadows_landscape ( dr, i, l ) =
{
}

implement render_shadows ( dr ) =
{
}

implement render_ellipsoid ( dr, e ) =
{
}

implement render_plane ( dr, p ) =
{
}

implement render_clear ( dr ) =
{
}

var cmesh_counter: uint32_t = 0

val cmesh_pallet = [

]//  [14] fpath array