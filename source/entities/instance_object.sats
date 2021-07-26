(*
###  instance_object.sats  ###

a collection of static objects; supports instanced rendering
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

typedef instance_data = @{
	position=vec3,
	scale=vec3,
	rotation=quat,
	world=mat4,
	world_normal=mat3
}

vtypedef instance_object = @{
	num_instances=int,
	instances=instance_data,
	world_buffer=$extype"GLuint",
	bound=sphere,
	renderable=asset_hndl,
	collision_body=asset_hndl
}

fun instance_object_new () : (*instance_object*) ptr = "sta#%"
fun instance_object_delete ( io: (*instance_object*) ptr ) : void = "sta#%"

fun instance_object_update ( io: (*instance_object*) ptr ) : void = "sta#%"
fun instance_object_add_instance ( io: (*instance_object*) ptr, position: vec3, scale: vec3, rotation: quat ) : void = "sta#%"
fun instance_object_rem_instance ( io: (*instance_object*) ptr, i: int ) : void = "sta#%"
fun instance_object_world ( io: (*instance_object*) ptr, i: int ) : mat4 = "sta#%"
fun instance_object_world_normal ( io: (*instance_object*) ptr, i: int ) : mat3 = "sta#%"
