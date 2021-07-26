(*
###  ui_rectangle.sats  ###

a rectangle shape for ui
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

vtypedef ui_rectangle = @{
	top_left=vec2, bottom_right=vec2,
	color=vec4, texture=asset_hndl, texture_width=int, texture_height=int, texture_tile=bool,
	border_size=float, border_color=vec4,
	glitch=float,time=float,
	blend_src=$extype"GLenum", blend_dst=$extype"GLenum",
	active=bool
}

fun ui_rectangle_new () : (*ui_rectangle*) ptr = "sta#%"
fun ui_rectangle_delete ( r: (*ui_rectangle*) ptr ) : void = "sta#%"

fun ui_rectangle_event ( r: (*ui_rectangle*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_rectangle_update ( r: (*ui_rectangle*) ptr ) : void = "sta#%"
fun ui_rectangle_render ( r: (*ui_rectangle*) ptr ) : void = "sta#%"

fun ui_rectangle_move ( r: (*ui_rectangle*) ptr, pos: vec2 ) : void = "sta#%"
fun ui_rectangle_resize ( r: (*ui_rectangle*) ptr, size: vec2 ) : void = "sta#%"
fun ui_rectangle_set_texture ( r: (*ui_rectangle*) ptr, tex: asset_hndl, width: int, height: int, tile: bool ) : void = "sta#%"
fun ui_rectangle_set_border ( r: (*ui_rectangle*) ptr, size: float, color: vec4 ) : void = "sta#%"
fun ui_rectangle_set_color ( r: (*ui_rectangle*) ptr, color: vec4 ) : void = "sta#%"
fun ui_rectangle_set_glitch ( r: (*ui_rectangle*) ptr, glitch: float ) : void = "sta#%"
fun ui_rectangle_center ( r: (*ui_rectangle*) ptr ) : vec2 = "sta#%"
fun ui_rectangle_contains_point ( r: (*ui_rectangle*) ptr, pos: vec2 ) : bool = "sta#%"
fun ui_rectangle_blend ( r: (*ui_rectangle*) ptr, blend_src: $extype"GLenum", blend_dst: $extype"GLenum" ) : void = "sta#%"

fun ui_rectangle_position ( r: (*ui_rectangle*) ptr ) : vec2 = "sta#%"
fun ui_rectangle_size ( r: (*ui_rectangle*) ptr ) : vec2 = "sta#%"
