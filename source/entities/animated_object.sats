(*
###  animated_object.sats  ###

an object animated by a skeleton
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/skeleton.sats"

vtypedef animated_object = @{
	position=vec3,
	scale=vec3,
	rotation=quat,
	animation_time=float,
	renderable=asset_hndl,
	animation=asset_hndl,
	skeleton=asset_hndl,
	pose=(*frame*) ptr
}

fun animated_object_new () : (*animated_object*) ptr = "sta#%"
fun animated_object_delete ( ao: (*animated_object*) ptr ) : void = "sta#%"

fun animated_object_load_skeleton ( ao: (*animated_object*) ptr, ah: asset_hndl ) : void = "sta#%"

fun animated_object_update ( ao: (*animated_object*) ptr, timestep: float ) : void = "sta#%"
