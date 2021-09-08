(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  camera.sats  ###

a basic camera
*)

staload "./../g_engine.sats"
staload "./../g_joystick.sats"

typedef camera = @{
	position=vec3,
	target=vec3,
	fov=float,
	near_clip=float,
	far_clip=float
}

fun camera_new () : (*camera*) ptr = "sta#%"
fun camera_delete ( cam: (*camera*) ptr ) : void = "sta#%"

fun camera_direction ( c: (*camera*) ptr ) : vec3 = "sta#%"
fun camera_view_matrix ( c: (*camera*) ptr ) : mat4 = "sta#%"
fun camera_proj_matrix ( c: (*camera*) ptr ) : mat4 = "sta#%"
fun camera_view_proj_matrix ( c: (*camera*) ptr ) : mat4 = "sta#%"

fun camera_normalize_target ( c: (*camera*) ptr ) : void = "sta#%"
fun camera_control_orbit ( c: (*camera*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun camera_control_freecam ( c: (*camera*) ptr, timestep: float ) : void = "sta#%"
fun camera_control_joyorbit ( c: (*camera*) ptr, timestep: float ) : void = "sta#%"
