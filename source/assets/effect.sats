(*
###  effect.sats  ###

defines a visual effect within the engine
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/texture.sats"

staload "./../SDL2/SDL_local.sats"

typedef effect_key = @{
	time=float, rotation=float, rotation_r=float, scale=vec3, scale_r=vec3, color=vec4, color_r=vec4, force=vec3, force_r=vec3
}

fun effect_ket_lerp ( x: effect_key, y: effect_key, amount: float ) : effect_key

vtypedef effect = @{
	texture=asset_hndl(texture),
	texture_nm=asset_hndl(texture),
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
	keys=(*effect_key*) ptr
}

fun effect_new () : (*effect*) ptr
fun effect_load_file ( filename: string ) : (*effect*) ptr
fun effect_delete ( e: (*effect*) ptr ) : void

fun effect_get_key ( e: (*effect*) ptr, ptime: float ) : effect_key
