(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  light.sats  ###

light object for lighting up scenes
*)

staload "./../g_engine.sats"

datatype TYPE =
| LIGHT_TYPE_POINT of ()//0
| LIGHT_TYPE_DIRECTIONAL of ()//1
| LIGHT_TYPE_SUN of ()//2
| LIGHT_TYPE_SPOT of ()//3

typedef light = @{
	position=vec3,
	target=vec3,
	diffuse_color=vec3,
	specular_color=vec3,
	ambient_color=vec3,
	power=float,
	falloff=float,
	enabled=bool,
	cast_shadows=bool,
	type=int,
	shadow_color=vec3,
	shadow_map_width=int,
	shadow_map_height=int,
	orthographic=bool,
	ortho_width=float,
	ortho_height=float,
	fov=float,
	aspect_ratio=float
}

fun light_new () : light
fun light_new_position ( position: vec3 ) : (*light*) ptr = "sta#%"

fun light_new_type ( position: vec3, type: int ) : (*light*) ptr = "sta#%"
fun light_delete ( l: (*light*) ptr ) : void = "sta#%"

fun light_set_type ( l: (*light*) ptr, type: int ) : void = "sta#%"

fun light_direction ( l: (*light*) ptr ) : vec3 = "sta#%"

fun light_view_matrix ( l: (*light*) ptr ) : mat4 = "sta#%"
fun light_proj_matrix ( l: (*light*) ptr ) : mat4 = "sta#%"
