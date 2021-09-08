(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_joystick.sats  ###

a basic layer for SDL controls
*)

staload "./g_engine.sats"
staload "./SDL2/SDL_local.sats"

absvtype joysticks = ptr

fn joystick_init () : Option_vt(joysticks)
fn joystick_finish ( joysticks ) : void

fn joystick_count ( !joysticks ) : int
fn joystick_get ( !joysticks, int ) : Option_vt(SDL_Joystick_ptr1)
