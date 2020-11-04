(*
###  renderer.sats  ###

a relatively simple deferred renderer implementation
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/texture.sats"
staload "./../assets/shader.sats"
staload "./../assets/cmesh.sats"
staload "./../assets/config.sats"

staload "./../entities/camera.sats"
staload "./../entities/light.sats"
staload "./../entities/static_object.sats"
staload "./../entities/instance_object.sats"
staload "./../entities/animated_object.sats"
staload "./../entities/particles.sats"
staload "./../entities/landscape.sats"

staload "./sky.sats"

(*val RENDERER_LIGHTS = @{
    RENDERER_MAX_LIGHTS=16,
    RENDERER_MAX_DYN_LIGHTS=13
}*)//  needs to be instead defined in the .dats file

datatype RO_TYPE =
| RO_TYPE_AXIS of ()
| RO_TYPE_STATIC of ()
| RO_TYPE_INSTANCE of ()
| RO_TYPE_ANIMATED of ()
| RO_TYPE_PARTICLES of ()
| RO_TYPE_LIGHT of ()
| RO_TYPE_LANDSCAPE of ()
| RO_TYPE_PAINT of ()
| RO_TYPE_SPHERE of ()
| RO_TYPE_ELLIPSOID of ()
| RO_TYPE_CMESH of ()
| RO_TYPE_FRUSTUM of ()
| RO_TYPE_PLANE of ()
| RO_TYPE_LINE of ()
| RO_TYPE_POINT of ()

typedef render_col_def = @{
  colmesh=(*cmesh*) ptr,
  colworld=mat4

}

typedef render_line_def = @{
  line_start=vec3,
  line_end=vec3,
  line_color=vec3,
  line_thickness=float
}

typedef render_point_def = @{
  point_pos=vec3,
  point_color=vec3,
  point_size=float
}

typedef render_paint_def = @{
  paint_axis=mat4,
  paint_radius=float
}

typedef render_object = @{
  type=int,
  axis=mat4,
  sphere=sphere,
  ellipsoid=ellipsoid,
  render_col=render_col_def,
  frustum=frustum,
  plane=plane,
  render_line=render_line_def,
  render_point=render_point_def,
  static_object=(*static_object*) ptr,
  instance_object=(*instance_object*) ptr,
  animated_object=(*animated_object*) ptr,
  landscape=(*landscape*) ptr,
  particles=(*particles*) ptr,
  light=(*light*) ptr,
  render_paint=render_paint_def
}

fun render_object_static ( s: (*static_object*) ptr ) : render_object = "sta#%"
fun render_object_instance ( s: (*instance_object*) ptr ) : render_object = "sta#%"
fun render_object_animated ( a: (*animated_object*) ptr ) : render_object = "sta#%"
fun render_object_particles ( p: (*particles*) ptr ) : render_object = "sta#%"
fun render_object_light ( l: (*light*) ptr ) : render_object = "sta#%"
fun render_object_axis ( a: mat4 ) : render_object = "sta#%"
fun render_object_sphere ( s: sphere ) : render_object = "sta#%"
fun render_object_ellipsoid ( e: ellipsoid ) : render_object = "sta#%"
fun render_object_frustum ( f: frustum ) : render_object = "sta#%"
fun render_object_plane ( p: plane ) : render_object = "sta#%"
fun render_object_cmesh ( cm: (*cmesh*) ptr, world: mat4 ) : render_object = "sta#%"
fun render_object_landscape ( l: (*landscape*) ptr ) : render_object = "sta#%"
fun render_object_paint ( paint_axis: mat4, paint_radius: float ) : render_object = "sta#%"
fun render_object_line ( start: vec3, ro_end: vec3, color: vec3, thickness: float ) : render_object = "sta#%"
fun render_object_point ( pos: vec3, color: vec3, size: float ) : render_object = "sta#%"

vtypedef renderer = @{
	options=asset_hndl,
	camera=(*camera*) ptr,
	dyn_lights_num=int,
        dyn_light=(*light*) ptr,//  [RENDERER_MAX_DYN_LIGHTS]
	sky=(*sky*) ptr,
	mat_static=asset_hndl,
        mat_skin=asset_hndl,
        mat_instance=asset_hndl,
        mat_animated=asset_hndl,
        mat_vegetation=asset_hndl,
        mat_terrain=asset_hndl,
        mat_clear=asset_hndl,
        mat_ui=asset_hndl,
        mat_ssao=asset_hndl,
        mat_compose=asset_hndl,
        mat_tonemap=asset_hndl,
        mat_post0=asset_hndl,
        mat_post1=asset_hndl,
        mat_skydome=asset_hndl,
        mat_depth=asset_hndl,
        mat_depth_ins=asset_hndl,
        mat_depth_ani=asset_hndl,
        mat_depth_veg=asset_hndl,
        mat_depth_ter=asset_hndl,
        mat_sun=asset_hndl,
        mat_clouds=asset_hndl,
        mat_particles=asset_hndl,
        mat_sea=asset_hndl,
	mesh_skydome=asset_hndl,
        mesh_sphere=asset_hndl,
        mesh_sea=asset_hndl,
	tex_color_correction=asset_hndl,
        tex_random=asset_hndl,
        tex_random_perlin=asset_hndl,
        tex_environment=asset_hndl,
        tex_vignetting=asset_hndl,
        tex_sea_bump0=asset_hndl,
        tex_sea_bump1=asset_hndl,
        tex_sea_bump2=asset_hndl,
        tex_sea_bump3=asset_hndl,
        tex_sea_env=asset_hndl,
        tex_cube_sea=asset_hndl,
        tex_cube_field=asset_hndl,
        tex_white=asset_hndl,
        tex_grey=asset_hndl,
        tex_skin_lookup=asset_hndl,
	gfbo=$extype"GLuint",
        gdepth_buffer=$extype"GLuint",
        gdiffuse_buffer=$extype"GLuint",
        gnormals_buffer=$extype"GLuint",
	gdiffuse_texture=$extype"GLuint",
        gnormals_texture=$extype"GLuint",
        gdepth_texture=$extype"GLuint",
	ssao_fbo=$extype"GLuint",
        ssao_buffer=$extype"GLuint",
        ssao_texture=$extype"GLuint",
	hdr_fbo=$extype"GLuint",
        hdr_buffer=$extype"GLuint",
        hdr_texture=$extype"GLuint",
	ldr_front_fbo=$extype"GLuint",
        ldr_front_buffer=$extype"GLuint",
        ldr_front_texture=$extype"GLuint",
	ldr_back_fbo=$extype"GLuint",
        ldr_back_buffer=$extype"GLuint",
        ldr_back_texture=$extype"GLuint",
	shadows_fbo=$extype"GLuint"(*[3]*),
        shadows_buffer=$extype"GLuint"(*3*),
        shadows_texture=$extype"GLuint"(*[3]*),
	shadows_start=float(*[3]*),
        shadows_end=float(*[3]*),
        shadows_widths=int(*[3]*),
        shadows_heights=int(*[3]*),
	seed=int,
        glitch=float,
        time=float,
        time_of_day=float,
        exposure=float,
        exposure_speed=float,
        exposure_target=float,
        skydome_enabled=bool,
        sea_enabled=bool,
	render_object_num=int,
        render_objects=(*render_object*) ptr,
	camera_view=mat4,
        camera_proj=mat4,
        camera_inv_view=mat4,
        camera_inv_proj=mat4,
        camera_near=float,
        camera_far=float,
        shadow_frustum=box,
        shadow_view=mat4(*[3]*),
        shadow_proj=mat4(*[3]*),
        shadow_near=float(*[3]*),
        shadow_far=float(*[3]*),
        shadow_frustum=box(*[3]*)
}

fun renderer_new ( options: asset_hndl ) : (*renderer*) ptr = "sta#%"
fun renderer_delete ( dr: (*renderer*) ptr ) : void = "sta#%"

fun renderer_set_camera ( dr: (*renderer*) ptr, cam: (*camera*) ptr ) : void = "sta#%"
fun renderer_set_color_correction ( dr: (*renderer*) ptr, t: asset_hndl ) : void = "sta#%"
fun renderer_set_vignetting ( dr: (*renderer*) ptr, v: asset_hndl ) : void = "sta#%"
fun renderer_set_glitch ( dr: (*renderer*) ptr, glitch: float ) : void = "sta#%"
fun renderer_set_skydome_enabled ( dr: (*renderer*) ptr, enabled: bool ) : void = "sta#%"
fun renderer_set_sea_enabled ( dr: (*renderer*) ptr, enabled: bool ) : void = "sta#%"
fun renderer_set_tod ( dr: (*renderer*) ptr, tod: float, seed: int ) : void = "sta#%"

fun renderer_add ( dr: (*renderer*) ptr, ro: render_object ) : void = "sta#%"
fun renderer_add_dyn_light ( dr: (*renderer*) ptr, l: (*light*) ptr ) : void = "sta#%"

fun renderer_render ( dr: (*renderer*) ptr ) : void = "sta#%"