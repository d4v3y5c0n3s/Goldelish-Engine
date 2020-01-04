(*
###  g_graphics.sats  ###

a basic layer for the graphics system
*)

#include "g_engine.sats"

fun graphics_init () : void = "sta#%"
fun graphics_finish () : void = "sta#%"

fun graphics_set_vsync ( vsync: bool ) : void = "sta#%"
fun graphics_set_multisamples ( samples: int ) : void = "sta#%"
fun graphics_set_fullscreen ( fullscreen: bool ) : void = "sta#%"
fun graphics_set_antialiasing ( quality: int ) : void = "sta#%"

fun graphics_context_new () : SDL_GLContext ptr = "sta#%"
fun graphics_context_delete ( context: SDL_GLContext ptr ) : void = "sta#%"
fun graphics_context_current ( context: SDL_GLContext ptr ) : void = "sta#%"

fun graphics_get_multisamples () : int = "sta#%"
fun graphics_get_fullscreen () : bool = "sta#%"
fun graphics_get_antialiasing () : int = "sta#%"

fun graphics_viewport_set_title ( title: string ) : void = "sta#%"
fun graphics_viewport_set_icon ( icon: fpath ) : void = "sta#%"
fun graphics_viewport_set_position ( x: int, y: int ) : void = "sta#%"
fun graphics_viewport_set_size ( w: int, h: int ) : void = "sta#%"
fun graphics_viewport_screenshot () : void = "sta#%"

fun graphics_viewport_title () : string = "sta#%"
fun graphics_viewport_height () : int = "sta#%"
fun graphics_viewport_width () : int = "sta#%"
fun graphics_viewport_ratio () : float = "sta#%"

fun graphics_set_cursor_hidden ( hidden: bool ) : void = "sta#%"
fun graphics_get_cursor_hidden () : bool = "sta#%"

fun graphics_swap () : void = "sta#%"
