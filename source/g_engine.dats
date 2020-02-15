(*
###  g_engine.dats  ###


*)

staload "./g_engine.sats"

implement P ( path ) =
if strlen (path) >= 256 then None() else Some( @{ path=path }: fpath )

implement fpath_full ( path ) = let
	  var ret: fpath; SDL_PathFullName(ret.path, path.path)
in
	ret
end

implement fpath_file ( path ) = let
	  var ret: fpath; SDL_PathFileName(ret.path, path.path)
in
	ret
end

implement fpath_file_location ( path ) let
	  var ret: fpath; SDL_PathFileLocation(ret.path, path.path)
in
	ret
end

implement fpath_file_extension ( path ) = let
	  var ret: fpath; SDL_PathFileExtension(ret.path, path.path)
in
	ret
end

//  error functions
fun error_func_t ( x: char ptr ) : void
fun warn_func_t ( x: char ptr ) : void
fun debug_func_t ( x: char ptr ) : void

#define MAX_AT_FUNCS 32
(*
static error_func_t error_funcs[MAX_AT_FUNCS];
static warn_func_t warn_funcs[MAX_AT_FUNCS];
static debug_func_t debug_funcs[MAX_AT_FUNCS];
*)

var num_error_funcs: int = 0
var num_warn_funcs: int = 0
var num_debug_funcs: int = 0

implement at_error ( func ) =
(
)

implement at_warning ( func ) =
(
)

implement at_debug ( func ) =
(
)

implement error_ ( str ) =
(
)

implement warning_ ( str ) =
(
)

implement debug_ ( str ) =
(
)

//  timing functions
implement timer_start ( id, tag ) =
	  debug("Timer %d '%s' Start: %f", id, tag, 0.0f); @{id=id, start=SDL_GetTicks(), end=0, split=SDL_GetTicks()}:timer

implement timer_split ( t, tag ) =
(
)

implement timer_stop ( t, tag ) =
(
)

var timestamp_counter: int = 0

implement timestamp ( out ) =
(
)

var frame_rate_string_var: char //[12]

var frame_rate_var: int = 0
var frame_time_var: double = 0

var frame_start_time: unsigned long = 0.0
var frame_end_time: unsigned long = 0.0

val frame_update_rate = 0.5

var frame_counter: int = 0
var frame_acc_time: double = 0.0

implement frame_begin () =
(
)

implement frame_end () =
(
)

implement frame_end_at_rate ( fps ) =
(
)

implement frame_rate () =
(
)

implement frame_time () =
(
)

implement frame_rate_string () =
(
)

//  type functions
#define MAX_TYPE_LEN 512
#define MAX_NUM_TYPES 1024

typedef type_string = char//  [MAX_TYPE_LEN]
typedef type_size = size_t

var type_index: int = 0

implement type_find ( type, size ) =
(
)

implement type_id_name ( id ) =
(
)

//  vector math
fn rawcast ( x: float ): int = g0float2int(x)

implement clamp ( x, bottom, top ) = min(max(x, bottom), top)

implement between ( x, bottom, top ) = (x > bottom) && (x < top)

implement between_or ( x, bottom, top ) = (x >= bottom) && (x <= top)

implement saturate ( x ) = min(max(x, g0float2float_double_float(0.0)), g0float2float_double_float(1.0))

implement lerp ( p1, p2, amount ) = (p2 * amount) + (p1 * (1 - amount))

implement smoothstep ( p1, p2, amount ) = lerp(p1, p2, amount * amount * (3 - 2 * amount))

implement smootherstep ( p1, p2, amount ) = let
	  val scaled_amount = amount * amount * amount * ( amount * (amount * 6 - 15) + 10)
in
	lerp(p1, p2, scaled_amount)
end

//  need to implement cosine() before this function can be finished
implement cosine_interp ( p1, p2, amount ) = let
	  val mu2 =
in
	()
end

//  need to implement roundf() to finish this
implement nearest_interp ( p1, p2, amount ) =
(
)

implement cubic_interp ( p1, p2, p3, p4, amount ) = let
	  val amount_sqrd = amount * amount
	  val amount_cubd = amount * amount * amount
	  val a1 = p4 - p3 - p2 + p1
	  val a2 = p1 - p2 - a1
	  val a3 = p3 - p1
	  val a4 = p2
in
	(a1 * amount_cubd) + (a2 * amount_sqrd) + (a3 * amount) + a4
end

//  need roundf()
implement binearest_interp ( tl, tr, bl, br, x_amount, y_amount ) =
(
)

implement bilinear_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val left = lerp(tl, bl, y_amount)
	  val right = lerp(tr, br, y_amount)
in
	lerp(right, left, x_amount)
end

//  need cosine_interp()
implement bicosine_interp ( tl, tr, bl, br, x_amount, y_amount ) =
(
)

implement bismoothstep_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val left = smoothstep(tl, bl, y_amount)
	  val right = smoothstep(tr, br, y_amount)
in
	smoothstep(right, left, x_amount)
end

implement bismootherstep_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val left = smootherstep(tl, bl, y_amount)
	  val right = smootherstep(tr, br, y_amount)
in
	smootherstep(right, left, x_amount)
end

implement vec2_new ( x, y ) =
(
)

implement vec2_zero () =
(
)

implement vec2_one () =
(
)

implement vec2_add ( v1: vec2, v2: vec2 ) =
(
)

implement vec2_sub ( v1, v2 ) =
(
)

implement vec2_div ( v, fac ) =
(
)

implement vec2_div_vec2 ( v1, v2 ) =
(
)

implement vec2_mul ( v, fac ) =
(
)

implement vec2_mul_vec2 ( v1, v2 ) =
(
)

implement vec2_pow ( v, exp ) =
(
)

implement vec2_neg ( v ) =
(
)

implement vec2_abs ( v ) =
(
)

implement vec2_floor ( v ) =
(
)

implement vec2_fmod ( v, val ) =
(
)

implement vec2_max ( v, x ) =
(
)

implement vec2_min ( v, x ) =
(
)

implement vec2_clamp ( v, b, t ) =
(
)

implement vec2_print ( v ) =
(
)

implement vec2_dot ( v1, v2 ) =
(
)

implement vec2_length_sqrd ( v ) =
(
)

implement vec2_length ( v ) =
(
)

implement vec2_dist_sqrd ( v1, v2 ) =
(
)

implement vec2_dist ( v1, v2 ) =
(
)

implement vec2_dist_manhattan ( v1, v2 ) =
(
)

implement vec2_normalize ( v ) =
(
)

implement vec2_reflect ( v1, v2 ) =
(
)

implement vec2_from_string ( s ) =
(
)

implement vec2_equ ( v1, v2 ) =
(
)

implement vec2_to_array ( v, out ) =
(
)

implement vec2_hash ( v ) =
(
)

implement vec2_mix_hash ( v ) =
(
)

implement vec2_saturate ( v ) =
(
)

implement vec2_lerp ( v1, v2, amount ) =
(
)

implement vec2_smoothstep ( v1, v2, amount ) =
(
)

implement vec2_smootherstep  ( v1, v2, amount ) =
(
)

//  vec3

implement vec3_new ( x, y, z ) =
(
)

implement vec3_zero () =
(
)

implement vec3_one () =
(
)

implement vec3_red () =
(
)

implement vec3_green () =
(
)

implement vec3_blue () =
(
)

implement vec3_white () =
(
)

implement vec3_black () =
(
)

implement vec3_grey () =
(
)

implement vec3_light_grey () =
(
)

implement vec3_dark_grey () =
(
)

implement vec3_up () =
(
)

implement vec3_add ( v1, v2 ) =
(
)

implement vec3_sub ( v1, v2 ) =
(
)

implement vec3_div ( v, fac ) =
(
)

implement vec3_div_vec3 ( v1, v2 ) =
(
)

implement vec3_mul ( v, fac ) =
(
)

implement vec3_mul_vec3 ( v1, v2 ) =
(
)

implement vec3_pow ( v, exp ) =
(
)

implement vec3_neg ( v ) =
(
)

implement vec3_abs ( v ) =
(
)

implement vec3_floor ( v ) =
(
)

implement vec3_fmod ( v, val ) =
(
)

implement vec3_print ( v ) =
(
)

implement vec3_dot ( v1, v2 ) =
(
)

implement vec3_cross ( v1, v2 ) =
(
)

implement vec3_length_sqrd ( v ) =
(
)

implement vec3_length ( v ) =
(
)

implement vec3_dist_sqrd ( v1, v2 ) =
(
)

implement vec3_dist ( v1, v2 ) =
(
)

implement vec3_dist_manhattan ( v1, v2 ) =
(
)

implement vec3_normalize ( v ) =
(
)

implement vec3_reflect ( v1, v2 ) =
(
)

implement vec3_project ( v1, v2 ) =
(
)

implement vec3_from_string ( s ) =
(
)

implement vec3_equ ( v1, v2 ) =
(
)

implement vec3_neq ( v1, v2 ) =
(
)

implement vec3_to_array ( v, out ) =
(
)

implement vec3_hash ( v ) =
(
)

implement vec3_to_homogeneous ( v ) =
(
)

implement vec3_saturate ( v ) =
(
)

implement vec3_lerp ( v1, v2, amount ) =
(
)

implement vec3_smoothstep ( v1, v2, amount ) =
(
)

implement vec3_smootherstep ( v1, v2, amount ) =
(
)

//  vec4
implement vec4_new ( x, y, z, w ) =
(
)

implement vec4_zero () =
(
)

implement vec4_one () =
(
)

implement vec4_red () =
(
)

implement vec4_green () =
(
)

implement vec4_blue () =
(
)

implement vec4_white () =
(
)

implement vec4_black () =
(
)

implement vec4_grey () =
(
)

implement vec4_light_grey () =
(
)

implement vec4_dark_grey () =
(
)

implement vec4_add ( v1, v2 ) =
(
)

implement vec4_sub ( v1, v2 ) =
(
)

implement vec4_div ( v, fac ) =
(
)

implement vec4_mul ( v, fac ) =
(
)

implement vec4_mul_vec4 ( v1, v2 ) =
(
)

implement vec4_pow ( v, exp ) =
(
)

implement vec4_neg ( v ) =
(
)

implement vec4_abs ( v ) =
(
)

implement vec4_floor ( v ) =
(
)

implement vec4_fmod ( v, val ) =
(
)

implement vec4_sqrt ( v ) =
(
)

implement vec4_print ( v ) =
(
)

implement vec4_dot ( v1, v2 ) =
(
)

implement vec4_length_sqrd ( v ) =
(
)

implement vec4_length ( v ) =
(
)

implement vec4_dist_sqrd ( v1, v2 ) =
(
)

implement vec4_dist ( v1, v2 ) =
(
)

implement vec4_dist_manhattan ( v1, v2 ) =
(
)

implement vec4_normalize ( v ) =
(
)

implement vec4_reflect ( v1, v2 ) =
(
)

implement vec4_from_string ( s ) =
(
)

implement vec4_max ( v1, v2 ) =
(
)

implement vec4_min ( v1, v2 ) =
(
)

implement vec4_equ ( v1, v2 ) =
(
)

implement vec4_to_array ( v, out ) =
(
)

implement vec4_from_homogeneous ( v ) =
(
)

implement vec4_hash ( v ) =
(
)

implement vec4_saturate ( v ) =
(
)

implement vec4_lerp ( v1, v2, amount ) =
(
)

implement vec4_smoothstep ( v1, v2, amount ) =
(
)

implement vec4_smootherstep ( v1, v2, amount ) =
(
)

implement vec4_nearest_interp ( v1, v2, amount ) =
(
)

implement vec4_binearest_interp ( tl, tr, bl, br, x_amount, y_amount ) =
(
)

implement vec4_bilinear_interp ( tl, tr, bl, br, x_amount, y_amount ) =
(
)

implement quat_id () =
(
)

implement quat_new ( x, y, z, w ) =
(
)

implement quat_at ( q, i ) =
(
)

implement quat_real ( q ) =
(
)

implement quat_imaginaries ( q ) =
(
)

implement quat_from_euler ( r ) =
(
)

implement quat_angle_axis ( angle, axis ) =
(
)

implement quat_rotation_x ( angle ) =
(
)

implement quat_rotation_y ( angle ) =
(
)

implement quat_rotation_z ( angle ) =
(
)

implement quat_to_angle_axis ( q, axis, angle ) =
(
)

implement quat_to_euler ( q ) =
(
)

implement quat_mul_quat ( q1, q2 ) =
(
)

implement quat_mul_vec3 ( q, v ) =
(
)

implement quat_inverse ( q ) =
(
)

implement quat_unit_inverse ( q ) =
(
)

implement quat_length ( q ) =
(
)

implement quat_normalize ( q ) =
(
)

implement quat_slerp ( from, to, amount ) =
(
)

implement quat_dot ( q1, q2 ) =
(
)

implement quat_exp ( w ) =
(
)

implement quat_log ( q ) =
(
)

implement quat_get_value ( t, axis ) =
(
)

implement quat_constrain ( q, axis ) =
(
)

implement quat_constrain_y ( q ) =
(
)

implement quat_distance ( q0, q1 ) =
(
)

implement quat_neg ( q ) =
(
)

implement quat_scale ( q, f ) =
(
)

implement quat_interpolate ( qs, ws, count ) =
(
)

implement quat_dual_new ( real, dual ) =
(
)

implement quat_dual_id () =
(
)

implement quat_dual_transform ( q, t ) =
(
)

implement quat_dual_mul ( q0, q1 ) =
(
)

implement quat_dual_normalize ( q ) =
(
)

implement quat_dual_mul_vec3 ( q, v ) =
(
)

implement quat_dual_mul_vec3_rot ( q, v ) =
(
)

//  matrix functions
implement mat2_id () =
(
)

implement mat2_zero () =
(
)

implement mat2_new ( xx, xy, yx, yy ) =
(
)

implement mat2_mul_mat2 ( m1, m2 ) =
(
)

implement mat2_mul_vec2 ( m, v ) =
(
)

implement mat2_transpose ( m ) =
(
)

implement mat2_det ( m ) =
(
)

implement mat2_inverse ( m ) =
(
)

implement mat2_to_array ( m, out ) =
(
)

implement mat2_print ( m ) =
(
)

implement mat2_rotation ( a ) =
(
)

//  matrix 3 by 3
implement mat3_zero (  ) =
(
)

implement mat3_id (  ) =
(
)

implement mat3_new
(
xx, xy, xz,
yx, yy, yz,
zx, zy, zz
) =
(
)

implement mat3_mul_mat3 ( m1, m2 ) =
(
)

implement mat3_mul_vec3 ( m, v ) =
(
)

implement mat3_transpose ( m ) =
(
)

implement mat3_det ( m ) =
(
)

implement mat3_inverse ( m ) =
(
)

implement mat3_to_array ( m, out ) =
(
)

implement mat3_print ( m ) =
(
)

implement mat3_rotation_x ( a ) =
(
)

implement mat3_scale ( s ) =
(
)

implement mat3_rotation_y ( a ) =
(
)

implement mat3_rotation_z ( a ) =
(
)

implement mat3_rotation_angle_axis ( a, v ) =
(
)

//  matrix 4 by 4
implement mat4_zero (  ) =
(
)

implement mat4_id (  ) =
(
)

implement mat4_at ( m, x, y ) =
(
)

implement mat4_set ( m, x, y, v ) =
(
)

implement mat4_new
(
xx, xy, xz, xw,
yx, yy, yz, yw,
zx, zy, zz, zw,
wx, wy, wz, ww
) =
(
)

implement mat4_transpose ( m ) =
(
)

implement mat3_to_mat4 ( m ) =
(
)

implement mat4_mul_mat4 ( m1, m2 ) =
(
)

implement mat4_mul_vec4 ( m, v ) =
(
)

implement mat4_mul_vec3 ( m, v ) =
(
)

implement mat4_to_mat3 ( m ) =
(
)

implement mat4_to_quat ( m ) =
(
)

implement mat4_to_quat_dual ( m ) =
(
)

implement mat4_det ( m ) =
(
)

implement mat4_inverse ( m ) =
(
)

implement mat4_to_array ( m, out ) =
(
)

implement mat4_to_array_trans ( m, out ) =
(
)

implement mat4_print ( m ) =
(
)

implement mat4_view_look_at ( position, target, up ) =
(
)

implement mat4_perspective ( fov, near_clip, far_clip, ratio ) =
(
)

implement mat4_orthographic ( left, right, bottom, top, clip_near, clip_far ) =
(
)

implement mat4_translation ( v ) =
(
)

implement mat4_scale ( v ) =
(
)

implement mat4_rotation_x ( a ) =
(
)

implement mat4_rotation_y ( a ) =
(
)

implement mat4_rotation_z ( a ) =
(
)

implement mat4_rotation_axis_angle ( v, angle ) =
(
)

implement mat4_rotation_euler ( x, y, z ) =
(
)

implement mat4_rotation_quat ( q ) =
(
)

implement mat4_roatation_quat_dual ( q ) =
(
)

implement mat4_world ( position, scale, rotation ) =
(
)

implement mat4_lerp ( m1, m2, amount ) =
(
)

implement mat4_smoothstep ( m1, m2, amount ) =
(
)

//  geometry functions
implement plane_new ( position, direction ) =
(
)

implement plane_distance ( p, point ) =
(
)

implement plane_transform ( p, world, world_normal ) =
(
)

implement point_inside_plane ( point, p ) =
(
)

implement point_outside_plane ( point, p ) =
(
)

implement point_intersects_plane ( point, p ) =
(
)

implement plane_project ( p, v ) =
(
)

implement plane_closest ( p, v ) =
(
)

implement point_swept_inside_plane ( point, v, p ) =
(
)

implement point_swept_outside_plane ( point, v, p ) =
(
)

implement point_swept_intersects_plane ( point, v, p ) =
(
)

implement box_new ( x_min, x_max, y_min, y_max, z_min, z_max ) =
(
)

implement box_sphere ( center, radius ) =
(
)

implement box_invert ( b ) =
(
)

implement box_invert_depth ( b ) =
(
)

implement box_invert_width ( b ) =
(
)

implement box_new ( x_min, x_max, y_min, y_max, z_min, z_max ) =
(
)

implement box_sphere ( center, radius ) =
(
)

implement box_invert ( b ) =
(
)

implement box_invert_depth ( b ) =
(
)

implement box_invert_width ( b ) =
(
)

implement box_invert_height ( b ) =
(
)

implement point_inside_box ( point, b ) =
(
)

implement point_outside_box ( point, b ) =
(
)

implement point_intersects_box ( point, b ) =
(
)

implement box_merge ( b1, b2 ) =
(
)

implement box_transform ( bb, world, world_normal ) =
(
)

implement frustum_new ( ntr, ntl, nbr, nbl, ftr, ftl, fbr, fbl ) =
(
)

implement frustum_new_clipbox (  ) =
(
)

implement frustum_new_camera ( view, proj ) =
(
)

implement frustum_slice ( f, start, end ) =
(
)

implement frustum_center ( f ) =
(
)

implement frustum_maximums ( f ) =
(
)

implement frustum_minimums ( f ) =
(
)

implement frustum_transform ( f, m ) =
(
)

implement frustum_translate ( f, v ) =
(
)

implement frustum_box ( f ) =
(
)

implement frustum_outside_box ( f, b ) =
(
)

implement sphere_outside_frustum ( s, f ) =
(
)

implement sphere_inside_frustum ( s, f ) =
(
)

implement sphere_intersects_frustum ( s, f ) =
(
)

implement sphere_outside_sphere ( s1, s2 ) =
(
)

implement sphere_unit (  ) =
(
)

implement sphere_point (  ) =
(
)

implement sphere_new ( center, radius ) =
(
)

implement sphere_of_box ( bb ) =
(
)

implement sphere_of_frustum ( f ) =
(
)

implement sphere_merge ( bs1, bs2 ) =
(
)

implement sphere_merge_many ( s, count ) =
(
)

implement sphere_inside_box ( s, b ) =
(
)

implement sphere_outside_box ( s, b ) =
(
)

implement sphere_intersects_box ( s, b ) =
(
)

implement sphere_transform ( s, world ) =
(
)

implement sphere_translate ( s, x ) =
(
)

implement sphere_scale ( s, x ) =
(
)

implement sphere_transform_space ( s, space ) =
(
)

implement point_inside_sphere ( s, point ) =
(
)

implement point_outside_sphere ( s, point ) =
(
)

implement point_intersects_sphere ( s, point ) =
(
)

implement line_inside_sphere ( s, start, end ) =
(
)

implement line_outside_sphere ( s, start, end ) =
(
)

implement line_intersects_sphere ( s, start, end ) =
(
)

implement sphere_inside_plane ( s, p ) =
(
)

implement sphere_outside_plane ( s, p ) =
(
)

implement sphere_intersects_plane ( s, p ) =
(
)

implement sphere_intersects_plane_point ( s, p, point, radius ) =
(
)

implement sphere_swept_inside_plane ( s, v, p ) =
(
)

implement sphere_swept_outside_plane ( s, v, p ) =
(
)

implement sphere_swept_intersects_plane ( s, v, p ) =
(
)

implement quadratic ( a, b, c, t0, t1 ) =
(
)

implement point_swept_inside_sphere ( s, v, point ) =
(
)

implement point_swept_outside_sphere ( s, v, point ) =
(
)

implement point_swept_intersects_sphere ( s, v, point ) =
(
)

implement sphere_swept_outside_sphere ( s1, v, s2 ) =
(
)

implement sphere_swept_inside_sphere ( s1, v, s2 ) =
(
)

implement sphere_swept_intersects_sphere ( s1, v, s2 ) =
(
)

implement point_inside_triangle ( p, v0, v1, v2 ) =
(
)

implement sphere_intersects_face ( s, v0, v1, v2, norm ) =
(
)

implement ellipsoid_new ( center, radiuses ) =
(
)

implement ellipsoid_of_sphere ( s ) =
(
)

implement ellipsoid_transform ( e, m ) =
(
)

implement ellipsoid_space ( e ) =
(
)

implement ellipsoid_inv_space ( e ) =
(
)

implement capsule_new ( start, end, radius ) =
(
)

implement capsule_transform ( c, m ) =
(
)

implement capsule_inside_plane ( c, p ) =
(
)

implement capsule_outside_plane ( c, p ) =
(
)

implement capsule_intersects_plane ( c, p ) =
(
)

implement vertex_new (  ) =
(
)

implement vertex_equal ( v1, v2 ) =
(
)

implement vertex_print ( v ) =
(
)

implement mesh_print ( m ) =
(
)

implement mesh_new (  ) =
(
)

implement mesh_delete ( m ) =
(
)

implement mesh_generate_tangents ( m ) =
(
)

implement mesh_generate_normals ( m ) =
(
)

implement mesh_generate_orthogonal_tangents ( m ) =
(
)

implement mesh_generate_texcoords_cylinder ( m ) =
(
)

implement mesh_surface_area ( m ) =
(
)

implement mesh_translate ( m, translation ) =
(
)

implement mesh_scale ( m, scale ) =
(
)

implement mesh_transform ( m, transform ) =
(
)

implement mesh_bounding_sphere ( m ) =
(
)

implement model_print ( m ) =
(
)

implement model_new (  ) =
(
)

implement model_delete ( m ) =
(
)

implement model_generate_normals ( m ) =
(
)

implement model_generate_tangents ( m ) =
(
)

implement model_generate_orthogonal_tangents ( m ) =
(
)

implement model_generate_texcoords_cylinder ( m ) =
(
)

implement model_surface_area ( m ) =
(
)

implement model_translate ( m, translation ) =
(
)

implement model_scale ( m, scale ) =
(
)

implement model_transform ( m, transform ) =
(
)

implement triangle_tangent ( vert1, vert2, vert3 ) =
(
)

implement triangle_binormal ( vert1, vert2, vert3 ) =
(
)

implement triangle_normal ( v1, v2, v3 ) =
(
)

implement triangle_area ( v1, v2, v3 ) =
(
)

implement triangle_random_position ( v1, v2, v3 ) =
(
)

implement triangle_random_position_interpolation ( v1, v2, v3 ) =
(
)

implement triangle_difference_u ( v1, v2, v3 ) =
(
)

implement triangle_difference_v ( v1, v2, v3 ) =
(
)

implement tween_approach ( curr, target, timestep, steepness ) =
(
)

implement tween_linear ( curr, target, timestep, max ) =
(
)

implement vec3_tween_approach ( curr, target, timestep, steepness ) =
(
)

implement vec3_tween_linear ( curr, target, timestep, max ) =
(
)