(*
###  effect.hats  ###

defines a visual effect within the engine
*)

#include "g_engine.hats"
#include "gasset.hats"

typedef effect_key = @{
	time=float, rotation=float, rotation_r=float, scale=vec3, scale_r=vec3, color=vec4, color_r=vec4, force=vec3, force_r=vec3
}

fun effect_ket_lerp ( x: effect_key, y: effect_key, amount: float ) : effect_key = "sta#%"

typedef effect = @{
	texture=asset_hndl,
	texture_nm=asset_hndl,
	blend_src=GLuint,
	blend_dst=GLuint,
	count=int,
	depth=float,
	thickness=float,
	bumpiness=float,
	scattering=float,
	lifetime=float,
	output=float,
	output_r=float,
	alpha_decay=bool,
	color_decay=bool,
	keys_num=int,
	keys=effect_key ptr
}

fun effect_new () : effect ptr = "sta#%"
fun effect_load_file ( filename: string ) : effect ptr = "sta#%"
fun effect_delete ( e: effect ptr ) : void = "sta#%"

fun effect_get_key ( e: effect ptr, ptime: float ) : effect_key = "sta#%"
