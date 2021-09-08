(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  ui_button.sats  ###

button which may be clicked on
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./ui_text.sats"
staload "./ui_rectangle.sats"

typedef ui_button = @{
	back=(*ui_rectangle*) ptr,
	label=(*ui_text*) ptr,
	up_color=vec4,
	down_color=vec4,
	//onclick: ui_button ptr, ptr, -> void,//(this is a function pointer)
	onclick_data=ptr,
	active=bool,
	enabled=bool,
	pressed=bool
}

fun ui_button_new () : (*ui_button*) ptr = "sta#%"
fun ui_button_delete ( b: (*ui_button*) ptr ) : void = "sta#%"

fun ui_button_move ( b: (*ui_button*) ptr, pos: vec2 ) : void = "sta#%"
fun ui_button_resize ( b: (*ui_button*) ptr, size: vec2 ) : void = "sta#%"
fun ui_button_set_label ( b: (*ui_button*) ptr, label: string ) : void = "sta#%"
fun ui_button_set_label_color ( b: (*ui_button*) ptr, color: vec4 ) : void = "sta#%"
fun ui_button_set_font ( b: (*ui_button*) ptr, f: asset_hndl ) : void = "sta#%"
fun ui_button_set_onclick ( b: (*ui_button*) ptr(*, onclick: (*ui_button*) ptr, ptr -> void(*this is a function pointer*)*) ) : void = "sta#%"
fun ui_button_set_onclick_data ( b: (*ui_button*) ptr, data: ptr ) : void = "sta#%"
fun ui_button_set_active ( b: (*ui_button*) ptr, active: bool ) : void = "sta#%"
fun ui_button_set_enabled ( b: (*ui_button*) ptr, enabled: bool ) : void = "sta#%"
fun ui_button_set_texture ( b: (*ui_button*) ptr, tex: asset_hndl, width: int, height: int, tile: bool ) : void = "sta#%"
fun ui_button_disable ( b: (*ui_button*) ptr ) : void = "sta#%"
fun ui_button_enable ( b: (*ui_button*) ptr ) : void = "sta#%"

fun ui_button_position ( b: (*ui_button*) ptr ) : vec2 = "sta#%"
fun ui_button_size ( b: (*ui_button*) ptr ) : vec2 = "sta#%"

fun ui_button_event ( b: (*ui_button*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_button_update ( b: (*ui_button*) ptr ) : void = "sta#%"
fun ui_button_render ( b: (*ui_button*) ptr ) : void = "sta#%"

fun ui_button_contains_point ( b: (*ui_button*) ptr, pos: vec2 ) : bool = "sta#%"
