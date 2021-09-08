(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  material.sats  ###

definition of object materials
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./shader.sats"

vtypedef material_item = [a:vt@ype] @{
	as_int=int,
	as_float=float,
	as_vec2=vec2,
	as_vec3=vec3,
	as_vec4=vec4,
	as_asset=asset_hndl(a)
}

(*
the below should either be made a datatype, or declared in the .dats file instead

val mat_item_int = 0
val mat_item_float = 1
val mat_item_vec2 = 2
val mat_item_vec3 = 3
val mat_item_vec4 = 4
val mat_item_shader = 5
val mat_item_texture = 6
*)

typedef material_entry = @{
	program=(*shader_program*) ptr,
	num_items=int,
	types=(*int*) ptr,
	names=string,
	items=(*material_item*) ptr
}

fun material_entry_delete ( me: (*material_entry*) ptr ) : void = "sta#%"
fun material_entry_item ( me: (*material_entry*) ptr, name: string ) : material_item = "sta#%"
fun material_entry_has_item ( me: (*material_entry*) ptr, name: string ) : bool = "sta#%"
fun material_entry_add_item ( me: (*material_entry*) ptr, name: string, type: int, mi: material_item ) : void = "sta#%"

typedef material = @{ num_entries=int, entries=(*material_entry ptr*) ptr }

fun material_new () : (*material*) ptr = "sta#%"
fun material_delete ( m: (*material*) ptr ) : void = "sta#%"

fun mat_load_file ( filename: string ) : (*material*) ptr = "sta#%"

fun material_get_entry ( m: (*material*) ptr, index: int ) : (*material_entry*) ptr = "sta#%"
fun material_add_entry ( m: (*material*) ptr ) : (*material_entry*) ptr = "sta#%"

fun material_first_program ( m: (*material*) ptr ) : (*shader_program*) ptr = "sta#%"
