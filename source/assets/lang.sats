(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  lang.sats  ###

defines languages for the game to use
*)

staload "./../data/dict.sats"
staload "./../g_asset.sats"

typedef lang =  @{ map=(*dict*) ptr }

fun lang_load_file ( filename: string ) : (*lang*) ptr = "sta#%"
fun lang_delete ( t: (*lang*) ptr ) : void = "sta#%"
fun lang_get ( t: (*lang*) ptr, id: string ) : string = "sta#%"

fun set_language ( t: asset_hndl ) : void = "sta#%"
fun S ( id: string ) : string = "sta#%"
