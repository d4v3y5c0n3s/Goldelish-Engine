(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  animated_object.sats  ###

an object animated by a skeleton
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/skeleton.sats"
staload "./../assets/renderable.sats"
staload "./../assets/animation.sats"

vtypedef animated_object = @{
	position=vec3,
	scale=vec3,
	rotation=quat,
	animation_time=float,
	renderable=asset_hndl(renderable),
	animation=asset_hndl(animation),
	skeleton=asset_hndl(skeleton),
	pose=(*frame*) ptr
}

fun animated_object_new () : (*animated_object*) ptr
fun animated_object_delete ( ao: (*animated_object*) ptr ) : void

fun animated_object_load_skeleton ( ao: (*animated_object*) ptr, ah: asset_hndl(skeleton) ) : void

fun animated_object_update ( ao: (*animated_object*) ptr, timestep: float ) : void
