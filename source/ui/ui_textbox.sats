(*
###  ui_textbox.sats  ###

a box which allows text to be entered
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./ui_rectangle.sats"
staload "./ui_text.sats"

typedef ui_textbox = @{
	outer=(*ui_rectangle*) ptr,
	inner=(*ui_rectangle*) ptr,
	contents=(*ui_text*) ptr,
	label=(*ui_text*) ptr,
	password=bool,
	max_chars=int,
	selected=bool,
	active=bool,
	enabled=bool
}

fun ui_textbox_new () : (*ui_textbox*) ptr = "sta#%"
fun ui_textbox_delete ( tb: (*ui_textbox*) ptr ) : void = "sta#%"

fun ui_textbox_set_password ( tb: (*ui_textbox*) ptr, password: bool ) : void = "sta#%"
fun ui_textbox_set_max_chars ( tb: (*ui_textbox*) ptr, l: int ) : void = "sta#%"
fun ui_textbox_addchar ( tb: (*ui_textbox*) ptr, c: char ) : void = "sta#%"
fun ui_textbox_rmchar ( tb: (*ui_textbox*) ptr ) : void = "sta#%"

fun ui_textbox_move ( tb: (*ui_textbox*) ptr, pos: vec2 ) : void = "sta#%"
fun ui_textbox_resize ( tb: (*ui_textbox*) ptr, size: vec2 ) : void = "sta#%"

fun ui_textbox_set_font ( tb: (*ui_textbox*) ptr, f: asset_hndl ) : void = "sta#%"
fun ui_textbox_set_label ( tb: (*ui_textbox*) ptr, label: string ) : void = "sta#%"
fun ui_textbox_set_contents ( tb: (*ui_textbox*) ptr, label: string ) : void = "sta#%"
fun ui_textbox_set_alignment ( tb: (*ui_textbox*) ptr, halign: int, valign: int ) : void = "sta#%"

fun ui_textbox_disable ( tb: (*ui_textbox*) ptr ) : void = "sta#%"
fun ui_textbox_enable ( tb: (*ui_textbox*) ptr ) : void = "sta#%"

fun ui_textbox_event ( tb: (*ui_textbox*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_textbox_update ( tb: (*ui_textbox*) ptr ) : void = "sta#%"
fun ui_textbox_render ( tb: (*ui_textbox*) ptr ) : void = "sta#%"

fun ui_textbox_contains_point ( tb: (*ui_textbox*) ptr, p: vec2 ) : bool = "sta#%"