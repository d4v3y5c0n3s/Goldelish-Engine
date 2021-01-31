(*
###  g_joystick.sats  ###

a basic layer for SDL controls
*)

staload "./g_engine.sats"
staload "./SDL2/SDL_local.sats"

absvtype joysticks = ptr

fn joystick_init () : Option_vt(joysticks) = "sta#%"
fn joystick_finish ( joysticks ) : void = "sta#%"

fn joystick_count ( !joysticks ) : int = "sta#%"
fn joystick_get ( !joysticks, int ) : Option_vt(SDL_Joystick_ptr1) = "sta#%"
