(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  list.sats  ###

a dynamically expandable array of pointers
*)

staload "./../g_engine.sats"

typedef list = @{ num_items=int, num_slots=int, items=(*void ptr*) ptr }

fun list_new () : (*list*) ptr = "sta#%"

fun list_push_back ( l: (*list*) ptr, item: ptr ) : void = "sta#%"
fun list_pop_back ( l: (*list*) ptr ) : ptr = "sta#%"

fun list_pop_at ( l: (*list*) ptr, index: int ) : ptr = "sta#%"

fun list_remove ( l: (*list*) ptr, item: ptr ) : void = "sta#%"

fun list_get ( l: (*list*) ptr, index: int ) : ptr = "sta#%"
fun list_set ( l: (*list*) ptr, index: int, item: ptr ) : void = "sta#%"

fun list_is_empty ( l: (*list*) ptr ) : bool = "sta#%"

fun list_delete ( l: (*list*) ptr ) : void = "sta#%"
fun list_clear ( l: (*list*) ptr ) : void = "sta#%"

fun list_delete_with ( l: (*list*) ptr, func: ptr -> void ) : void = "sta#%"
fun list_clear_with ( l: (*list*) ptr, func: ptr -> void ) : void = "sta#%"
