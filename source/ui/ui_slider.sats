(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  ui_slider.sats  ###

used to slide through a range of values
*)

staload "./../g_engine.sats"
staload "./ui_rectangle.sats"
staload "./ui_button.sats"

typedef ui_slider = @{
	label=(*ui_button*) ptr,
	slot=(*ui_rectangle*) ptr,
	bar=(*ui_rectangle*) ptr,
	pressed=bool,
	active=bool,
	amount=float
}

fun ui_slider_new () : (*ui_slider*) ptr = "sta#%"
fun ui_slider_delete ( s: (*ui_slider*) ptr ) : void = "sta#%"

fun ui_slider_set_label ( s: (*ui_slider*) ptr, label: string ) : void = "sta#%"
fun ui_slider_move ( s: (*ui_slider*) ptr, position: vec2 ) : void = "sta#%"
fun ui_slider_set_amount ( s: (*ui_slider*) ptr, amount: float ) : void = "sta#%"
fun ui_slider_get_amount ( s: (*ui_slider*) ptr ) : float = "sta#%"
fun ui_slider_set_active ( s: (*ui_slider*) ptr, active: bool ) : void = "sta#%"

fun ui_slider_deactivate ( s: (*ui_slider*) ptr ) : void = "sta#%"
fun ui_slider_activate ( s: (*ui_slider*) ptr ) : void = "sta#%"

fun ui_slider_event ( s: (*ui_slider*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_slider_update ( s: (*ui_slider*) ptr ) : void = "sta#%"
fun ui_slider_render ( s: (*ui_slider*) ptr ) : void = "sta#%"
