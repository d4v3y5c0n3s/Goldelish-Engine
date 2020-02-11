(*
###  ui_browser.sats  ###

(unclear what this is) maybe a ui window of some kind?
*)

#include "./ui/ui_rectangle.sats"
#include "./ui/ui_text.sats"
#include "./ui/ui_listbox.sats"

typedef ui_browser = @{
	outer=ui_rectangle ptr,
	inner=ui_listbox ptr,
	directory=fpath,
	active=bool
}

fun ui_browser_new () : ui_browser ptr = "sta#%"
fun ui_browser_delete ( b: ui_browser ptr ) : void = "sta#%"

fun ui_browser_chdir ( b: ui_browser ptr, dir: fpath ) : void = "sta#%"

fun ui_browser_event ( b: ui_browser ptr, e: SDL_Event ) : void = "sta#%"
fun ui_browser_update ( b: ui_browser ptr ) : void = "sta#%"
fun ui_browser_render ( b: ui_browser ptr ) : void = "sta#%"
