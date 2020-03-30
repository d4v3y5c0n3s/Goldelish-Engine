(*
###  static_object.sats  ###

an unmovable object that interacts with physics-affected objects\
*)

#include "./../g_engine.sats"
#include "./../g_asset.sats"

typedef static_object = @{
	position=vec3,
	scale=vec3,
	rotation=quat,
	active=bool,
	recieve_shadows=bool,
	cast_shadows=bool,
	renderable=asset_hndl,
	collision_body=asset_hndl
}

fun static_object_new () : static_object ptr = "sta#%"
fun static_object_delete ( s: static_object ptr ) : void = "sta#%"

fun static_object_world ( s: static_object ptr ) : mat4 = "sta#%"
fun static_object_world_normal ( s: static_object ptr ) : mat3 = "sta#%"
