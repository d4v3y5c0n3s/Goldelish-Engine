(*
###  ui_button.hats  ###

button which may be clicked on
*)

#include "g_engine.hats"
#include "ui/ui_text.hats"
#include "ui/ui_rectangle.hats"

typedef ui_button = @{
	back=ui_rectangle ptr,
	label=ui_text ptr,
	up_color=vec4,
	down_color=vec4,
	onclick: ui_button ptr, ptr, -> void,//(this is a function pointer)
	onclick_data: ptr,
	active: bool,
	enabled: bool,
	pressed: bool
}

fun ui_button_new () : ui_button ptr = "sta#%"
fun ui_button_delete ( b: ui_button ptr ) : void = "sta#%"

fun ui_button_move ( b: ui_button ptr, pos: vec2 ) : void = "sta#%"
fun ui_button_resize ( b: ui_button ptr, size: vec2 ) : void = "sta#%"
fun ui_button_set_label ( b: ui_button ptr, label: char ptr ) : void = "sta#%"
fun ui_button_set_label_color ( b: ui_button ptr, color: vec4 ) : void = "sta#%"
fun ui_button_set_font ( b: ui_button ptr, f: asset_hndl ) : void = "sta#%"
fun ui_button_set_onclick ( b: ui_button ptr, onclick: ui_button ptr, ptr -> void(*this is a function pointer*)
fun ui_button_set_onclick_data ( b: ui_button ptr, data: ptr ) : void = "sta#%"
fun ui_button_set_active ( b: ui_button ptr, active: ) : void = "sta#%"
fun ui_button_set_enabled ( b: ui_button ptr, enabled: bool ) : void = "sta#%"
fun ui_button_set_texture ( b: ui_button ptr, tex: asset_hndl, width: int, height: int, tile: bool ) : void = "sta#%"
fun ui_button_disable ( b: ui_button ptr ) : void = "sta#%"
fun ui_button_enable ( b: ui_button ptr ) : void = "sta#%"

fun ui_button_position ( b: ui_button ptr ) : vec2 = "sta#%"
fun ui_button_size ( b: ui_button ptr ) : vec2 = "sta#%"

fun ui_button_event ( b: ui_button ptr, e: SDL_Event ) : void = "sta#%"
fun ui_button_update ( b: ui_button ptr ) : void = "sta#%"
fun ui_button_render ( b: ui_button ptr ) : void = "sta#%"

fun ui_button_contains_point ( b: ui_button ptr, pos: vec2 ) : bool = "sta#%"
