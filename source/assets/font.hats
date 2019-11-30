(*
###  font.hats  ###

defines a font's data
*)

#include "g_engine.hats"
#include "gasset.hats"

typedef font = @{
	texture_map=asset_hndl,
	width=int,
	height=int,
	locations=vec2 ptr,
	sizes=vec2 ptr,
	offsets=vec2 ptr,
}

fun font_load_file ( filename: char ptr ) : font ptr = "sta#%"
fun font_delete ( font: font ptr ) : void = "sta#%"
