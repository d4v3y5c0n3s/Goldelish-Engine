(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  font.sats  ###

defines a font's data
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

vtypedef font = @{
	texture_map=asset_hndl,
	width=int,
	height=int,
	locations=(*vec2*) ptr,
	sizes=(*vec2*) ptr,
	offsets=(*vec2*) ptr
}

fun font_load_file ( filename: string ) : (*font*) ptr = "sta#%"
fun font_delete ( font: (*font*) ptr ) : void = "sta#%"
