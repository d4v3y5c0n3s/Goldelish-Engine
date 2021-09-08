(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  image.sats  ###

defines an image (and allows CPU-side image processing)
*)

staload "./../g_engine.sats"

typedef image = @{
	width=int,
	height=int,
	data=(*unsigned*) string,//<-- probably revise this
	repeat_type=int,
	sample_type=int
}

datatype REPEAT =
	 | IMAGE_REPEAT_TILE of ()
	 | IMAGE_REPEAT_CLAMP of ()
	 | IMAGE_REPEAT_MIRROR of ()
	 | IMAGE_REPEAT_ERROR of ()
	 | IMAGE_REPEAT_BLACK of ()

datatype SAMPLE =
	 | IMAGE_SAMPLE_LINEAR of ()
	 | IMAGE_SAMPEL_NEAREST of ()

fun image_new ( width: int, height: int, data: (*unsigned*) string ) : (*image*) ptr = "sta#%"
fun image_empty ( width: int, height: int ) : (*image*) ptr = "sta#%"
fun image_blank ( width: int, height: int ) : (*image*) ptr = "sta#%"
fun image_copy ( src: (*image*) ptr ) : (*image*) ptr = "sta#%"
fun image_delete ( i: (*image*) ptr ) : void = "sta#%"

fun image_get ( i: (*image*) ptr, u: int, v: int ) : vec4 = "sta#%"
fun image_set ( i: (*image*) ptr, u: int, v: int, c: vec4 ) : void = "sta#%"
fun image_map ( i: (*image*) ptr, f: vec4 -> vec4 ) : void = "sta#%"//  revise to pass 'f' as a function pointer rather than a whole function

fun image_red_channel ( src: (*image*) ptr ) : (*image*) ptr = "sta#%"
fun image_green_channel ( src: (*image*) ptr ) : (*image*) ptr = "sta#%"
fun image_blue_channel ( src: (*image*) ptr ) : (*image*) ptr = "sta#%"
fun image_alpha_channel ( src: (*image*) ptr ) : (*image*) ptr = "sta#%"

fun image_bgr_to_rgb ( i: (*image*) ptr ) : void = "sta#%"
fun image_rotate_90_clockwise ( i: (*image*) ptr ) : void = "sta#%"
fun image_rotate_90_counterclockwise ( i: (*image*) ptr ) : void = "sta#%"
fun image_rotate_180 ( i: (*image*) ptr ) : void = "sta#%"
fun image_rotate_inplace ( i: (*image*) ptr, amount: float ) : void = "sta#%"
fun image_flip_horizontal ( i: (*image*) ptr ) : void = "sta#%"
fun image_flip_vertical ( i: (*image*) ptr ) : void = "sta#%"

fun image_fill ( i: (*image*) ptr, color: vec4 ) : void = "sta#%"
fun image_fill_black ( i: (*image*) ptr ) : void = "sta#%"
fun image_fill_white ( i: (*image*) ptr ) : void = "sta#%"

fun image_apply_gamma ( i: (*image*) ptr, amount: float ) : void = "sta#%"
fun image_to_gamma ( i: (*image*) ptr ) : void = "sta#%"
fun image_from_gamma ( i: (*image*) ptr ) : void = "sta#%"

fun image_rgb_to_hsv ( i: (*image*) ptr ) : void = "sta#%"
fun image_hsv_to_rgb ( i: (*image*) ptr ) : void = "sta#%"
fun image_hsv_scalar ( i: (*image*) ptr ) : void = "sta#%"

fun image_min ( i: (*image*) ptr ) : vec4 = "sta#%"
fun image_max ( i: (*image*) ptr ) : vec4 = "sta#%"
fun image_mean ( i: (*image*) ptr ) : vec4 = "sta#%"
fun image_var ( i: (*image*) ptr ) : vec4 = "sta#%"
fun image_std ( i: (*image*) ptr ) : vec4 = "sta#%"
fun image_auto_contrast ( i: (*image*) ptr ) : void = "sta#%"
fun image_set_to_mask ( i: (*image*) ptr ) : void = "sta#%"
fun image_set_brightness ( i: (*image*) ptr ) : void = "sta#%"

fun image_alpha_mean ( i: (*image*) ptr ) : vec4 = "sta#%"

fun image_get_subimage ( src: (*image*) ptr, left: int, top: int, width: int, height: int ) : (*image*) ptr = "sta#%"

fun image_set_subimage ( i: (*image*) ptr, left: int, top: int, src: (*image*) ptr ) : void = "sta#%"
fun image_paste_subimage ( i: (*image*) ptr, left: int, top: int, src: (*image*) ptr ) : void = "sta#%"

fun image_sample ( i: (*image*) ptr, uv: vec2 ) : vec4 = "sta#%"
fun image_paint ( i: (*image*) ptr, uv: vec2, color: vec4 ) : void = "sta#%"

fun image_scale ( i: (*image*) ptr, scale: vec2 ) : void = "sta#%"

fun image_mask_not ( i: (*image*) ptr ) : void = "sta#%"
fun image_mask_binary ( i0: (*image*) ptr, i1: (*image*) ptr, f: bool -> (bool, bool) ) : void = "sta#%"
fun image_mask_or ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"
fun image_mask_and ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"
fun image_mask_xor ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"
fun image_mask_nor ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"
fun image_mask_nand ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"
fun image_mask_xnor ( i0: (*image*) ptr, i1: (*image*) ptr ) : void = "sta#%"

fun image_mask_alpha ( i: (*image*) ptr ) : (*image*) ptr = "sta#%"
fun image_mask_nearest ( i: (*image*) ptr ) : (*image*) ptr = "sta#%"
(*fun image_mask_nearest ( i: (*image*) ptr ) : (*image*) ptr = "sta#%"*)
fun image_mask_flood_fill ( src: (*image*) ptr, u: int, v: int, tolerance: float ) : (*image*) ptr = "sta#%"
fun image_mask_difference ( src: (*image*) ptr, color: vec4, tolerance: float ) : (*image*) ptr = "sta#%"

fun image_mask_count ( i: (*image*) ptr ) : lint = "sta#%"
fun image_mask_median ( i: (*image*) ptr, u: (*int*) ptr, v: (*int*) ptr ) : void = "sta#%"
fun image_mask_random ( i: (*image*) ptr, u: (*int*) ptr, v: (*int*) ptr ) : void = "sta#%"

fun image_read_from_file ( filename: string ) : (*image*) ptr = "sta#%"
fun image_tga_load_file ( filename: string ) : (*image*) ptr = "sta#%"
fun image_bmp_load_file ( filename: string ) : (*image*) ptr = "sta#%"

fun image_write_to_file ( i: (*image*) ptr, filename: string ) : void = "sta#%"
fun image_tga_save_file ( i: (*image*) ptr, filename: string ) : void = "sta#%"
fun image_bmp_save_file ( i: (*image*) ptr, filename: string ) : void = "sta#%"
