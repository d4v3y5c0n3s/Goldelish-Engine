(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  renderer.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./../g_graphics.sats"
staload "./../g_entity.sats"
staload "./../g_engine.sats"
staload "./../g_asset.sats"

staload "./../assets/shader.sats"
staload "./../assets/texture.sats"
staload "./../assets/material.sats"
staload "./../assets/renderable.sats"
//staload "./../assets/terrain.sats"
staload "./../assets/cmesh.sats"
staload "./../assets/config.sats"

staload "./../entities/camera.sats"
staload "./../entities/light.sats"

staload "./../SDL2/SDL_local.sats"

staload "./sky.sats"
staload "./renderer.sats"

local

assume renderer = [dln:nat](*; ron:nat]*) @{
  options=asset_hndl(config),
  camera=camera,
  dyn_lights_num=int dln,
  dyn_light=arrayptr(light, dln),
  mat_static=asset_hndl(material),
  mat_skin=asset_hndl(material),
  mat_instance=asset_hndl(material),
  mat_animated=asset_hndl(material),
  mat_vegetation=asset_hndl(material),
  mat_terrain=asset_hndl(material),
  mat_clear=asset_hndl(material),
  mat_ui=asset_hndl(material),
  mat_ssao=asset_hndl(material),
  mat_compose=asset_hndl(material),
  mat_tonemap=asset_hndl(material),
  mat_post0=asset_hndl(material),
  mat_post1=asset_hndl(material),
  mat_skydome=asset_hndl(material),
  mat_depth=asset_hndl(material),
  mat_depth_ins=asset_hndl(material),
  mat_depth_ani=asset_hndl(material),
  mat_depth_veg=asset_hndl(material),
  mat_depth_ter=asset_hndl(material),
  mat_sun=asset_hndl(material),
  mat_clouds=asset_hndl(material),
  mat_particles=asset_hndl(material),
  mat_sea=asset_hndl(material),
  mesh_skydome=asset_hndl(renderable),
  mesh_sphere=asset_hndl(renderable),
  mesh_sea=asset_hndl(renderable),
  tex_color_correction=asset_hndl(texture),
  tex_random=asset_hndl(texture),
  tex_random_perlin=asset_hndl(texture),
  tex_environment=asset_hndl(texture),
  tex_vignetting=asset_hndl(texture),
  tex_sea_bump0=asset_hndl(texture),
  tex_sea_bump1=asset_hndl(texture),
  tex_sea_bump2=asset_hndl(texture),
  tex_sea_bump3=asset_hndl(texture),
  tex_sea_env=asset_hndl(texture),
  tex_cube_sea=asset_hndl(texture),
  tex_cube_field=asset_hndl(texture),
  tex_white=asset_hndl(texture),
  tex_grey=asset_hndl(texture),
  tex_skin_lookup=asset_hndl(texture),
  gfbo=GL_Framebuffer,
  gdepth_buffer=GL_Renderbuffer(*,
  gdiffuse_buffer=GL_Renderbuffer,
  gnormals_buffer=GL_Renderbuffer,
  gdiffuse_texture=GL_Texture,
  gnormals_texture=GL_Texture,
  gdepth_texture=GL_Texture,
  ssao_fbo=GL_Framebuffer,
  ssao_buffer=GL_Renderbuffer,
  ssao_texture=GL_Texture,
  hdr_fbo=GL_Framebuffer,
  hdr_buffer=GL_Renderbuffer,
  hdr_texture=GL_Texture,
  ldr_front_fbo=GL_Framebuffer,
  ldr_front_buffer=GL_Renderbuffer,
  ldr_front_texture=GL_Texture,
  ldr_back_fbo=GL_Framebuffer,
  ldr_back_buffer=GL_Renderbuffer,
  ldr_back_texture=GL_Texture*)
  (*,
  shadows_fbo=arrayptr(GLuint, 3),
  shadows_buffer=arrayptr(GLuint, 3),
  shadows_texture=arrayptr(GLuint, 3),
  shadows_start=arrayptr(float, 3),
  shadows_end=arrayptr(float, 3),
  shadows_widths=arrayptr(int, 3),
  shadows_heights=arrayptr(int, 3),
  seed=int,
  glitch=float,
  time=float,
  time_of_day=float,
  exposure=float,
  exposure_speed=float,
  exposure_target=float,
  skydome_enabled=bool,
  sea_enabled=bool,
  render_objects_num=int ron,
  render_objects=arrayptr(ro, ron),
  camera_view=mat4,
  camera_proj=mat4,
  camera_inv_view=mat4,
  camera_inv_proj=mat4,
  camera_near=float,
  camera_far=float,
  camera_frustum=box,
  shadow_view=arrayptr(mat4, 3),
  shadow_proj=arrayptr(mat4, 3),
  shadow_near=arrayptr(float, 3),
  shadow_far=arrayptr(float, 3),
  shadow_frustum=arrayptr(box, 3)
  *)
}

extern castfn ref2singleton_array () : void

in

implement renderer_new ( options, cam, gvp ) = let
  val width = graphics_viewport_width(gvp)
  val height = graphics_viewport_width(gvp)
  //val gwidth = width *
  //val gheight = height *
  var gfbo: GL_Framebuffer
  val () = glGenFramebuffers(i2sz(1), gfbo)
  var gdepth_buffer: GL_Renderbuffer
  val () = glGenRenderbuffers(i2sz(1), gdepth_buffer)
  //val () = glBindRenderbuffer(GL_RENDERBUFFER, gdepth_buffer)
  (*val () = glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT24, , )
  val () = glFramebufferRenderbuffer()
  var gdepth_texture: GL_Texture
  var gdiffuse_buffer: GL_Renderbuffer
  var gdiffuse_texture: GL_Texture
  var gnormals_buffer: GL_Renderbuffer
  var gnormals_texture: GL_Texture*)
in
  @{
  options=options,
  camera=cam,
  dyn_lights_num=0,
  dyn_light=arrayptr_make_elt<light>(i2sz(0), light_new()),
  mat_static=asset_hndl_new<material>(P("./coreassets/shaders/deferred/static.mat")),
  mat_skin=asset_hndl_new<material>(P("./coreassets/shaders/deferred/skin.mat")),
  mat_instance=asset_hndl_new<material>(P("./coreassets/shaders/deferred/instance.mat")),
  mat_animated=asset_hndl_new<material>(P("./coreassets/shaders/deferred/animated.mat")),
  mat_vegetation=asset_hndl_new<material>(P("./coreassets/shaders/deferred/vegetation.mat")),
  mat_terrain=asset_hndl_new<material>(P("./coreassets/shaders/deferred/terrain.mat")),
  mat_clear=asset_hndl_new<material>(P("./coreassets/shaders/deferred/clear.mat")),
  mat_ui=asset_hndl_new<material>(P("./coreassets/shaders/deferred/ui.mat")),
  mat_ssao=asset_hndl_new<material>(P("./coreassets/shaders/deferred/ssao.mat")),
  mat_compose=asset_hndl_new<material>(P("./coreassets/shaders/deferred/compose.mat")),
  mat_tonemap=asset_hndl_new<material>(P("./coreassets/shaders/deferred/tonemap.mat")),
  mat_post0=asset_hndl_new<material>(P("./coreassets/shaders/deferred/post0.mat")),
  mat_post1=asset_hndl_new<material>(P("./coreassets/shaders/deferred/post1.mat")),
  mat_skydome=asset_hndl_new<material>(P("./coreassets/shaders/deferred/skydome.mat")),
  mat_depth=asset_hndl_new<material>(P("./coreassets/shaders/deferred/depth.mat")),
  mat_depth_ins=asset_hndl_new<material>(P("./coreassets/shaders/deferred/depth_instance.mat")),
  mat_depth_ani=asset_hndl_new<material>(P("./coreassets/shaders/deferred/depth_animated.mat")),
  mat_depth_veg=asset_hndl_new<material>(P("./coreassets/shaders/deferred/depth_vegetation.mat")),
  mat_depth_ter=asset_hndl_new<material>(P("./coreassets/shaders/deferred/depth_terrain.mat")),
  mat_sun=asset_hndl_new<material>(P("./coreassets/shaders/deferred/sun.mat")),
  mat_clouds=asset_hndl_new<material>(P("./coreassets/shaders/deferred/clouds.mat")),
  mat_particles=asset_hndl_new<material>(P("./coreassets/shaders/deferred/particles.mat")),
  mat_sea=asset_hndl_new<material>(P("./coreassets/shaders/deferred/sea.mat")),
  mesh_skydome=asset_hndl_new<renderable>(P("./coreassets/sky/skydome.bmf")),
  mesh_sphere=asset_hndl_new<renderable>(P("./coreassets/objects/sphere.bmf")),
  mesh_sea=asset_hndl_new<renderable>(P("./coreassets/water/sea.bmf")),
  tex_color_correction=asset_hndl_new<texture>(P("./coreassets/luts/identity.lut")),
  tex_random=asset_hndl_new<texture>(P("./coreassets/textures/random.dds")),
  tex_random_perlin=asset_hndl_new<texture>(P("./coreassets/textures/random_perlin.dds")),
  tex_environment=asset_hndl_new<texture>(P("./coreassets/textures/envmap.dds")),
  tex_vignetting=asset_hndl_new<texture>(P("./coreassets/ui/vignetting.dds")),
  tex_sea_bump0=asset_hndl_new<texture>(P("./coreassets/water/bump0.dds")),
  tex_sea_bump1=asset_hndl_new<texture>(P("./coreassets/water/bump1.dds")),
  tex_sea_bump2=asset_hndl_new<texture>(P("./coreassets/water/bump2.dds")),
  tex_sea_bump3=asset_hndl_new<texture>(P("./coreassets/water/bump3.dds")),
  tex_sea_env=asset_hndl_new<texture>(P("./coreassets/water/envmap_sea.dds")),
  tex_cube_sea=asset_hndl_new<texture>(P("./coreassets/water/cube_sea.dds")),
  tex_cube_field=asset_hndl_new<texture>(P("./coreassets/textures/cube_field.dds")),
  tex_white=asset_hndl_new<texture>(P("./coreassets/textures/white.dds")),
  tex_grey=asset_hndl_new<texture>(P("./coreassets/textures/grey.dds")),
  tex_skin_lookup=asset_hndl_new<texture>(P("./coreassets/textures/skin_lookup.dds")),
  gfbo=gfbo,
  gdepth_buffer=gdepth_buffer(*,
  gdiffuse_buffer=,
  gnormals_buffer=,
  gdiffuse_texture=,
  gnormals_texture=,
  gdepth_texture=,
  ssao_fbo=,
  ssao_buffer=,
  ssao_texture=,
  hdr_fbo=,
  hdr_buffer=,
  hdr_texture=,
  ldr_front_fbo=,
  ldr_front_buffer=,
  ldr_front_texture=,
  ldr_back_fbo=,
  ldr_back_buffer=,
  ldr_back_texture=*)
  }:renderer
end
  (*,
  shadows_fbo=arrayptr(GLuint, 3),
  shadows_buffer=arrayptr(GLuint, 3),
  shadows_texture=arrayptr(GLuint, 3),
  shadows_start=arrayptr(float, 3),
  shadows_end=arrayptr(float, 3),
  shadows_widths=arrayptr(int, 3),
  shadows_heights=arrayptr(int, 3),
  seed=int,
  glitch=float,
  time=float,
  time_of_day=float,
  exposure=float,
  exposure_speed=float,
  exposure_target=float,
  skydome_enabled=bool,
  sea_enabled=bool,
  render_objects_num=int ron,
  render_objects=arrayptr(ro, ron),
  camera_view=mat4,
  camera_proj=mat4,
  camera_inv_view=mat4,
  camera_inv_proj=mat4,
  camera_near=float,
  camera_far=float,
  camera_frustum=box,
  shadow_view=arrayptr(mat4, 3),
  shadow_proj=arrayptr(mat4, 3),
  shadow_near=arrayptr(float, 3),
  shadow_far=arrayptr(float, 3),
  shadow_frustum=arrayptr(box, 3)
  *)
  //}:renderer
//end

end////

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
