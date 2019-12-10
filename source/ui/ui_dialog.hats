(*
###  ui_dialog.hats  ###

a menu/information dialog
*)

#include "g_engine.hats"

#include "ui/ui_text.hats"
#include "ui/ui_button.hats"

extern val dialog_count = 0//  int

typedef ui_dialog = @{
	back=ui_button ptr, title=ui_text ptr, contents=ui_text ptr,
	single_button=bool,
	left=ui_button ptr, right=ui_button ptr
}

fun ui_dialog_new () : ui_dialog ptr = "sta#%"
fun ui_dialog_delete ( d: ui_dialog ptr ) : void = "sta#%"

fun ui_dialog_set_single_button ( d: ui_dialog ptr, single: bool ) : void = "sta#%"
fun ui_dialog_set_title ( d: ui_dialog ptr, title: char ptr ) : void = "sta#%"
fun ui_dialog_set_contents ( d: ui_dialog ptr, contents: char ptr ) : void = "sta#%"
fun ui_dialog_set_button_left ( d: ui_dialog ptr, left: char ptr, onleft: ui_button ptr, ptr -> void(*function pointer*) ) :
fun ui_dialog_set_button_right ( d: ui_dialog ptr, right: char ptr, onright: ui_button ptr, ptr -> void(*function pointer*) ) : void = "sta#%"
fun ui_dialog_set_font ( d: ui_dialog ptr, fnt: asset_hndl ) : void = "sta#%"

fun ui_dialog_event ( d: ui_dialog ptr, e: SDL_Event ) : void = "sta#%"
fun ui_dialog_update ( d: ui_dialog ptr ) : void = "sta#%"
fun ui_dialog_render ( d: ui_dialog ptr ) : void = "sta#%"
