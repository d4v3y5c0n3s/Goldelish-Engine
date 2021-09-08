(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_ui.sats  ###

user interface manager
*)

staload "./ui/ui_style.sats"
staload "./g_engine.sats"

absvt@ype ui_elem

fun ui_init () : void = "sta#%"
fun ui_finish () : void = "sta#%"
fun ui_set_style ( s: ptr ) : void = "sta#%"

fun ui_event ( e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_update () : void = "sta#%"
fun ui_render () : void = "sta#%"

(*
#define ui_handler(type, new, delete, event, update, render)
*)

(*
void ui_handler_cast(int type_id,
  void* (*ui_elem_new_func)(), 
  void (*ui_elem_del_func)(ui_elem*), 
  void (*ui_elem_event_func)(ui_elem*, SDL_Event), 
  void (*ui_elem_update_func)(ui_elem*), 
  void (*ui_elem_render_func)(ui_elem*));
*)

(*
#define ui_elem_new(fmt, type, ...) (type*)ui_elem_new_type_id(fmt, typeid(type), ##__VA_ARGS__)
*)
(*
#define ui_elem_get_as(fmt, type, ...) ((type*)ui_elem_get_as_type_id(fmt, typeid(type), ##__VA_ARGS__))
*)

fun ui_elem_exists ( fmt: string ) : bool = "sta#%"
fun ui_elem_get ( fmt: string ) : ptr = "sta#%"
fun ui_elem_get_as_type_id ( fmt: string, type_id: int ) : ptr = "sta#%"
fun ui_elem_new_type_id ( fmt: string, type_id: int ) :  ptr = "sta#%"
fun ui_elem_delete ( fmt: string ) : void = "sta#%"
fun ui_elem_event ( fmt: string ) : void = "sta#%"
fun ui_elem_update ( fmt: string ) : void = "sta#%"
fun ui_elem_render ( fmt: string ) : void = "sta#%"

fun ui_elem_name ( e: ptr ) : string = "sta#%"
fun ui_elem_typename ( e: ptr ) : string = "sta#%"
