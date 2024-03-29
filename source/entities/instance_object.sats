(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  instance_object.sats  ###

a collection of static objects; supports instanced rendering
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/renderable.sats"
staload "./../assets/cmesh.sats"

staload "./../SDL2/SDL_local.sats"

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
	world_buffer=GL_Buffer,
	bound=sphere,
	renderable=asset_hndl(renderable),
	collision_body=asset_hndl(cmesh)
}

fun instance_object_new () : (*instance_object*) ptr
fun instance_object_delete ( io: (*instance_object*) ptr ) : void

fun instance_object_update ( io: (*instance_object*) ptr ) : void
fun instance_object_add_instance ( io: (*instance_object*) ptr, position: vec3, scale: vec3, rotation: quat ) : void
fun instance_object_rem_instance ( io: (*instance_object*) ptr, i: int ) : void
fun instance_object_world ( io: (*instance_object*) ptr, i: int ) : mat4
fun instance_object_world_normal ( io: (*instance_object*) ptr, i: int ) : mat3
