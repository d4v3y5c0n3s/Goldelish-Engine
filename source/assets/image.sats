(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  image.sats  ###

defines an image (and allows CPU-side image processing)
*)

staload "./../g_engine.sats"

#define IMAGE_REPEAT_TILE 0
#define IMAGE_REPEAT_CLAMP 1
#define IMAGE_REPEAT_MIRROR 2
#define IMAGE_REPEAT_ERROR 3
#define IMAGE_REPEAT_BLACK 4

#define IMAGE_SAMPLE_LINEAR 0
#define IMAGE_SAMPLE_NEAREST 1

absvt@ype image (w:int, h:int, rt:int, st:int)
vtypedef image = [w,h,rt,st:int] image(w, h, rt, st)

sortdef rt_IRT = {rt:int | rt==IMAGE_REPEAT_TILE}
sortdef st_ISL = {st:int | st==IMAGE_SAMPLE_LINEAR}

fn image_new {w,h:nat; rt:rt_IRT; st:st_ISL} ( width: int w, height: int h, data: arrayptr(uchar,w*h*4) ) : image(w,h,rt,st)

fn image_blank {w,h:nat; rt:rt_IRT; st:st_ISL} ( width: int w, height: int h ) : image(w,h,rt,st)
fn image_copy {w,h,rt,st:nat} ( src: !image(w,h,rt,st) ) : image(w,h,rt,st)
fn image_delete ( i: image ) : void

fn image_get ( i: !image, u: int, v: int ) : vec4
fn image_set ( i: !image, u: int, v: int, c: vec4 ) : void
fn image_map ( i: !image, f: vec4 -<fun1> vec4 ) : void

fn image_red_channel ( src: !image ) : image
fn image_green_channel ( src: !image ) : image
fn image_blue_channel ( src: !image ) : image
fn image_alpha_channel ( src: !image ) : image

fn image_bgr_to_rgb ( i: !image ) : void
fn image_rotate_90_clockwise ( i: !image ) : void
fn image_rotate_90_counterclockwise ( i: !image ) : void
fn image_rotate_180 ( i: !image ) : void
fn image_rotate_inplace ( i: !image, amount: float ) : void
fn image_flip_horizontal ( i: !image ) : void
fn image_flip_vertical ( i: !image ) : void

fn image_fill ( i: !image, color: vec4 ) : void
fn image_fill_black ( i: !image ) : void
fn image_fill_white ( i: !image ) : void

fn image_apply_gamma ( i: !image, amount: float ) : void
fn image_to_gamma ( i: !image ) : void
fn image_from_gamma ( i: !image ) : void

fn image_rgb_to_hsv ( i: !image ) : void
fn image_hsv_to_rgb ( i: !image ) : void
fn image_hsv_scalar ( i: !image ) : void

fn image_min ( i: !image ) : vec4
fn image_max ( i: !image ) : vec4
fn image_mean ( i: !image ) : vec4
fn image_var ( i: !image ) : vec4
fn image_std ( i: !image ) : vec4
fn image_auto_contrast ( i: !image ) : void
fn image_set_to_mask ( i: !image ) : void
fn image_set_brightness ( i: !image ) : void

fn image_alpha_mean ( i: !image ) : vec4

fn image_get_subimage {w1,w2,h1,h2,rt,st:nat} ( src: !image(w1,h1,rt,st), left: int, top: int, width: int w1, height: int h1 ) : image(w2,h2,rt,st)

fn image_set_subimage {w1,w2,h1,h2,rt,st:nat} ( i: !image(w1,h1,rt,st), left: int, top: int, src: !image(w2,h2,rt,st) ) : void
fn image_paste_subimage {w1,w2,h1,h2,rt,st:nat} ( i: !image(w1,h1,rt,st), left: int, top: int, src: !image(w2,h2,rt,st) ) : void

fn image_sample ( i: !image, uv: vec2 ) : vec4
fn image_paint ( i: !image, uv: vec2, color: vec4 ) : void

fn image_scale ( i: !image, scale: vec2 ) : void

fn image_mask_not ( i: !image ) : void
fn image_mask_binary ( i0: !image, i1: !image, f: bool -<fun1> (bool, bool) ) : void
fn image_mask_or ( i0: !image, i1: !image ) : void
fn image_mask_and ( i0: !image, i1: !image ) : void
fn image_mask_xor ( i0: !image, i1: !image ) : void
fn image_mask_nor ( i0: !image, i1: !image ) : void
fn image_mask_nand ( i0: !image, i1: !image ) : void
fn image_mask_xnor ( i0: !image, i1: !image ) : void

fn image_mask_alpha ( i: !image ) : image
fn image_mask_nearest ( i: !image ) : image
fn image_mask_nearest ( i: !image ) : image
fn image_mask_flood_fill ( src: !image, u: int, v: int, tolerance: float ) : image
fn image_mask_difference ( src: !image, color: vec4, tolerance: float ) : image

fn image_mask_count ( i: !image ) : lint
fn image_mask_median ( i: !image, u: &int, v: &int ) : void
fn image_mask_random ( i: !image, u: &int, v: &int ) : void

fn image_read_from_file ( filename: string ) : image
fn image_tga_load_file ( filename: string ) : image
fn image_bmp_load_file ( filename: string ) : image

fn image_write_to_file ( i: !image, filename: string ) : void
fn image_tga_save_file ( i: !image, filename: string ) : void
fn image_bmp_save_file ( i: !image, filename: string ) : void
