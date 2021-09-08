(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  vertex_hashtable.sats  ###

hashtable for vertices, allows duplicate vertices to be checked for
*)

staload "./../g_engine.sats"
staload "./vertex_list.sats"
staload "./int_list.sats"

typedef vertex_bucket = @{ keys=(*vertex_list*) ptr, values=(*int_list*) ptr }

typedef vertex_hashtable = @{ items=(*vertex_bucket*) ptr, table_size=int }

fun vertex_hash ( ht: (*vertex_hashtable*) ptr, v: vertex ) : int = "sta#%"

fun vertex_hashtable_new ( size: int ) : (*vertex_hashtable*) ptr = "sta#%"
fun vertex_hashtable_delete ( ht: (*vertex_hashtable*) ptr ) : void = "sta#%"

fun vertex_hashtable_set ( ht: (*vertex_hashtable*) ptr, key: vertex, value: int ) : void = "sta#%"
fun vertex_hashtable_get ( ht: (*vertex_hashtable*) ptr, key: vertex ) : int = "sta#%"
