(*
###  font.sats  ###

defines a font's data
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

vtypedef font = @{
	texture_map=asset_hndl,
	width=int,
	height=int,
	locations=(*vec2*) ptr,
	sizes=(*vec2*) ptr,
	offsets=(*vec2*) ptr
}

fun font_load_file ( filename: string ) : (*font*) ptr = "sta#%"
fun font_delete ( font: (*font*) ptr ) : void = "sta#%"
