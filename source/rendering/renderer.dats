(*
###  renderer.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_graphics.sats"
staload "./g_entity.sats"

staload "./assets/shader.sats"
staload "./assets/texture.sats"
staload "./assets/material.sats"
staload "./assets/renderable.sats"
staload "./assets/terrain.sats"
staload "./assets/cmesh.sats"

//staload "./rendering/sky.sats"

local

assume renderer = @{
  options=asset_hndl(config),
  camera=camera,
}

in

end////
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
    {"$GOLDELISH/textures/solid/black.dds"},
    {"$GOLDELISH/textures/solid/blue.dds"},
    {"$GOLDELISH/textures/solid/burnt_orange.dds"},
    {"$GOLDELISH/textures/solid/green.dds"},
    {"$GOLDELISH/textures/solid/light_blue.dds"},
    {"$GOLDELISH/textures/solid/lime.dds"},
    {"$GOLDELISH/textures/solid/orange.dds"},
    {"$GOLDELISH/textures/solid/pink.dds"},
    {"$GOLDELISH/textures/solid/purple.dds"},
    {"$GOLDELISH/textures/solid/red.dds"},
    {"$GOLDELISH/textures/solid/turquoise.dds"},
    {"$GOLDELISH/textures/solid/white.dds"},
    {"$GOLDELISH/textures/solid/yellow.dds"},
    {"$GOLDELISH/textures/solid/grey.dds"}
]//  [14] fpath array

implement render_cmesh ( dr, cm, world ) =
{
}

implement render_static ( dr, so ) =
{
}

implement render_skin ( dr, io ) =
{
}

implement render_instance ( dr, io ) =
{
}

implement render_vegetation ( dr, io ) =
{
}

implement render_axis ( dr, world ) =
{
}

implement render_frame ( dr, f, world ) =
{
}

implement render_animated ( dr, ao ) =
{
}

implement render_landscape_blobtree ( dr, shader, lbt, terr ) =
{
}

implement render_landscape ( dr, l ) =
{
}

implement render_light ( dr, l ) =
{
}

implement render_frustum ( dr, f ) =
{
}

implement render_plane ( dr, p ) =
{
}

implement render_line ( dr, line_start, line_end, line_color, line_thickness ) =
{
}

implement render_point ( dr, position, color, size ) =
{
}

implement render_ellipsoid ( dr, e ) =
{
}

implement render_paint_circle ( dr, axis, radius ) =
{
}

var compare_cam: camera ptr = ()

implement render_object_cost ( ro ) =
{
}

implement render_object_sort ( ro0, ro1 ) =
{
}

implement render_gbuffer ( dr ) =
{
}

implement render_ssao ( dr ) =
{
}

implement render_skies ( dr ) =
{
}

implement render_sea ( dr ) =
{
}

implement render_compose_low ( dr ) =
{
}

implement render_compose_high ( dr ) =
{
}

implement render_compose ( dr ) =
{
}

implement render_particles ( dr ) =
{
}

implement render_tonemap ( dr ) =
{
}

implement render_post0 ( dr ) =
{
}

implement render_post1 ( dr ) =
{
}

implement renderer_render ( dr ) =
{
}