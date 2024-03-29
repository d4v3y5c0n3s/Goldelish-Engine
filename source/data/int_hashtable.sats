(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  int_hashtable.sats  ###

a hashtable for integers
*)

staload "./../g_engine.sats"
staload "./int_list.sats"

typedef int_bucket = @{ keys=(*list*) ptr, values=(*int_list*) ptr }

typedef int_hashtable = @{ items=(*int_bucket*) ptr, table_size=int }

fun int_hashtable_hash ( ht: (*int_hashtable*) ptr, key: string ) : int = "sta#%"

fun int_hashtable_new ( size: int ) : (*int_hashtable*) ptr = "sta#%"
fun int_hashtable_delete ( ht: (*int_hashtable*) ptr ) : void = "sta#%"

fun int_hashtable_set ( ht: (*int_hashtable*) ptr, key: string, value: int ) : void = "sta#%"
fun int_hashtable_get ( ht: (*int_hashtable*) ptr, key: string ) : int = "sta#%"
