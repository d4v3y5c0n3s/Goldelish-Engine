(*
###  ui_browser.sats  ###

(unclear what this is) maybe a ui window of some kind?
*)

staload "./../g_engine.sats"
staload "./ui_rectangle.sats"
staload "./ui_text.sats"
staload "./ui_listbox.sats"

vtypedef ui_browser = @{
	outer=(*ui_rectangle*) ptr,
	inner=(*ui_listbox*) ptr,
	directory=fpath,
	active=bool
}

fun ui_browser_new () : (*ui_browser*) ptr = "sta#%"
fun ui_browser_delete ( b: (*ui_browser*) ptr ) : void = "sta#%"

fun ui_browser_chdir ( b: (*ui_browser*) ptr, dir: fpath ) : void = "sta#%"

fun ui_browser_event ( b: (*ui_browser*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_browser_update ( b: (*ui_browser*) ptr ) : void = "sta#%"
fun ui_browser_render ( b: (*ui_browser*) ptr ) : void = "sta#%"
