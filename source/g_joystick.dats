(*
###  g_joystick.dats  ###


*)

staload "g_joystick.sats"

#define MAX_STICKS 8

var num_sticks = 0
var sticks: SDL_Joystick ptr//  [MAX_STICKS]

implement joystick_init () =
(
)

implement joystick_finish () =

implement joystick_count () =

implement joystick_get () =