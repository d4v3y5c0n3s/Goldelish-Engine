(*
###  g_engine.sats  ###

This file has code for general things & math operations in the engine.
*)

(*  standard lib includes  *)
#include "share/HATS/atslib_staload_libats_libc.hats"

(*  SDL includes  *)
staload "./SDL2/SDL_local.sats"

#define RAND_MAX 32767

#ifndef MAX_PATH
#define MAX_PATH 512
#endif
#define ERROR_BUFFER_SIZE	2048 * 4
#define DEBUG_BUFFER_SIZE	2048 * 4
#define WARNING_BUFFER_SIZE	2048 * 4

(*  ###  file system path  ###  *)
absvtype fpath

fn P ( path: string ) : fpath = "sta#"

fn fpath_full (path_in: fpath) : fpath = "sta#fpath_full"
fn fpath_file (path: fpath) : fpath = "sta#fpath_file"
fn fpath_file_location (path: fpath) : fpath = "sta#fpath_file_location"
fn fpath_file_extension (path: fpath) : fpath = "sta#fpath_file_extension"

fn fpath_delete (path: fpath) : void
fn fpath_string (path: fpath) : string

(*  ###  timing  ###  *)
abst@ype timer

fn timer_start (id: int, tag: string) : timer = "sta#"
fn timer_split (t: timer, tag: string) : timer = "sta#timer_split"
fn timer_stop (t: timer, tag: string) : timer = "sta#timer_stop"

fn timestamp (out: string, ts_counter: int) : int = "sta#timestamp"

(*  ###  framerate  ###  *)
fn frame_begin () : ulint = "sta#frame_begin"
fn frame_end ( fstartt: ulint, fendt: ulint, ftimev: ulint, facct: ulint, fcntr: ulint, frv: ulint ) : (ulint, ulint, ulint, ulint, ulint, ulint) = "sta#frame_end"
fn frame_end_at_rate ( fps: double, fstartt: ulint, fendt: ulint, ftimev: ulint, facct: ulint, fcntr: ulint, frv: ulint ) : void = "sta#%"

(*  ###  floating point math  ###  *)

fn clamp ( x:float, bottom:float, top:float ): float = "sta#%"
fn saturate ( x:float ): float = "sta#%"
fn between ( x:float, bottom:float, top:float ): bool = "sta#%"
fn between_or ( x:float, bottom:float, top:float ): bool = "sta#%"

fn lerp ( p1: float, p2: float, amount: float ) : float = "sta#%"
fn smoothstep ( p1: float, p2: float, amount: float ) : float = "sta#%"
fn smootherstep ( p1: float, p2: float, amount: float ) : float = "sta#%"
fn cosine_interp ( p1: float, p2: float, amount: float ) : float = "sta#%"
fn cubic_interp ( p1: float, p2: float, p3: float, p4: float, amount: float ) : float = "sta#%"
fn nearest_interp ( p1: float, p2: float, amount: float ) : float = "sta#%"

fn binearest_interp ( tl: float, tr: float, bl: float, br: float, x_amount: float, y_amount: float ) : float = "sta#%"
fn bilinear_interp ( tl: float, tr: float, bl: float, br: float, x_amount: float, y_amount: float ) : float = "sta#%"
fn bicosine_interp ( tl: float, tr: float, bl: float, br: float, x_amount: float, y_amount: float ) : float = "sta#%"
fn bismoothstep_interp ( tl: float, tr: float, bl: float, br: float, x_amount: float, y_amount: float ) : float = "sta#%"
fn bismootherstep_interp ( tl: float, tr: float, bl: float, br: float, x_amount: float, y_amount: float ) : float = "sta#%"

(*  ###  vector math  ###  *)

//  vec2 type
typedef vec2 = @{ x=float, y=float }

fn vec2_new ( x: float, y: float ) : vec2 = "sta#%"
fn vec2_zero () : vec2 = "sta#%"
fn vec2_one () : vec2 = "sta#%"

fn vec2_add ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_sub ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_mul ( v: vec2, fac: float ) : vec2 = "sta#%"
fn vec2_mul_vec2 ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_div ( v: vec2, fac: float ) : vec2 = "sta#%"
fn vec2_div_vec2 ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_pow ( v: vec2, exp: float ) : vec2 = "sta#%"
fn vec2_neg ( v: vec2 ) : vec2 = "sta#%"
fn vec2_abs ( v: vec2 ) : vec2 = "sta#%"
fn vec2_floor ( v: vec2 ) : vec2 = "sta#%"
fn vec2_fmod ( v: vec2, vl: float ) : vec2 = "sta#%"

fn vec2_max ( v: vec2, x: float ) : vec2 = "sta#%"
fn vec2_min ( v: vec2, x: float ) : vec2 = "sta#%"
fn vec2_clamp ( v: vec2, b: float, t: float ) : vec2 = "sta#%"

fn vec2_equ ( v1: vec2, v2: vec2 ) : bool = "sta#%"

fn vec2_dot ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_length_sqrd ( v: vec2 ) : float = "sta#%"
fn vec2_length ( v: vec2 ) : float = "sta#%"
fn vec2_dist_sqrd ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_dist ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_dist_manhattan ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_normalize ( v: vec2 ) : vec2 = "sta#%"

fn vec2_reflect ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"

fn vec2_print ( v: vec2 ) : void = "sta#%"

fn vec2_to_array (v: vec2, out: &(@[float][2]) ) : void = "sta#%"

fn vec2_hash ( v: vec2 ) : int = "sta#%"
fn vec2_mix_hash ( v: vec2 ) : int = "sta#%"

fn vec2_saturate ( v: vec2 ) : vec2 = "sta#%"
fn vec2_lerp ( v1: vec2, v2: vec2, amount: float ) : vec2 = "sta#%"
fn vec2_smoothstep ( v1: vec2, v2: vec2, amount: float ) : vec2 = "sta#%"
fn vec2_smootherstep ( v1: vec2, v2: vec2, amount: float ) : vec2 = "sta#%"

//  vec3 type
typedef vec3 = @{ x=float, y=float, z=float }

fn vec3_new ( x: float, y: float, z: float ) : vec3 = "sta#%"
fn vec3_zero () : vec3 = "sta#%"
fn vec3_one () : vec3 = "sta#%"
fn vec3_up () : vec3 = "sta#%"

//  it seems that vec3 types are used for RGB colors as well as 3D coordinates
fn vec3_red () : vec3 = "sta#%"
fn vec3_green () : vec3 = "sta#%"
fn vec3_blue () : vec3 = "sta#%"
fn vec3_white () : vec3 = "sta#%"
fn vec3_black () : vec3 = "sta#%"
fn vec3_grey () : vec3 = "sta#%"
fn vec3_light_grey () : vec3 = "sta#%"
fn vec3_dark_grey () : vec3 = "sta#%"

fn vec3_add ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_sub ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_mul ( v: vec3, fac: float ) : vec3 = "sta#%"
fn vec3_mul_vec3 ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_div ( v: vec3, fac: float ) : vec3 = "sta#%"
fn vec3_div_vec3 ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_pow ( v: vec3, fac: float ) : vec3 = "sta#%"
fn vec3_neg ( v: vec3 ) : vec3 = "sta#%"
fn vec3_abs ( v: vec3 ) : vec3 = "sta#%"
fn vec3_floor ( v: vec3 ) : vec3 = "sta#%"
fn vec3_fmod ( v: vec3, vl: float ) : vec3 = "sta#%"

fn vec3_equ ( v1: vec3, v2: vec3 ) : bool = "sta#%"
fn vec3_neq ( v1: vec3, v2: vec3 ) : bool = "sta#%"

fn vec3_dot ( v1: vec3, v2: vec3 ) : float = "sta#%"
fn vec3_length_sqrd ( v: vec3 ) : float = "sta#%"
fn vec3_length ( v: vec3 ) : float = "sta#%"
fn vec3_dist_sqrd ( v1: vec3, v2: vec3 ) : float = "sta#%"
fn vec3_dist ( v1: vec3, v2: vec3 ) : float = "sta#%"
fn vec3_dist_manhattan ( v1: vec3, v2: vec3 ) : float = "sta#%"
fn vec3_cross ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_normalize ( v: vec3 ) : vec3 = "sta#%"

fn vec3_reflect ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fn vec3_project ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"

fn vec3_print ( v: vec3 ) : void = "sta#%"

fn vec3_to_array ( v: vec3, out: &(@[float][3]) ) : void = "sta#%"

fn vec3_hash ( v: vec3 ) : int = "sta#%"

fn vec3_saturate ( v: vec3 ) : vec3 = "sta#%"
fn vec3_lerp ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"
fn vec3_smoothstep ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"
fn vec3_smootherstep ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"

//  vec4 type
typedef vec4 = @{ x=float, y=float, z=float, w=float }

fn vec4_new ( x: float, y: float, z: float, w: float ) : vec4 = "sta#%"
fn vec4_zero () : vec4 = "sta#%"
fn vec4_one () : vec4 = "sta#%"

fn vec4_red () : vec4 = "sta#%"
fn vec4_green () : vec4 = "sta#%"
fn vec4_blue () : vec4 = "sta#%"
fn vec4_white () : vec4 = "sta#%"
fn vec4_black () : vec4 = "sta#%"
fn vec4_grey () : vec4 = "sta#%"
fn vec4_light_grey () : vec4 = "sta#%"
fn vec4_dark_grey () : vec4 = "sta#%"

fn vec4_add ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fn vec4_sub ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fn vec4_mul ( v: vec4, fac: float ) : vec4 = "sta#%"
fn vec4_mul_vec4 ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fn vec4_div ( v: vec4, fac: float ) : vec4 = "sta#%"
fn vec4_pow ( v: vec4, fac: float ) : vec4 = "sta#%"
fn vec4_neg ( v: vec4 ) : vec4 = "sta#%"
fn vec4_abs ( v: vec4 ) : vec4 = "sta#%"
fn vec4_floor ( v: vec4 ) : vec4 = "sta#%"
fn vec4_fmod ( v: vec4, vl: float ) : vec4 = "sta#%"
fn vec4_sqrt ( v: vec4 ) : vec4 = "sta#%"

fn vec4_max ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fn vec4_min ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fn vec4_equ ( v1: vec4, v2: vec4 ) : bool = "sta#%"

fn vec4_dot ( v1: vec4, v2: vec4 ) : float = "sta#%"
fn vec4_length_sqrd ( v: vec4 ) : float = "sta#%"
fn vec4_length ( v: vec4 ) : float = "sta#%"
fn vec4_dist_sqrd ( v1: vec4, v2: vec4 ) : float = "sta#%"
fn vec4_dist ( v1: vec4, v2: vec4 ) : float = "sta#%"
fn vec4_dist_manhattan ( v1: vec4, v2: vec4 ) : float = "sta#%"
fn vec4_normalize ( v: vec4 ) : vec4 = "sta#%"

fn vec4_reflect ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"

fn vec4_print ( v: vec4 ) : void = "sta#%"

fn vec4_to_array ( v: vec4, out: &(@[float][4]) ) : void = "sta#%"

fn vec3_to_homogeneous ( v: vec3 ) : vec4 = "sta#%"
fn vec4_from_homogeneous ( v: vec4 ) : vec3 = "sta#%"

fn vec4_hash ( v: vec4 ) : int = "sta#%"

fn vec4_saturate ( v: vec4 ) : vec4 = "sta#%"
fn vec4_lerp ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fn vec4_smoothstep ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fn vec4_smootherstep ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fn vec4_nearest_interp ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"

fn vec4_binearest_interp ( top_left: vec4, top_right: vec4, bottom_left: vec4, bottom_right: vec4, x_amount: float, y_amount: float ) : vec4 = "sta#%"
fn vec4_bilinear_interp ( top_left: vec4, top_right: vec4, bottom_left: vec4, bottom_right: vec4, x_amount: float, y_amount: float ) : vec4 = "sta#%"

//  quaterion type
typedef quat = vec4

fn quat_id () : quat = "sta#%"
fn quat_new ( x: float, y: float, z: float, w: float ) : quat = "sta#%"
fn quat_from_euler ( r: vec3 ) : quat = "sta#%"
fn quat_angle_axis ( angle: float, axis: vec3 ) : quat = "sta#%"
fn quat_rotation_x ( angle: float ) : quat = "sta#%"
fn quat_rotation_y ( angle: float ) : quat = "sta#%"
fn quat_rotation_z ( angle: float ) : quat = "sta#%"

fn quat_at {i:nat | i < 4} ( q: quat, i: int i ) : float = "sta#%"
fn quat_real ( q: quat ) : float = "sta#%"
fn quat_imaginaries ( q: quat ) : vec3 = "sta#%"

fn quat_to_angle_axis {l1,l2:addr} ( pf_ax: !vec3 @ l1, pf_an: !float @ l2 | q: quat, axis: ptr l1, angle: ptr l2 ) : void = "sta#%"
fn quat_to_euler ( q: quat ) : vec3 = "sta#%"

fn quat_neg ( q: quat ) : quat = "sta#%"
fn quat_dot ( q1: quat, q2: quat ) : float = "sta#%"
fn quat_scale ( q: quat, f: float ) : quat = "sta#%"
fn quat_mul_quat ( q1: quat, q2: quat ) : quat = "sta#%"
fn quat_mul_vec3 ( q: quat, v: vec3 ) : vec3 = "sta#%"

fn quat_inverse ( q: quat ) : quat = "sta#%"
fn quat_unit_inverse ( q: quat ) : quat = "sta#%"
fn quat_length ( q: quat ) : float = "sta#%"
fn quat_normalize ( q: quat ) : quat = "sta#%"

fn quat_exp ( w: vec3 ) : quat = "sta#%"
fn quat_log ( q: quat ) : vec3 = "sta#%"

fn quat_slerp ( q1: quat, q2: quat, amount: float ) : quat = "sta#%"

fn quat_constrain ( q: quat, axis: vec3 ) : quat = "sta#%"
fn quat_constrain_y ( q: quat ) : quat = "sta#%"

fn quat_distance ( q0: quat, q1: quat ) : float = "sta#%"
fn quat_interpolate {n,m:nat | m == n - 1} ( qs: &(@[quat][n]), ws: &(@[float][n]), count: int m ) : quat = "sta#%"

typedef quat_dual = @{ real=quat, dual=quat }

fn quat_dual_id () : quat_dual = "sta#%"
fn quat_dual_new ( real: quat, dual: quat ) : quat_dual = "sta#%"
fn quat_dual_transform ( q: quat, t: vec3 ) : quat_dual = "sta#%"
fn quat_dual_mul ( q0: quat_dual, q1: quat_dual ) : quat_dual = "sta#%"
fn quat_dual_normalize ( q: quat_dual ) : quat_dual = "sta#%"
fn quat_dual_mul_vec3 ( q: quat_dual, v: vec3 ) : vec3 = "sta#%"
fn quat_dual_mul_vec3_rot ( q: quat_dual, v: vec3 ) : vec3 = "sta#%"

(*  ###  matrix math  ###  *)
//  mat2 type
typedef mat2 = @{ xx=float, xy=float, yx=float, yy=float }

fn mat2_id () : mat2 = "sta#%"
fn mat2_zero () : mat2 = "sta#%"
fn mat2_new ( xx: float, xy: float, yx: float, yy: float ) : mat2 = "sta#%"
fn mat2_mul_mat2 ( m1: mat2, m2: mat2 ) : mat2 = "sta#%"
fn mat2_mul_vec2 ( m: mat2, v: vec2 ) : vec2 = "sta#%"

fn mat2_transpose ( m: mat2 ) : mat2 = "sta#%"
fn mat2_det ( m: mat2 ) : float = "sta#%"
fn mat2_inverse ( m: mat2 ) : mat2 = "sta#%"

fn mat2_to_array ( m: mat2, out: &(@[float][4]) ) : void = "sta#%"
fn mat2_print ( m: mat2 ) : void = "sta#%"
fn mat2_rotation ( a: float ) : mat2 = "sta#%"

//  mat3 type
typedef mat3 = @{ xx=float, xy=float, xz=float, yx=float, yy=float, yz=float, zx=float, zy=float, zz=float }

fn mat3_id () : mat3 = "sta#%"
fn mat3_zero () : mat3 = "sta#%"
fn mat3_new ( xx: float, xy: float, xz: float, yx: float, yy: float, yz: float, zx: float, zy: float, zz: float ) : mat3 = "sta#%"
fn mat3_mul_mat3 ( m1: mat3, m2: mat3 ) : mat3 = "sta#%"
fn mat3_mul_vec3 ( m: mat3, v: vec3 ) : vec3 = "sta#%"

fn mat3_transpose ( m: mat3 ) : mat3 = "sta#%"
fn mat3_det ( m: mat3 ) : float = "sta#%"
fn mat3_inverse ( m: mat3 ) : mat3 = "sta#%"

fn mat3_to_array ( m: mat3, out: &(@[float][9]) ) : void = "sta#%"
fn mat3_print ( m: mat3 ) : void = "sta#%"

fn mat3_scale ( s: vec3 ) : mat3 = "sta#%"
fn mat3_rotation_x ( a: float ) : mat3 = "sta#%"
fn mat3_rotation_y ( a: float ) : mat3 = "sta#%"
fn mat3_rotation_z ( a: float ) : mat3 = "sta#%"
fn mat3_rotation_angle_axis ( angle: float, axis: vec3 ) : mat3 = "sta#%"

//  mat4 type
typedef mat4 = @{ xx=float, xy=float, xz=float, xw=float, yx=float, yy=float, yz=float, yw=float, zx=float, zy=float, zz=float, zw=float, wx=float, wy=float, wz=float, ww=float }

fn mat4_id () : mat4 = "sta#%"
fn mat4_zero () : mat4 = "sta#%"
fn mat4_new ( xx: float, xy: float, xz: float, xw: float, yx: float, yy: float, yz: float, yw: float, zx: float, zy: float, zz: float, zw: float, wx: float, wy: float, wz: float, ww: float ) : mat4 = "str#%"
fn mat4_at {x:nat | x < 4}{y:nat | y < 4} ( m: mat4, x: int x, y: int y ) : float = "sta#%"
fn mat4_set {x:nat | x < 4}{y:nat | y < 4} ( m: mat4, x: int x, y: int y, v: float ) : mat4 = "sta#%"
fn mat4_transpose ( m: mat4 ) : mat4 = "sta#%"

fn mat4_mul_mat4 ( m1: mat4, m2: mat4 ) : mat4 = "sta#%"

fn mat4_mul_vec4 ( m: mat4, v: vec4 ) : vec4 = "sta#%"
fn mat4_mul_vec3 ( m: mat4, v: vec3 ) : vec3 = "sta#%"

fn mat4_det ( m: mat4 ) : float = "sta#%"
fn mat4_inverse ( m: mat4 ) : mat4 = "sta#%"

fn mat3_to_mat4 ( m: mat3 ) : mat4 = "sta#%"
fn mat4_to_mat3 ( m: mat4 ) : mat3 = "sta#%"
fn mat4_to_quat ( m: mat4 ) : quat = "sta#%"
fn mat4_to_quat_dual ( m: mat4 ) : quat_dual = "sta#%"

fn mat4_to_array ( m: mat4, out: &(@[float][16]) ) : void = "sta#%"
fn mat4_to_array_trans ( m: mat4, out: &(@[float][16]) ) : void = "sta#%"

fn mat4_print ( m: mat4 ) : void = "sta#%"

fn mat4_translation ( v: vec3 ) : mat4 = "sta#%"
fn mat4_scale ( v: vec3 ) : mat4 = "sta#%"

fn mat4_rotation_x ( a: float ) : mat4 = "sta#%"
fn mat4_rotation_y ( a: float ) : mat4 = "sta#%"
fn mat4_rotation_z ( a: float ) : mat4 = "sta#%"
fn mat4_rotation_axis_angle ( axis: vec3, angle: float ) : mat4 = "sta#%"

fn mat4_rotation_euler (  x: float, y: float, z: float ) : mat4 = "sta#%"
fn mat4_rotation_quat ( q: quat ) : mat4 = "sta#%"
fn mat4_rotation_quat_dual ( q: quat_dual ) : mat4 = "sta#%"

fn mat4_view_look_at ( position: vec3, target: vec3, up: vec3 ) : mat4 = "sta#%"
fn mat4_perspective ( fov: float, near_clip: float, far_clip: float, ratio: float ) : mat4 = "sta#%"
fn mat4_orthographic ( left: float, right: float, bottom: float, top: float, near: float, far: float ) : mat4 = "sta#%"

fn mat4_world ( position: vec3, scale: vec3, rotation: quat ) : mat4 = "sta#%"

fn mat4_lerp ( m1: mat4, m2: mat4, amount: float ) : mat4 = "sta#%"
fn mat4_smoothstep ( m1: mat4, m2: mat4, amount: float ) : mat4 = "sta#%"

(*  ###  geometry  ###  *)

//  plane shape type
typedef plane = @{ direction=vec3, position=vec3 }

fn plane_new ( position: vec3, direction: vec3 ) : plane = "sta#%"
fn plane_transform ( p: &plane, world: mat4, world_normal: mat3 ) : plane = "sta#%"
fn plane_transform_space ( p: &plane, space: mat3, space_normal: mat3 ) : plane = "sta#%"
fn plane_distance ( p: plane, point: vec3 ) : float = "sta#%"

fn point_inside_plane ( point: vec3, p: plane ) : bool = "sta#%"
fn point_outside_plane ( point: vec3, p: plane ) : bool = "sta#%"
fn point_intersects_plane ( point: vec3, p: plane ) : bool = "sta#%"

fn point_swept_inside_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"
fn point_swept_outside_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"
fn point_swept_intersects_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"

fn plane_closest ( p: plane, v: vec3 ) : vec3 = "sta#%"
fn plane_project ( p: plane, v: vec3 ) : vec3 = "sta#%"

//  box shape type
typedef box = @{ top=plane, bottom=plane, left=plane, right=plane, front=plane, back=plane }

fn box_new ( x_min: float, x_max: float, y_min: float, y_max: float, z_min: float, z_max: float ) : box = "sta#%"
fn box_sphere ( center: vec3, radius: float ) : box = "sta#%"
fn box_merge ( b1: box, b2: box ) : box = "sta#%"
fn box_transform ( b1: &box, world: mat4, world_normal: mat3 ) : box = "sta#%"
fn box_invert ( b: &box ) : box = "sta#%"
fn box_invert_depth ( b: &box ) : box = "sta#%"
fn box_invert_width ( b: &box ) : box = "sta#%"
fn box_invert_height ( b: &box ) : box = "sta#%"

fn point_inside_box ( point: vec3, b: box ) : bool = "sta#%"
fn point_outside_box ( point: vec3, b: box ) : bool = "sta#%"
fn point_intersects_box ( point: vec3, b: box ) : bool = "sta#%"

//  frustum type
typedef frustum = @{ ntr=vec3, ntl=vec3, nbr=vec3, nbl=vec3, ftr=vec3, ftl=vec3, fbr=vec3, fbl=vec3 }

fn frustum_new ( ntr: vec3, ntl: vec3, nbr: vec3, nbl: vec3, ftr: vec3, ftl: vec3, fbr: vec3, fbl: vec3 ) : frustum = "sta#%"
fn frustum_new_clipbox () : frustum = "sta#%"
fn frustum_new_camera ( view: mat4, proj: mat4 ) : frustum = "sta#%"
fn frustum_slice ( f: frustum, f_start: float, f_end: float ) : frustum = "sta#%"
fn frustum_transform ( f: frustum, m: mat4 ) : frustum = "sta#%"
fn frustum_translate ( f: frustum, v: vec3 ) : frustum = "sta#%"

fn frustum_center ( f: frustum ) : vec3 = "sta#%"
fn frustum_maximums ( f: frustum ) : vec3 = "sta#%"
fn frustum_minimums ( f: frustum ) : vec3 = "sta#%"

fn frustum_box ( f: &frustum ) : box = "sta#%"

fn frustum_outside_box ( f: frustum, b: box ) : bool = "sta#%"

//  sphere shape type
typedef sphere = @{ center=vec3, radius=float }

fn sphere_unit () : sphere = "sta#%"
fn sphere_point () : sphere = "sta#%"
fn sphere_new ( center: vec3, radius: float ) : sphere = "sta#%"
fn sphere_merge ( s1: sphere, s2: sphere ) : sphere = "sta#%"
fn sphere_merge_many {n,m:nat | m == n - 1} ( s: &(@[sphere][n]), count: int m ) : sphere = "sta#%"
fn sphere_transform ( s: sphere, world: mat4 ) : sphere = "sta#%"
fn sphere_translate ( s: sphere, x: vec3 ) : sphere = "sta#%"
fn sphere_scale ( s: sphere, x: float ) : sphere = "sta#%"
fn sphere_transform_space ( s: sphere, space: mat3 ) : sphere = "sta#%"

fn sphere_of_box ( bb: box ) : sphere = "sta#%"
fn sphere_of_frustum ( f: frustum ) : sphere = "sta#%"

fn sphere_inside_box ( s: sphere, b: box ) : bool = "sta#%"
fn sphere_outside_box ( s: sphere, b: box ) : bool = "sta#%"
fn sphere_intersects_box ( s: sphere, b: box ) : bool = "sta#%"

fn sphere_inside_frustum ( s: sphere, f: &frustum ) : bool = "sta#%"
fn sphere_outside_frustum ( s: sphere, f: &frustum ) : bool = "sta#%"
fn sphere_intersects_frustum ( s: sphere, f: &frustum ) : bool = "sta#%"

fn sphere_outside_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"
fn sphere_inside_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"
fn sphere_intersects_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"

fn point_inside_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"
fn point_outside_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"
fn point_intersects_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"

fn line_inside_sphere ( s: sphere, l_start: vec3, l_end: vec3 ) : bool = "sta#%"
fn line_outside_sphere ( s: sphere, l_start: vec3, l_end: vec3 ) : bool = "sta#%"
fn line_intersects_sphere ( s: sphere, l_start: vec3, l_end: vec3 ) : bool = "sta#%"

fn sphere_inside_plane ( s: sphere, p: plane ) : bool = "sta#%"
fn sphere_outside_plane ( s: sphere, p: plane ) : bool = "sta#%"
fn sphere_intersects_plane ( s: sphere, p: plane ) : bool = "sta#%"
fn sphere_intersects_plane_point {l1,l2:addr} ( pfpnt: !vec3 @ l1, pfrds: !float @ l2 | s: sphere, p: plane, point: ptr l1, radius: ptr l2 ) : bool = "sta#%"

fn point_swept_inside_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"
fn point_swept_outside_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"
fn point_swept_intersects_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"

fn sphere_swept_inside_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"
fn sphere_swept_outside_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"
fn sphere_swept_intersects_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"

fn sphere_swept_outside_sphere ( s1: sphere, v: vec3, s2: sphere ) : bool = "sta#%"
fn sphere_swept_inside_sphere ( s1: sphere, v: vec3, s2: sphere ) : bool = "sta#%"
fn sphere_swept_intersects_sphere ( s1: sphere, v: vec3, s2: sphere ) : bool = "sta#%"

fn point_inside_triangle ( p: vec3, v0: vec3, v1: vec3, v2: vec3 ) : bool = "sta#%"
fn sphere_intersects_face ( s: sphere, v0: vec3, v1: vec3, v2: vec3, norm: vec3 ) : bool = "sta#%"

//  ellipsoid shape type
abst@ype ellipsoid

fn ellipsoid_new ( center: vec3, radiuses: vec3 ) : ellipsoid = "sta#%"
fn ellipsoid_transform ( e: ellipsoid, m: mat4 ) : ellipsoid = "sta#%"
fn ellipsoid_of_sphere ( s: sphere ) : ellipsoid = "sta#%"

fn ellipsoid_space ( e: ellipsoid ) : mat3 = "sta#%"
fn ellipsoid_inv_space ( e: ellipsoid ) : mat3 = "sta#%"

//  capsule shape type
abst@ype capsule

fn capsule_new ( c_start: vec3, c_end: vec3, radius: float ) : capsule = "sta#%"
fn capsule_transform ( c: capsule, m: mat4 ) : capsule = "sta#%"

fn capsule_inside_plane ( c: capsule, p: plane ) : bool = "sta#%"
fn capsule_outside_plane ( c: capsule, p: plane ) : bool = "sta#%"
fn capsule_intersects_plane ( c: capsule, p: plane ) : bool = "sta#%"

//  vertex type
//abst@ype vertex
typedef vertex = @{ position=vec3, normal=vec3, tangent=vec3, binormal=vec3, color=vec4, uvs=vec2 }

fn vertex_new () : vertex = "sta#%"
fn vertex_equal ( v1: vertex, v2: vertex ) : bool = "sta#%"
fn vertex_print ( v: vertex ) : void = "sta#%"

//  mesh type
absvt@ype mesh

fn mesh_new () : mesh = "str#%"
fn mesh_delete ( m: mesh ) : void = "sta#%"

fn mesh_generate_normals ( m: &mesh ) : void = "sta#%"
fn mesh_generate_tangents ( m: &mesh ) : void = "sta#%"
fn mesh_generate_orthagonal_tangents ( m: &mesh ) : void = "sta#%"
fn mesh_generate_texcoords_cylinder ( m: &mesh ) : void = "sta#%"

fn mesh_print ( m: &mesh ) : void = "sta#%"
fn mesh_surface_area ( m: &mesh ) : float = "sta#%"

fn mesh_transform ( m: &mesh, transform: mat4 ) : void = "sta#%"
fn mesh_translate ( m: &mesh, translation: vec3 ) : void = "sta#%"
fn mesh_scale ( m: &mesh, scale: float ) : void = "sta#%"

fn mesh_bounding_sphere ( m: &mesh ) : sphere = "sta#%"

//  model type
absvt@ype model

fn model_new () : model = "sta#%"
fn model_delete ( m: model ) : void = "sta#%"

fn model_generate_normals ( m: &model ) : void = "sta#%"
fn model_generate_tangents ( m: &model ) : void = "sta#%"
fn model_generate_orthagonal_tangents ( m: &model ) : void = "sta#%"
fn model_generate_texcoords_cylinder ( m: &model ) : void = "sta#%"

fn model_print ( m: &model ) : void = "sta#%"
fn model_surface_area ( m: &model ) : float = "sta#%"

fn model_transform ( m: &model, transform: mat4 ) : void = "sta#%"
fn model_translate ( m: &model, translation: vec3 ) : void = "sta#%"
fn model_scale ( m: &model, scale: float ) : void = "sta#%"

//  triangle
fn triangle_tangent ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fn triangle_binormal ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fn triangle_normal ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fn triangle_random_position (  v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fn triangle_area ( v1: vertex, v2: vertex, v3: vertex ) : float = "sta#%"

fn triangle_difference_u ( v1: vertex, v2: vertex, v3: vertex ) : float = "sta#%"
fn triangle_difference_v ( v1: vertex, v2: vertex, v3: vertex ) : float = "sta#%"

fn triangle_random_position_interpolation ( v1: vertex, v2: vertex, v3: vertex ) : vertex = "sta#%"

//  tweening
fn tween_approach ( curr: float, target: float, timestep: float, steepness: float ) : float = "sta#%"
fn tween_linear ( curr: float, target: float, timestep: float, max: float ) : float = "sta#%"

fn vec3_tween_approach ( curr: vec3, target: vec3, timestep: float, steepness: float ) : vec3 = "sta#%"
fn vec3_tween_linear ( curr: vec3, target: vec3, timestep: float, max: float ) : vec3 = "sta#%"