(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  static_object.sats  ###

an unmovable object that interacts with physics-affected objects
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/renderable.sats"
staload "./../assets/cmesh.sats"

vtypedef static_object = @{
	position=vec3,
	scale=vec3,
	rotation=quat,
	active=bool,
	recieve_shadows=bool,
	cast_shadows=bool,
	renderable=asset_hndl(renderable),
	collision_body=asset_hndl(cmesh)
}

fun static_object_new () : (*static_object*) ptr
fun static_object_delete ( s: (*static_object*) ptr ) : void

fun static_object_world ( s: (*static_object*) ptr ) : mat4
fun static_object_world_normal ( s: (*static_object*) ptr ) : mat3
