(*
###  ui_listbox.sats  ###

used to display arrays of objects
*)

staload "./../g_engine.sats"
staload "./ui_rectangle.sats"
staload "./ui_text.sats"

typedef ui_listbox = @{
	back=(*ui_rectangle*) ptr,
	scroll=int, num_items=int, items=(*ui_text ptr*) ptr,
	active=bool(*, onselect: ui_text ptr -> void(*function pointer*)*)
}

fun ui_listbox_new () : (*ui_listbox*) ptr = "sta#%"
fun ui_listbox_delete ( lb: (*ui_listbox*) ptr ) : void = "sta#%"

fun ui_listbox_clear ( lb: (*ui_listbox*) ptr ) : void = "sta#%"
fun ui_listbox_add_item ( lb: (*ui_listbox*) ptr, item: string ) : (*ui_text*) ptr = "sta#%"

fun ui_listbox_move ( lb: (*ui_listbox*) ptr, pos: vec2 ) : void = "sta#%"
fun ui_listbox_resize ( lb: (*ui_listbox*) ptr, size: vec2 ) : void = "sta#%"

fun ui_listbox_event ( lb: (*ui_listbox*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_listbox_update ( lb: (*ui_listbox*) ptr ) : void = "sta#%"
fun ui_listbox_render ( lb: (*ui_listbox*) ptr ) : void = "sta#%"

fun ui_listbox_set_onselect ( lb: (*ui_listbox*) ptr(*, onselect: ui_text ptr -> void(*function pointer*)*) ) : void = "sta#%"
