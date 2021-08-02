(*
###  particles.sats  ###

displays particles
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

staload "./../assets/effect.sats"
staload "./camera.sats"

staload "./../SDL2/SDL_local.sats"

vtypedef particles = @{
	position=vec3,
	rotation=quat,
	scale=vec3,
	effect=asset_hndl(effect),
	rate=float,
	count=int,
	actives=(*bool*) ptr,
	seeds=(*float*) ptr,
	times=(*float*) ptr,
	rotations=(*float*) ptr,
	scales=(*vec3*) ptr,
	colors=(*vec4*) ptr,
	positions=(*vec3*) ptr,
	velocities=(*vec3*) ptr,
	vertex_buff=GLuint,
	vertex_data=(*float*) ptr
}

fun particles_new () : (*particles*) ptr
fun particles_delete ( p: (*particles*) ptr ) : void
fun particles_set_effect ( p: (*particles*) ptr, effect: asset_hndl(effect) ) : void
fun particles_update ( p: (*particles*) ptr, timestep: float, cam: (*camera*) ptr ) : void
