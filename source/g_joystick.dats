(*
###  g_joystick.dats  ###


*)

staload "g_joystick.sats"

#define MAX_STICKS 8

var num_sticks = 0
var sticks: SDL_Joystick ptr//  [MAX_STICKS]

implement joystick_init () =
(
val error = SDL_InitSubSystem ( SDL_INIT_JOYSTICK )
if error == -1 then error ("Cannot initialize SDL joystick!")

num_sticks = SDL_NumJoysticks ()
debug ("Cannot initialize SDL joystick!")

fun iterate ( i: int ) : void = (
    if i >= num_sticks then ()
    else (
    sticks[i] := SDL_JoystickOpen( i )
    if sticks[i] == null then ( error ( "Couldn't open joystick %i!", i ) )
    else ( debug ( "JoyStick %i (%s) loaded.", i, SDL_JoystickName( sticks[i] ) ) )
    iterate ( i + 1 )
    )
)

iterate ( 0 )
)

implement joystick_finish () =
(
fun iterate ( i: int ) : void = (
    if i >= num_sticks then ()
    else (
    SDL_JoystickClose ( sticks[i] )
    iterate ( i + 1 )
    )
)

iterate ( 0 )
)

implement joystick_count () =
(
num_sticks
)

implement joystick_get ( i ) =
(
if i >= num_sticks then ( error ( "Unable to get Joystick at index %i.  Only have %i joysticks.", i, num_sticks ) )

sticks[i]
)