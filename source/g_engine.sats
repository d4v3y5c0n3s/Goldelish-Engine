(*
###  g_engine.sats  ###

This file has code for general things & math operations in the engine.
*)

(*  standard lib includes  *)
//  ATS includes the C standard libraries ready-to-use
#include "share/HATS/atslib_staload_libats_libc.hats"

(*  SDL includes  *)
%{
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>
#include <SDL2/SDL_rwops.h>
#include <SDL2/SDL_mixer.h>
#include <SDL2/SDL_net.h>
%}
staload SDL2_LOCAL = "SDL2/SDL_local.sats"

#ifndef MAX_PATH
#define MAX_PATH 512
#endif
#define ERROR_BUFFER_SIZE	2048 * 4
#define DEBUG_BUFFER_SIZE	2048 * 4
#define WARNING_BUFFER_SIZE	2048 * 4

(*  ###  file system path  ###  *)
typedef fpath = @{ path=string }

fun P {s:int | s >= 0} ( path: string s ) : Option(fpath) = "sta#"

fun fpath_full (path: fpath) : fpath = "sta#fpath_full"
fun fpath_file (path: fpath) : fpath = "sta#fpath_file"
fun fpath_file_location (path: fpath) : fpath = "sta#fpath_file_location"
fun fpath_file_extension (path: fpath) : fpath = "sta#fpath_file_extension"

(*  --  NOTICE: This may need to be rethought for ATS  --
(*  ###  errors & debugging  ###  *)
fun at_error(f: void -> void, c: string): void = "sta#at_error"
fun at_warning(f: void -> void, c: string): void = "sta#at_warning"
fun at_debug(f: void -> void, c: string): void = "sta#at_debug"

fun error_(c: string): void = "sta#error_"
fun warning_(c: string): void = "sta#warning_"
fun debug_(c: string): void = "sta#debug_"

fun error_buf(size: int): char = "sta#error_buf"//ERROR_BUFFER_SIZE
fun error_str(): char = "sta#error_str"//ERROR_BUFFER_SIZE

fun warning_buf(): char = "sta#warning_buf"//WARNING_BUFFER_SIZE
fun warning_str(): char = "sta#warning_str"//WARNING_BUFFER_SIZE

fun debug_buf(): char = "sta#debug_buf"//DEBUG_BUFFER_SIZE
fun debug)str(): char = "sta#debug_str"//DEBUG_BUFFER_SIZE

#define error()

#define warning()

#define debug()

#define alloc_check()

(*  #  OpenGL error checking  #  *)
#ifdef RELEASE
#define SDL_GL_CheckError()
#else
#define SDL_GL_CheckError() { GLenum __glerror = glGetError(); if (__glerror) { error("OpenGL Error: %s", SDL_GL_ErrorString(__glerror)); } }
#endif

(*  #  conditional hinting  #  *)
#define likely(x)  __builtin_expect((x),1)
#define unlikely(x)	__builtin_expect((x),0)
*)

(*  ###  timing  ###  *)
typedef
timer = @{ id=int,
      start_time=ulint,
      end_time=ulint,
      split=ulint }

fun timer_start {i:int | i > 0}{s:int | s > 0} (id: int i, tag: string s) : timer = "sta#"
fun timer_split {s:int | s > 0} (t: timer, tag: string s) : timer = "sta#timer_split"
fun timer_stop {s:int | s > 0} (t: timer, tag: string s) : timer = "sta#timer_stop"

fun timestamp {s:int | s > 0} (out: string s) : void = "sta#timestamp"

(*  ###  framerate  ###  *)
fun frame_begin () : void = "sta#frame_begin"
fun frame_end () : void = "sta#frame_end"
fun frame_end_at_rate ( fps: double ) : void = "sta#%"

fun frame_rate () : double = "sta#%"
fun frame_time () : double = "sta#%"
fun frame_rate_string () : string = "sta#"

(*  ###  types  ###  *)
typedef type_id = int

//  WILL NEED REVISION
//#define typeid(TYPE) type_find(#TYPE, sizeof(TYPE))
fun type_find( type: string, size: size_t ) : type_id = "sta#%"
fun type_id_name ( id: int ) : string = "sta#%"

(*  ###  floating point math  ###  *)

//  min(x, y) & max(x, y) are already implemented in the ATS prelude

fn clamp {v,b,t:int | t > b} ( x:float v, bottom:float b, top:float t ): float = "sta#%"
fn saturate {i: int} ( x:float i ): float = "sta#%"
fn between {i,j,k:int | j != k} ( x:float i, bottom:float j, top:float k ): bool = "sta#%"
fn between_or {i,j,k:int} ( x:float i, bottom:float j, top:float k ): bool = "sta#%"

fn lerp {i,j,k:int} ( p1: float i, p2: float j, amount: float k ) : float = "sta#%"
fn smoothstep {i,j,k:int} ( p1: float i, p2: float j, amount: float k ) : float = "sta#%"
fn smootherstep {i,j,k:int} ( p1: float i, p2: float j, amount: float k ) : float = "sta#%"
fn cosine_interp {i,j,k:int} ( p1: float i, p2: float j, amount: float k ) : float = "sta#%"
fn cubic_interp {i,j,k,l,m:int} ( p1: float i, p2: float j, p3: float k, p4: float l, amount: float m ) : float = "sta#%"
fn nearest_interp {i,j,k:int} ( p1: float i, p2: float j, amount: float k ) : float = "sta#%"

fn binearest_interp {i,j,k,l,m,n:int} ( tl: float i, tr: float j, bl: float k, br: float l, x_amount: float m, y_amount: float n ) : float = "sta#%"
fn bilinear_interp {i,j,k,l,m,n:int} ( tl: float i, tr: float j, bl: float k, br: float l, x_amount: float m, y_amount: float n ) : float = "sta#%"
fn bicosine_interp {i,j,k,l,m,n:int} ( tl: float i, tr: float j, bl: float k, br: float l, x_amount: float m, y_amount: float n ) : float = "sta#%"
fn bismoothstep_interp {i,j,k,l,m,n:int} ( tl: float i, tr: float j, bl: float k, br: float l, x_amount: float m, y_amount: float n ) : float = "sta#%"
fn bismootherstep_interp {i,j,k,l,m,n:int} ( tl: float i, tr: float j, bl: float k, br: float l, x_amount: float m, y_amount: float n ) : float = "sta#%"

(*  ###  vector math  ###  *)

//  vec2 type
typedef vec2 = @{ x=float, y=float }

fn vec2_new {i,j:int} ( x: float i, y: float j ) : vec2 = "sta#%"
fn vec2_zero () : vec2 = "sta#%"
fn vec2_one () : vec2 = "sta#%"

fn vec2_add {} ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_sub {} ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_mul {} ( v: vec2, fac: float ) : vec2 = "sta#%"
fn vec2_mul_vec2 {} ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_div {} ( v: vec2, fac: float ) : vec2 = "sta#%"
fn vec2_div_vec2 {} ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"
fn vec2_pow {} ( v: vec2, exp: float ) : vec2 = "sta#%"
fn vec2_neg {} ( v: vec2 ) : vec2 = "sta#%"
fn vec2_abs {} ( v: vec2 ) : vec2 = "sta#%"
fn vec2_floor {} ( v: vec2 ) : vec2 = "sta#%"
fn vec2_fmod {} ( v: vec2, vl: float ) : vec2 = "sta#%"

fn vec2_max {} ( v: vec2, x: float ) : vec2 = "sta#%"
fn vec2_min {} ( v: vec2, x: float ) : vec2 = "sta#%"
fn vec2_clamp {} ( v: vec2, b: float, t: float ) : vec2 = "sta#%"

fn vec2_equ {} ( v1: vec2, v2: vec2 ) : bool = "sta#%"

fn vec2_dot {} ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_length_sqrd {} ( v: vec2 ) : float = "sta#%"
fn vec2_length {} ( v: vec2 ) : float = "sta#%"
fn vec2_dist_sqrd {} ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_dist {} ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_dist_manhattan {} ( v1: vec2, v2: vec2 ) : float = "sta#%"
fn vec2_normalize {} ( v: vec2 ) : vec2 = "sta#%"

fn vec2_reflect {} ( v1: vec2, v2: vec2 ) : vec2 = "sta#%"

fn vec2_from_string {} ( s: string ) : vec2 = "sta#%"
fn vec2_print {} ( v: vec2 ) : void = "sta#%"

fn vec2_to_array {} ( v: vec2, out: ptr ) : void = "sta#%

fn vec2_hash {} ( v: vec2 ) : int = "sta#%"
fn vec2_mix_hash {} ( v: vec2 ) : int = "sta#%"

fn vec2_saturate {} ( v: vec2 ) : vec2 = "sta#%"
fn vec2_lerp {} ( v1: vec2, v2: vec2, amount: float ) : vec2 = "sta#%"
fn vec2_smoothstep {} ( v1: vec2, v2: vec2, amount: float ) : vec2 = "sta#%"
fn vec2_smootherstep {} ( v1: vec2, v2: vec2, amount: vec2 ) : vec2 "sta#%"

//  vec3 type
typedef vec3 = @{ x=float, y=float, z=float }

fun vec3_new ( x: float, y: float, z: float ) : vec3 = "sta#%"
fun vec3_zero () : vec3 = "sta#%"
fun vec3_one () : vec3 = "sta#%"
fun vec3_up () : vec3 = "sta#%"

//  it seems that vec3 types are used for RGB colors as well as 3D coordinates
fun vec3_red () : vec3 = "sta#%"
fun vec3_greeen () : vec3 = "sta#%"
fun vec3_blue () : vec3 = "sta#%"
fun vec3_white () : vec3 = "sta#%"
fun vec3_black () : vec3 = "sta#%"
fun vec3_grey () : vec3 = "sta#%"
fun vec3_light_grey () : vec3 = "sta#%"
fun vec3_dark_grey () : vec3 = "sta#%"

fun vec3_add ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_sub ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_mul ( v: vec3, fac: float ) : vec3 = "sta#%"
fun vec3_mul_vec3 ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_div ( v: vec3, fac: float ) : vec3 = "sta#%"
fun vec3_div_vec3 ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_pow ( v: vec3, fac: float ) : vec3 = "sta#%"
fun vec3_neg ( v: vec3 ) : vec3 = "sta#%"
fun vec3_abs ( v: vec3 ) : vec3 = "sta#%"
fun vec3_floor ( v: vec3 ) : vec3 = "sta#%"
fun vec3_fmod ( v: vec3, vl: float ) : vec3 = "sta#%"

fun vec3_equ ( v1: vec3, v2: vec3 ) : bool = "sta#%"
fun vec3_neg ( v1: vec3, v2: vec3 ) : bool = "sta#%"

fun vec3_dot ( v1: vec3, v2: vec3 ) : float = "sta#%"
fun vec3_length_sqrd ( v: vec3 ) : float = "sta#%"
fun vec3_length ( v: vec3 ) : float = "sta#%"
fun vec3_dist_sqrd ( v1: vec3, v2: vec3 ) : float = "sta#%"
fun vec3_dist ( v1: vec3, v2: vec3 ) : float = "sta#%"
fun vec3_dist_manhattan ( v1: vec3, v2: vec3 ) : float = "sta#%"
fun vec3_cross ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_normalize ( v: vec3 ) : vec3 = "sta#%"

fun vec3_reflect ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"
fun vec3_project ( v1: vec3, v2: vec3 ) : vec3 = "sta#%"

fun vec3_from_string ( s: string ) : vec3 = "sta#%"
fun vec3_print ( v: vec3 ) : void = "sta#%"

fun vec3_to_array ( v: vec3, out: float ptr ) : void = "sta#%"

fun vec3_hash ( v: vec3 ) : int = "sta#%"

fun vec3_saturate ( v: vec3 ) : vec3 = "sta#%"
fun vec3_lerp ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"
fun vec3_smoothstep ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"
fun vec3_smootherstep ( v1: vec3, v2: vec3, amount: float ) : vec3 = "sta#%"

//  vec4 type
typedef vec4 = @{ x=float, y=float, z=float, w=float }

fun vec4_new ( x: float, y: float, z: float ) : vec4 = "sta#%"
fun vec4_zero () : vec4 = "sta#%"
fun vec4_one () : vec4 = "sta#%"

fun vec4_red () : vec4 = "sta#%"
fun vec4_green () : vec4 = "sta#%"
fun vec4_blue () : vec4 = "sta#%"
fun vec4_white () : vec4 = "sta#%"
fun vec4_black () : vec4 = "sta#%"
fun vec4_grey () : vec4 = "sta#%"
fun vec4_light_grey () : vec4 = "sta#%"
fun vec4_dark_grey () : vec4 = "sta#%"

fun vec4_add ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fun vec4_sub ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fun vec4_mul ( v: vec4, fac: float ) : vec4 = "sta#%"
fun vec4_mul_vec4 ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fun vec4_div ( v: vec4, fac: float ) : vec4 = "sta#%"
fun vec4_pow ( v: vec4, fac: float ) : vec4 = "sta#%"
fun vec4_neg ( v: vec4 ) : vec4 = "sta#%"
fun vec4_abs ( v: vec4 ) : vec4 = "sta#%"
fun vec4_floor ( v: vec4 ) : vec4 = "sta#%"
fun vec4_fmod ( v: vec4, vl: float ) : vec4 = "sta#%"
fun vec4_sqrt ( v: vec4 ) : vec4 = "sta#%"

fun vec4_max ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fun vec4_min ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"
fun vec4_equ ( v1: vec4, v2: vec4 ) : bool = "sta#%"

fun vec4_dot ( v1: vec4, v2: vec4 ) : float = "sta#%"
fun vec4_length_sqrd ( v: vec4 ) : float = "sta#%"
fun vec4_length ( v: vec4 ) : float = "sta#%"
fun vec4_dist_sqrd ( v1: vec4, v2: vec4 ) : float = "sta#%"
fun vec4_dist ( v1: vec4, v2: vec4 ) : float = "sta#%"
fun vec4_dist_manhattan ( v1: vec4, v2: vec4 ) : float = "sta#%"
fun vec4_normalize ( v: vec4 ) : vec4 = "sta#%"

fun vec4_reflect ( v1: vec4, v2: vec4 ) : vec4 = "sta#%"

fun vec4_from_string ( s: string ) : vec4 = "sta#%"
fun vec4_print ( v: vec4 ) : void = "sta#%"

fun vec4_to_array ( v: vec4, out: float ptr ) : void = "sta#%"

fun vec3_to_homogeneous ( v: vec3 ) : vec4 = "sta#%"
fun vec4_from_homogeneous ( v: vec4 ) : vec3 = "sta#%"

fun vec4_hash ( v: vec4 ) : int = "sta#%"

fun vec4_saturate ( v: vec4 ) : vec4 = "sta#%"
fun vec4_lerp ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fun vec4_smoothstep ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fun vec4_smootherstep ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"
fun vec4_nearest_interp ( v1: vec4, v2: vec4, amount: float ) : vec4 = "sta#%"

fun vec4_binearest_interp ( top_left: vec4, top_right: vec4, bottom_left: vec4, bottom_right: vec4, x_amount: float, y_amount: float ) : vec4 = "sta#%"
fun vec4_bilinear_interp ( top_left: vec4, top_right: vec4, bottom_left: vec4, bottom_right: vec4, x_amount: float, y_amount: float ) : vec4 = "sta#%"

//  quaterion type
typedef quat = vec4

fun quat_id () : quat = "sta#%"
fun quat_new ( x: float, y: float, z: float, w: float ) : quat = "sta#%"
fun quat_from_euler ( r: vec3 ) : quat = "sta#%"
fun quat_angle_axis ( angle: float, axis: vec3 ) : quat = "sta#%"
fun quat_rotation_x ( angle: float ) : quat = "sta#%"
fun quat_rotation_y ( angle: float ) : quat = "sta#%"
fun quat_rotation_z ( angle: float ) : quat = "sta#%"

fun quat_at {q:int}{i:int | i >= 0 && i <= 3} ( q: quat q, i: int i ) : float = "sta#%"
fun quat_real ( q: quat ) : float = "sta#%"
fun quat_imaginaries ( q: quat ) : vec3 = "sta#%"

fun quat_to_angle_axis ( q: quat, axis: vec3 ptr, angle: float ptr ) : void = "sta#%"
fun quat_to_euler ( q: quat ) : vec3 = "sta#%"

fun quat_neg ( q: quat ) : quat = "sta#%"
fun quat_dot ( q1: quat, q2: quat ) : float = "sta#%"
fun quat_scale ( q: quat, f: float ) : quat = "sta#%"
fun quat_mul_quat ( q1: quat, q2: quat ) : quat = "sta#%"
fun quat_mul_vec3 ( q: quat, v: vec3 ) : vec3 = "sta#%"

fun quat_inverse ( q: quat ) : quat = "sta#%"
fun quat_unit_inverse ( q: quat ) : quat = "sta#%"
fun quat_length ( q: quat ) : float = "sta#%"
fun quat_normalize ( q: quat ) : quat = "sta#%"

fun quat_exp ( w: vec3 ) : quat = "sta#%"
fun quat_log ( q: quat ) : vec3 = "sta#%"

fun quat_slerp ( q1: quat, q2: quat, amount: float ) : quat = "sta#%"

fun quat_constraint ( q: quat, axis: vec3 ) : quat = "sta#%"
fun quat_constrain_y ( q: quat ) : quat = "sta#%"

fun quat_distance ( q0: quat, q1: quat ) : float = "sta#%"
fun quat_interpolate ( qs: quat ptr, ws: float ptr, count: int ) : quat = "sta#%"

typedef quat_dual = @{ real=quat, dual=quat }

fun quat_dual_id () : quat_dual = "sta#%"
fun quat_dual_new ( real: quat, dual: quat ) : quat_dual = "sta#%"
fun quat_dual_transform ( q: quat, t: vec3 ) quat_dual = "sta#%"
fun quat_dual_mul ( q0: quat_dual, q1: quat_dual ) : quat_dual = "sta#%"
fun quat_dual_mul_vec3 ( q: quat_dual, v: vec3 ) : vec3 = "sta#%"
fun quat_dual_mul_vec3_rot ( q: quat_dual, v: vec3 ) : vec3 = "sta#%"

(*  ###  matrix math  ###  *)
//  mat2 type
typedef mat2 = @{ xx=float, xy=float, yx=float, yy=float }

fun mat2_id () : mat2 = "sta#%"
fun mat2_zero () : mat2 = "sta#%"
fun mat2_new ( xx: float, xy: float, yx: float, yy: float ) : mat2 = "sta#%"
fun mat2_mul_mat2 ( m1: mat2, m2: mat2 ) : mat2 = "sta#%"
fun mat2_mul_vec2 ( m: mat2, v: vec2 ) : = "sta#%"

fun mat2_transpose ( m: mat2 ) : mat2 = "sta#%"
fun mat2_det ( m: mat2 ) : float = "sta#%"
fun mat2_inverse ( m: mat2 ) mat2 = "sta#%"

fun mat2_to_array ( m: mat2, out: float ptr ) : void = "sta#%"
fun mat2_print ( m: mat2 ) : void = "sta#%"
fun mat2_rotation ( a: float ) : mat2 = "sta#%"

//  mat3 type
typedef mat3 = @{ xx=float, xy=float, xz=float, yx=float, yy=float, yz=float, zx=float, zy=float, zz=float }

fun mat3_id () : mat3 = "sta#%"
fun mat3_zero () : mat3 = "sta#%"
fun mat3_new ( xx: float, xy: float, xz: float, yx: float, yy: float, yz: float, zx: float, zy: float, zz: float ) : mat3 = "sta#%"
fun mat3_mul_mat3 ( m1: mat3, m2: mat3 ) : mat3 = "sta#%"
fun mat3_mul_vec3 ( m: mat3, v: vec3 ) : vec3 = "sta#%"

fun mat3_transpose ( m: mat3 ) : mat3 = "sta#%"
fun mat3_det ( m: mat3 ) : float = "sta#%"
fun mat3_inverse ( m: mat3 ) : mat3 = "sta#%"

fun mat3_to_array ( m: mat3, out: float ptr ) : void = "sta#%"
fun mat3_print ( m: mat3 ) : mat3 = "sta#%"

fun mat3_scale ( s: vec3 ) : mat3 = "sta#%"
fun mat3_rotation_x ( a: float ) : mat3 = "sta#%"
fun mat3_rotation_y ( a: float ) : mat3 = "sta#%"
fun mat3_rotation_z ( a: float ) : mat3 = "sta#%"
fun mat3_rotation_angle_axis ( angle: float, axis: vec3 ) : mat3 = "sta#%"

//  mat4 type
typedef mat4 = @{ xx=float, xy=float, xz=float, xw=float, yx=float, yy=float, yz=float, yw=float, zx=float, zy=float, zz=float, zw=float, wx=float, wy=float, wz=float, ww=float }

fun mat4_id () : mat4 = "sta#%"
fun mat4_zero () : mat4 = "sta#%"
fun mat4_new ( xx: float, xy: float, xz: float, xw: float, yx: float, yy: float, yz: float, yw: float, zx: float, zy: float, zz: float, zw: float, wx: float, wy: float, wz: float, ww: float ) : mat4 = "str#%"
fun mat4_at ( m: mat4, i: int, j: int ) : float = "sta#%"
fun mat4_set ( m: mat4, x: int, y: int, v: float ) : mat4 = "sta#%"
fun mat4_transpose ( m: mat4 ) : mat4 = "sta#%"

fun mat4_mul_mat4 ( m1: mat4, m2: mat4 ) : mat4 = "sta#%"

fun mat4_mul_vec4 ( m: mat4, v: vec4 ) : vec4 = "sta#%"
fun mat4_mul_vec3 ( m: mat4, v: vec3 ) : vec3 = "sta#%"

fun mat4_det ( m: mat4 ) : float = "sta#%"
fun mat4_inverse ( m: mat4 ) : mat4 = "sta#%"

fun mat3_to_mat4 ( m: mat3 ) : mat4 = "sta#%"
fun mat4_to_mat3 ( m: mat4 ) : mat3 = "sta#%"
fun mat4_to_quat ( m: mat4 ) : quat = "sta#%"
fun mat4_to_quat_dual ( m: mat4 ) : quat_dual = "sta#%"

fun mat4_to_array ( m: mat4, out: float ptr ) : void = "sta#%"
fun mat4_to_array_trans ( m: mat4, out: float ptr ) : void = "sta#%"

fun mat4_print ( m: mat4 ) : void = "sta#%"

fun mat4_translation ( v: vec3 ) : mat4 = "sta#%"
fun mat4_scale ( v: vec3 ) : mat4 = "sta#%"

fun mat4_rotation_x ( a: float ) : mat4 = "sta#%"
fun mat4_rotation_y ( a: float ) : mat4 = "sta#%"
fun mat4_rotation_z ( a: float ) : mat4 = "sta#%"
fun mat4_rotation_axis_angle ( axis: vec3, angle: float ) : mat4 = "sta#%"

fun mat4_rotation_euler (  x: float, y: float, z: float ) : mat4 = "sta#%"
fun mat4_rotation_quat ( q: quat ) : mat4 = "sta#%"
fun mat4_rotation_quat_dual ( q: quat_dual ) : mat4 = "sta#%"

fun mat4_view_look_at ( position: vec3, target: vec3, up: vec3 ) : mat4 = "sta#%
fun mat4_perspective ( fov: float, near_clip: float, far_clip: float, ratio: float ) : mat4 = "sta#%"
fun mat4_orthographic ( left: float, right: float, bottom: float, top: float, near: float, far: float ) : mat4 = "sta#%"

fun mat4_world ( position: vec3, scale: vec3, rotation: quat ) : mat4 = "sta#%"

fun mat4_lerp ( m1: mat4, m2: mat4, amount: float ) : mat4 = "sta#%"
fun mat4_smoothstep ( m1: mat4, m2: mat4, amount: float ) : mat4 = "sta#%"

(*  ###  geometry  ###  *)

//  plane shape type
typedef plane = @{ direction=vec3, position=vec3 }

fun plane_new ( position: vec3, direction: vec3 ) : plane = "sta#%"
fun plane_transform ( p: plane, world: mat4, world_normal: mat3 ) : plane = "sta#%"
fun plane_transform_space ( p: plane, space: mat3, space_normal: mat3 ) : plane = "sta#%"
fun plane_distance ( p: plane, point: vec3 ) : float = "sta#%"

fun point_inside_plane ( point: vec3, p: plane ) : bool = "sta#%"
fun point_outside_plane ( point: vec3, p: plane ) : bool = "sta#%"
fun point_intersects_plane ( point: vec3, p: plane ) : bool = "sta#%"

fun point_swept_inside_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"
fun point_swept_outside_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"
fun point_swept_intersects_plane ( point: vec3, v: vec3, p: plane ) : bool = "sta#%"

fun plane_closest ( p: plane, v: vec3 ) : vec3 = "sta#%"
fun plane_project ( p: plane, v: vec3 ) : vec3 = "sta#%"

//  box shape type
typedef box = @{ top=plane, bottom=plane, left=plane, right=plane, front=plane, back=plane }

fun box_new ( x_min: float, x_max: float, y_min: float, y_max: float, z_min: float, z_max: float ) : box = "sta#%"
fun box_sphere ( center: vec3, radius: float ) : box = "sta#%"
fun box_merge ( b1: box, b2: box ) : box = "sta#%"
fun box_transform ( b1: box, world: mat4, world_normal: mat3 ) : box = "sta#%"
fun box_invert ( b: box ) : box = "sta#%"
fun box_invert_depth ( b: box ) : box = "sta#%"
fun box_invert_width ( b: box ) : box = "sta#%"
fun box_invert_height ( b: box ) : box = "sta#%"

fun point_inside_box ( point: vec3, b: box ) : bool = "sta#%"
fun point_outside_box ( point: vec3, b: box ) : bool = "sta#%"
fun point_intersects_box ( point: vec3, b: box ) : bool = "sta#%"

//  frustum type
typedef frustum = @{ ntr=vec3, ntl=vec3, nbr=vec3, nbl=vec3, ftr=vec3, ftl=vec3, fbr=vec3, fbl=vec3 }

fun frustum_new ( ntr: vec3, ntl: vec3, nbr: vec3, nbl: vec3, ftr: vec3, ftl: vec3, fbr: vec3, fbl: vec3 ) : frustum = "sta#%"
fun frustum_new_clipbox () : frustum = "sta#%"
fun frustum_new_camera ( view: mat4, proj: mat4 ) : frustum = "sta#%"
fun frustum_slice ( f: frustum, start: float, end: float ) : frustum = "sta#%"
fun frustum_transform ( f: frustum, m: mat4 ) : frustum = "sta#%"
fun frustum_translate ( f: frustum, v: vec3 ) : frustum = "sta#%"

fun frustum_center ( f: frustum ) : vec3 = "sta#%"
fun frustum_maximums ( f: frustum ) : vec3 = "sta#%"
fun frustum_minimums ( f: frustum ) : vec3 = "sta#%"

fun frustum_box ( f: frustum ) : box = "sta#%"

fun frustum_outside_box ( f: frustum, b: box ) : bool = "sta#%"

//  sphere shape type
typedef sphere = @{ center=vec3, radius=float }

fun sphere_unit () : sphere = "sta#%"
fun sphere_point () : sphere = "sta#%"
fun sphere_new ( center: vec3, radius: float ) : sphere = "sta#%"
fun sphere_merge ( s1: sphere, s2: sphere ) : sphere = "sta#%"
fun sphere_merge_many ( s: sphere ptr, count: int ) : sphere = "sta#%"
fun sphere_transform ( s: sphere, world: mat4 ) : sphere = "sta#%"
fun sphere_translate ( s: sphere, x: vec3 ) : sphere = "sta#%"
fun sphere_scale ( s: sphere, x: float ) : sphere = "sta#%"
fun sphere_transform_space ( s: sphere, space: mat3 ) : sphere = "sta#%"

fun sphere_of_box ( bb: box ) : sphere = "sta#%"
fun sphere_of_frustum ( f: frustum ) : sphere = "sta#%"

fun sphere_inside_box ( s: sphere, b: box ) : bool = "sta#%"
fun sphere_outside_box ( s: sphere, b: box ) : bool = "sta#%"
fun sphere_intersects_box ( s: sphere, b: box ) : bool = "sta#%"

fun sphere_inside_frustum ( s: sphere, f: frustum ) : bool = "sta#%"
fun sphere_outside_frustum ( s: sphere, f: frustum ) : bool = "sta#%"
fun sphere_intersects_box ( s: sphere, b: box ) : bool = "sta#%"

fun sphere_outside_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"
fun sphere_inside_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"
fun sphere_intersects_sphere ( s1: sphere, s2: sphere ) : bool = "sta#%"

fun point_inside_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"
fun point_outside_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"
fun point_intersects_sphere ( s: sphere, point: vec3 ) : bool = "sta#%"

fun line_inside_sphere ( s: sphere, start: vec3, end: vec3 ) : bool = "sta#%"
fun line_outside_sphere ( s: sphere, start: vec3, end: vec3 ) : bool = "sta#%"
fun line_intersects_sphere ( s: sphere, start: vec3, end: vec3 ) : bool = "sta#%"

fun sphere_inside_plane ( s: sphere, p: plane ) : bool = "sta#%"
fun sphere_outside_plane ( s: sphere, p: plane ) : bool = "sta#%"
fun sphere_intersects_plane ( s: sphere, p: plane ) : bool = "sta#%"
fun sphere_intersects_plane_point ( s: sphere, p: plane, point: vec3 ptr, radius: float ptr ) : bool = "sta#%"

fun point_swept_inside_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"
fun point_swept_outside_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"
fun point_swept_intersects_sphere ( s: sphere, v: vec3, point: vec3 ) : bool = "sta#%"

fun sphere_swept_inside_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"
fun sphere_swept_outside_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"
fun sphere_swept_intersects_plane ( s: sphere, v: vec3, p: plane ) : bool = "sta#%"

fun point_inside_triangle ( p: vec3, v0: vec3, v1: vec3, v2: vec3 ) : bool = "sta#%"
fun sphere_intersects_face ( s: sphere, v0: vec3, v1: vec3, v2: vec3, norm: vec3 ) : bool = "sta#%"

//  ellipsoid shape type
typedef ellipsoid = @{ center=vec3, radiuses=vec3 }

fun ellipsoid_new ( center: vec3, radiuses: vec3 ) : ellipsoid = "sta#%"
fun ellipsoid_transform ( e: ellipsoid, m: mat4 ) : ellipsoid = "sta#%"
fun ellipsoid_of_sphere ( s: sphere ) : ellipsoid = "sta#%"

fun ellipsoid_space ( e: ellipsoid ) : mat3 = "sta#%"
fun ellipsoid_inv_space ( e: ellipsoid ) : mat3 = "sta#%"

//  capsule shape type
typedef capsule = @{ start=vec3, end=vec3, radius=float }

fun capsule_new ( start: vec3, end: vec3, radius: float ) : capsule = "sta#%"
fun capsule_transform ( c: capsule, m: mat4 ) : capsule = "sta#%"

fun capsule_inside_plane ( c: capsule, p: plane ) : bool = "sta#%"
fun capsule_outside_plane ( c: capsule, p: plane ) : bool = "sta#%"
fun capsule_intersects_plane ( c: capsule, p: plane ) : bool = "sta#%"

//  vertex type
typedef vertex = @{ position=vec3, normal=vec3, tangent=vec3, binormal=vec3, color=vec4, uvs=vec2 }

fun vertex_new () : vertex = "sta#%"
fun vertex_equal ( v1: vertex, v2: vertex ) : bool = "sta#%"
fun vertex_print ( v: vertex ) : void = "sta#%"

//  mesh type
typedef mesh = @{ num_verts=int, num_triangles=int, verticies=vertex ptr, triangles=uint32_t ptr }

fun mesh_new () mesh ptr = "str#%"
fun mesh_delete ( mesh ptr ) : void = "sta#%"

fun mesh_generate_normals ( m: mesh ptr ) : void = "sta#%"
fun mesh_generate_tangents ( m: mesh ptr ) : void = "sta#%"
fun mesh_generate_orthagonal_tangents ( m: mesh ptr ) : void = "sta#%"
fun mesh_generate_texcoords_cylinder ( m: mesh ptr ) : void = "sta#%"

fun mesh_print ( m: mesh ptr ) : void = "sta#%"
fun mesh_surface_area ( m: mesh ptr ) : float = "sta#%"

fun mesh_transform ( m: mesh ptr, transform: mat4 ) : void = "sta#%"
fun mesh_translate ( m: mesh ptr, translation: vec3 ) : void = "sta#%"
fun mesh_scale ( m: mesh ptr, scale: float ) : void = "sta#%"

fun mesh_bounding_sphere ( m: mesh ptr ) : sphere = "sta#%"

//  model type
typedef model = @{ num_meshes=int, meshes=mesh ptr ptr }//  look up exactly what '**' means in C later to get this working

fun model_new () : model ptr = "sta#%:
fun model_delete ( m: model ptr ) : void = "sta#%"

fun model_generate_normals ( m: model ptr ) : void = "sta#%"
fun model_generate_tangents ( m: model ptr ) : void = "sta#%"
fun model_generate_orthagonal_tangents ( m: model ptr ) : void = "sta#%"
fun model_generate_texcoords_cylinder ( m: model ptr ) : void = "sta#%"

fun model_print ( m: model ptr ) : void = "sta#%"
fun model_surface_area ( m: model ptr ) : float = "sta#%"

fun model_transform ( m: model ptr, transform: mat4 ) : void = "sta#%"
fun model_translate ( m: model ptr, translation: vec3 ) : void = "sta#%"
fun model_scale ( m: model ptr, scale: float ) : void = "sta#%"

//  triangle
fun triangle_tangent ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fun triangle_binormal ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fun triangle_normal ( v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fun triangle_random_position (  v1: vertex, v2: vertex, v3: vertex ) : vec3 = "sta#%"
fun triangle_area ( v1: vertex, v2: vertex, v3: vertex ) : float = "sta#%"

fun triangle_difference_u ( v1: vertex, v2: vertex, v3: vertex ) : float = "sta#%"
fun triangle_difference_v ( v1: vertex, v2: vertex, v3: vertex ) float = "sta#%"

fun triangle_random_position_interpolation ( v1: vertex, v2: vertex, v3: vertex ) : vertex = "sta#%"

//  tweening
fun tween_approach ( curr: float, target: float, timestep: float, steepness: float ) : float = "sta#%"
fun tween_linear ( curr: float, target: float, timestep: float, max: float ) : float = "sta#%:

fun vec3_tween_approach ( curr: vec3, target: vec3, timestep: float, steepness: float ) : vec3 = "sta#%"
fun vec3_tween_linear ( curr: vec3, target: vec3, timestep: float, max: float ) : vec3 = "sta#%"