(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  spline.sats  ###

allows the creation of splines (think 2D curved lines)
*)

staload "./../g_engine.sats"

#define MAX_SPLINE_POINTS 20

typedef spline = @{
	num_points=int,
	y0d=float,
	ynd=float,
	x0d=float,
	xnd=float,
	x=float,//of size MAX_SPLINE_POINTS
	y=float,//of size MAX_SPLINE_POINTS
	yd=float,//of size MAX_SPLINE_POINTS
	xd=float//of size MAX_SPLINE_POINTS
}

fun spline_new () : (*spline*) ptr = "sta#%"
fun spline_delete ( s: (*spline*) ptr ) : void = "sta#%"

fun spline_add_point ( s: (*spline*) ptr, p: vec2 ) : void = "sta#%"
fun spline_get_point ( s: (*spline*) ptr, i: int ) : vec2 = "sta#%"
fun spline_set_point ( s: (*spline*) ptr, i: int, p: vec2 ) : void = "sta#%"

fun spline_update ( s: (*spline*) ptr ) : void = "sta#%"
fun spline_print ( s: (*spline*) ptr ) : void = "sta#%"

fun spline_get_x ( s: (*spline*) ptr, y: float ) : float = "sta#%"
fun spline_get_y ( s: (*spline*) ptr, x: float ) : float = "sta#%"
fun spline_get_x_between ( s: (*spline*) ptr, low: int, high: int, y: float ) : float = "sta#%"
fun spline_get_y_between ( s: (*spline*) ptr, low: int, high: int, x: float ) : float = "sta#%"

typedef color_curves = @{
	rgb_spline=(*spline*) ptr,
	r_spline=(*spline*) ptr,
	g_spline=(*spline*) ptr,
	b_spline=(*spline*) ptr,
	a_spline=(*spline*) ptr
}

fun color_curves_load ( filename: string ) : (*color_curves*) ptr = "sta#%"
fun color_curves_delete ( cc: (*color_curves*) ptr ) : void = "sta#%"
fun color_curves_write_lut ( cc: (*color_curves*) ptr, filename: string ) : void = "sta#%"
fun color_curves_map ( cc: (*color_curves*) ptr, in_color: vec3 ) : vec3 = "sta#%"
