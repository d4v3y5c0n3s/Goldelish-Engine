(*
###  ui_text.sats  ###

allows the usage of text in the ui
*)

#include "./g_engine.sats"
#include "./g_asset.sats"

datatype TEXT_HORIZ_ALIGN =
| TEXT_ALIGN_LEFT of ()
| TEXT_ALIGN_RIGHT of ()
| TEXT_ALIGN_CENTER of ()

datatype TEXT_VERT_ALIGN =
| TEXT_ALIGN_TOP of ()
| TEXT_ALIGN_BOTTOM of ()

typedef ui_text = @{
	string=string,
	positions_buffer=GLuint,
	texcoords_buffer=GLuint,
	colors_buffer=GLuint,
	num_positions=int,
	num_texcoords=int,
	top_left=vec2,
	bottom_right=vec2,
	font=asset_hndl,
	position=vec2,
	scale=vec2,
	color=vec4,
	halign=int,
	valign=int,
	line_spacing=float,
	char_spacing=float,
	rotation=float,
	line_length=float,
	active=bool
}

fun ui_text_new () : ui_text ptr = "sta#%"
fun ui_text_new_string ( string: string ) : ui_text ptr = "sta#%"
fun ui_text_delete ( text: ui_text ptr ) : void = "sta#%"

fun ui_text_move ( text: ui_text ptr, pos: vec2 ) : void = "sta#%"
fun ui_text_set_font ( text: ui_text ptr, font: asset_hndl ) : void = "sta#%"
fun ui_text_set_color ( text: ui_text ptr, color: vec4 ) : void = "sta#%"
fun ui_text_set_scale ( text: ui_text ptr, scale: vec2 ) : void = "sta#%"
fun ui_text_align ( text: ui_text ptr, halign: int, valign: int ) : void = "sta#%"

fun ui_text_draw ( text: ui_text ptr ) : void = "sta#%"
fun ui_text_draw_string ( text: ui_text ptr, string: string ) : void = "sta#%"

fun ui_text_event ( text: ui_text ptr, e: SDL_Event ) : void = "sta#%"
fun ui_text_update ( text: ui_text ptr ) : void = "sta#%"
fun ui_text_render ( text: ui_text ptr ) : void = "sta#%"

fun ui_text_contains_point ( text: ui_text ptr, position: vec2 ) : bool = "sta#%"