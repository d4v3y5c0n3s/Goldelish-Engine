(*
###  renderer.sats  ###

a relatively simple deferred renderer implementation
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
//staload "./../assets/texture.sats"
//staload "./../assets/shader.sats"
staload "./../assets/cmesh.sats"
//staload "./../assets/config.sats"

//staload "./../entities/camera.sats"
//staload "./../entities/light.sats"
//staload "./../entities/static_object.sats"
//staload "./../entities/instance_object.sats"
//staload "./../entities/animated_object.sats"
//staload "./../entities/particles.sats"
//staload "./../entities/landscape.sats"
//staload "./sky.sats"

#define RENDERER_MAX_LIGHTS 16
#define RENDERER_MAX_DYN_LIGHTS 13

vtypedef cmesh_ro = @{ c=cmesh, world=mat4 }
vtypedef paint_ro = @{ axis=mat4, radius=float }
vtypedef line_ro = @{ l_start=vec3, l_end=vec3, thickness=float }
vtypedef point_ro = @{ pos=vec3, color=vec3, size=float }

absvtype ro (a:vt@ype) = ptr
vtypedef ro = [a:vt@ype] ro(a)

absvt0ype renderer

//fn renderer_new ( options: asset_hndl(config) ) : renderer
fn renderer_delete ( dr: renderer ) : void

//fn renderer_set_camera ( dr: &renderer, cam: camera ) : void
//fn renderer_set_color_correction ( dr: &renderer, t: asset_hndl(texture) ) : void
//fn renderer_set_vignetting ( dr: &renderer, v: asset_hndl(texture) ) : void
//fn renderer_set_glitch ( dr: &renderer, glitch: float ) : void
//fn renderer_set_skydome_enabled ( dr: &renderer, enabled: bool ) : void
//fn renderer_set_sea_enabled ( dr: &renderer, enabled: bool ) : void
//fn renderer_set_tod ( dr: &renderer, tod: float, seed: int ) : void

fn{a:vt@ype} renderer_add ( dr: &renderer, ro: ro(a) ) : void
//fn renderer_add_dyn_light ( dr: &renderer, l: &light ) : void
fn renderer_add_cmesh ( dr: &renderer, c: cmesh, world: mat4 ) : void
fn renderer_add_paint ( dr: &renderer, axis: mat4, radius: float ) : void
fn renderer_add_line ( dr: &renderer, l_start: vec3, l_end: vec3, thickness: float ) : void
fn renderer_add_point ( dr: &renderer, pos: vec3, color: vec3, size: float ) : void

fn renderer_render ( dr: &renderer ) : void