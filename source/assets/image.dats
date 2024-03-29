(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  image.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./image.sats"

local

assume image (w,h,rt,st) = @{
  width=int w,
  height=int h,
  data=arrayptr(uchar,w*h*4),
  repeat_type=int rt,
  sample_type=int st
}

in

implement image_new {w,h,rt,st} ( width, height, data ) =
@{
  width=width,
  height=height,
  data=data,
  repeat_type=IMAGE_REPEAT_TILE,
  sample_type=IMAGE_SAMPLE_LINEAR
}:image(w,h,rt,st)


implement image_blank {w,h,rt,st} ( width, height ) = let
  val (pf1 | res) = g1int_mul2(width, height)
  prval () = mul_elim(pf1)
  prval () = mul_nat_nat_nat(pf1)
  val (pf2 | res) = g1int_mul2(res, 4)
  prval () = mul_elim(pf2)
  prval () = mul_nat_nat_nat(pf2)
in
  image_new(width, height, arrayptr_make_elt(size_of_int(res), c2uc('a')))
end

end////
implement image_copy ( src ) =
(
)

implement image_delete ( i ) =
(
)

implement image_wrap ( u, m, type ) =
(
)

implement image_get ( i, u, v ) =
(
)

implement image_set ( i, u, v, c ) =
(
)

implement image_map ( i, f ) =
(
)

implement image_channel ( src, chan ) =
(
)

implement image_red_channel ( src ) = ()
implement image_green_channel ( src ) = ()
implement image_blue_channel ( src ) = ()
implement image_alpha_channel ( src ) = ()

implement image_bgr_to_rgb ( i ) =
(
)

implement image_data_swap ( x, y ) =
(
)

implement image_rotate_90_clockwise ( i ) =
(
)

implement image_rotate_90_counterclockwise ( i ) =
(
)

implement image_rotate_inplace ( i, amount ) =
(
)

implement image_rotate_180 ( i ) =
(
)

implement image_flip_horizontal ( i ) =
(
)

implement image_flip_vertical ( i ) =
(
)

implement image_fill ( i, color ) =
(
)

implement image_fill_black ( i ) =
(
)

implement image_fill_white ( i ) =
(
)

implement image_apply_gamma ( i, amount ) =
(
)

implement image_to_gamma ( i ) = ()
implement image_from_gamma ( i ) = ()

implement image_rgb_to_hsv ( i ) =
(
)

implement image_hsv_to_rgb ( i ) =
(
)

implement image_hsv_scalar ( i ) =
(
)

implement image_min ( i ) =
(
)

implement image_max ( i ) =
(
)

implement image_mean ( i ) =
(
)

implement image_var ( i ) =
(
)

implement image_std ( i ) =
(
)

implement image_auto_contrast ( i ) =
(
)

implement image_alpha_mean ( i ) =
(
)

implement image_set_brightness ( i, b ) =
(
)

implement image_set_to_mask ( i ) =
(
)

implement image_set_subimage ( i, left, top, src ) =
(
)

implement image_paste_subimage ( i, left, top, src ) =
(
)

implement image_get_subimage ( src, left, top, width, height ) =
(
)

implement image_sample ( i, uv ) =
(
)

implement image_paint ( i, uv, color ) =
(
)

implement image_scale ( i, scale ) =
(
)

implement image_mask_not ( i ) =
(
)

implement image_mask_binary ( i0, i1, f ) =
(
)

implement image_op_and ( x, y ) = ()
implement image_op_or ( x, y ) = ()
implement image_op_xor ( x, y ) = ()
implement image_op_nor ( x, y ) = ()
implement image_op_nand ( x, y ) = ()
implement image_op_xnor ( x, y ) = ()

implement image_mask_or ( i0, i1 ) = ()
implement image_mask_and ( i0, i1 ) = ()
implement image_mask_xor ( i0, i1 ) = ()
implement image_mask_nor ( i0, i1 ) = ()
implement image_mask_nand ( i0, i1 ) = ()
implement image_mask_xnor ( i0, i1 ) = ()

implement image_mask_alpha ( i ) =
(
)

implement image_mask_threshold ( i, amount ) =
(
)

implement image_mask_nearest ( i ) =
(
)

implement image_flood_fill_mask ( src, u, v, tolerance ) =
(
)

implement image_difference_mask ( src, color, tolerance ) =
(
)

implement image_mask_count ( i ) =
(
)

implement image_mask_median ( i, u, v ) =
(
)

implement image_mask_random ( i, u, v ) =
(
)

implement image_write_to_file ( i, filename ) =
(
)

implement image_tga_save_file ( i, filename ) =
(
)

implement image_bmp_save_file ( i, filename ) =
(
)

implement image_read_from_file ( filename ) =
(
)

implement image_tga_load_file ( filename ) =
(
)

implement image_bmp_load_file ( filename ) =
(
)
