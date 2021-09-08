(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  music.sats  ###

defines music files
*)

staload "./../g_engine.sats"
staload "./../SDL2/SDL_local.sats"

typedef music = @{
	handle=Mix_Music
}

fun mp3_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun ogg_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun music_delete ( m: (*music*) ptr ) : void = "sta#%"
