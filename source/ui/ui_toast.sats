(*
###  ui_toast.sats  ###

a notifacation window
*)

#include "./g_engine.sats"
#include "./ui/ui_text.sats"
#include "./ui/ui_rectangle.sats"

typedef ui_toast = @{
	label=ui_text ptr,
	opacity=float,
	active=bool
}

fun ui_toast_popup ( fmt: string (*, ...*) ) : void = "sta#%"

fun ui_toast_new () : ui_toast ptr = "sta#%"
fun ui_toast_delete ( t: ui_toast ptr ) : void = "sta#%"

fun ui_toast_set_label ( t: ui_toast ptr, label: string ) : void = "sta#%"
fun ui_toast_set_font ( t: ui_toast ptr, f: asset_hndl ) : void = "sta#%"

fun ui_toast_event ( t: ui_toast ptr, e: SDL_Event ) : void = "sta#%"
fun ui_toast_update ( t: ui_toast ptr ) : void = "sta#%"
fun ui_toast_render ( t: ui_toast ptr ) : void = "sta#%"
