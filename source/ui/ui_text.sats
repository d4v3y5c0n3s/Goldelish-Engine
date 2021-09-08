(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  ui_text.sats  ###

allows the usage of text in the ui
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

datatype TEXT_HORIZ_ALIGN =
| TEXT_ALIGN_LEFT of ()
| TEXT_ALIGN_RIGHT of ()
| TEXT_ALIGN_CENTER of ()

datatype TEXT_VERT_ALIGN =
| TEXT_ALIGN_TOP of ()
| TEXT_ALIGN_BOTTOM of ()

vtypedef ui_text = @{
	string=string,
	positions_buffer=$extype"GLuint",
	texcoords_buffer=$extype"GLuint",
	colors_buffer=$extype"GLuint",
	num_positions=int,
	num_texcoords=int,
	top_left=vec2,
	bottom_right=vec2,
	font=asset_hndl,
	position=vec2,
	scale=vec2,
	color=vec4,
	halign=int,
	valign=int,
	line_spacing=float,
	char_spacing=float,
	rotation=float,
	line_length=float,
	active=bool
}

fun ui_text_new () : ptr = "sta#%"
fun ui_text_new_string ( string: string ) : ptr = "sta#%"
fun ui_text_delete ( text: ptr ) : void = "sta#%"

fun ui_text_move ( text: ptr, pos: vec2 ) : void = "sta#%"
fun ui_text_set_font ( text: ptr, font: asset_hndl ) : void = "sta#%"
fun ui_text_set_color ( text: ptr, color: vec4 ) : void = "sta#%"
fun ui_text_set_scale ( text: ptr, scale: vec2 ) : void = "sta#%"
fun ui_text_align ( text: ptr, halign: int, valign: int ) : void = "sta#%"

fun ui_text_draw ( text: ptr ) : void = "sta#%"
fun ui_text_draw_string ( text: ptr, string: string ) : void = "sta#%"

fun ui_text_event ( text: ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_text_update ( text: ptr ) : void = "sta#%"
fun ui_text_render ( text: ptr ) : void = "sta#%"

fun ui_text_contains_point ( text: ptr, position: vec2 ) : bool = "sta#%"
