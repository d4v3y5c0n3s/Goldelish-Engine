(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  randf.sats  ###

allows the creation of random floats
*)

staload "./../g_engine.sats"

fun randf () : float = "sta#%"
fun randf_seed ( s: float ) : float = "sta#%"

fun randf_n () : float = "sta#%"
fun randf_nseed ( s: float ) : float = "sta#%"

fun randf_scale ( s: float ) : float = "sta#%"

fun randf_nscale ( s: float ) : float = "sta#%"

fun randf_range ( s: float, e: float ) : float = "sta#%"

fun randf_circle ( radius: float ) : vec2 = "sta#%"
