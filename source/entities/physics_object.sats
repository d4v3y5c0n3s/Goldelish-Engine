(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  physics_object.sats  ###

an object which utilizes the physics system
*)

staload "./../g_engine.sats"
staload "./static_object.sats"
staload "./../g_asset.sats"

vtypedef physics_object = @{
	position=vec3,
	scale=vec3,
	velocity=vec3,
	angular_velocity=quat,
	acceleration=vec3,
	angular_acceleration=quat,
	previous_position=vec3,
	elasticity=float,
	friction=float,
	active=bool,
	receive_shadows=bool,
	cast_shadows=bool,
	renderable=asset_hndl,
	collision_body=asset_hndl
}

fun physics_object_new () : (*physics_object*) ptr = "sta#%"
fun physics_object_delete ( po: (*physics_object*) ptr ) : void = "sta#%"

fun physics_object_collide_static ( po: (*physics_object*) ptr, so: (*static_object*) ptr, timestep: float ) : void = "sta#%"
fun physics_object_update (po: (*physics_object*) ptr, timestep: float ) : void = "sta#%"
