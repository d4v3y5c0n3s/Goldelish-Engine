(*
###  g_joystick.sats  ###

a basic layer for SDL controls
*)

#include "./g_engine.sats"

fun joystick_init () : void = "sta#%"
fun joystick_finish () : void = "sta#%"

fun joystick_count () : int = "sta#%"
fun joystick_get () : SDL_Joystick ptr = "sta#%"
