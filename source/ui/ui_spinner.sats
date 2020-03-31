(*
###  ui_spinner.sats  ###

allows a spinning icon to appear to inform the user that the game is loading
*)

#include "./../g_engine.sats"
#include "./../g_asset.sats"

typedef ui_spinner = @{
	top_left=vec2,
	bottom_right=vec2,
	color=vec4,
	texture=asset_hndl,
	speed=float,
	rotation=float,
	active=bool
}

fun ui_spinner_new () : (*ui_spinner*) ptr = "sta#%"
fun ui_spinner_delete ( s: (*ui_spinner*) ptr ) : void = "sta#%"

fun ui_spinner_event ( s: (*ui_spinner*) ptr, e: SDL_Event ) : void = "sta#%"
fun ui_spinner_update ( s: (*ui_spinner*) ptr ) : void = "sta#%"
fun ui_spinner_render ( s: (*ui_spinner*) ptr ) : void = "sta#%"
