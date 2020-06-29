(*
###  g_engine.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_engine.sats"

val PATH_MAX = 256

extern castfn int_to_ulint ( x: int ): ulint
extern castfn ulint_to_float ( x: ulint ): float
extern castfn ulint_to_double ( x: ulint ): double
extern castfn float_to_uint ( x: float ): uint

implement P ( path ) =
  if strlen (path) >= PATH_MAX
    then ( println!("Path too long: ", path); @{path=""} : fpath)
  else @{path=path} : fpath

//  use call by reference (&) instead of passing a pointer to a string (because it's easier to deal with)
implement fpath_full ( path_in ) = ret where {
  val ret = @{path=SDL_PathFullName(path_in.path)}:fpath
}

implement fpath_file ( path ) = ret where {
  val ret = @{path=SDL_PathFileName(path.path)}:fpath
}

implement fpath_file_location ( path ) = ret where {
  val ret = @{path=SDL_PathFileLocation(path.path)}:fpath
}

implement fpath_file_extension ( path ) = ret where {
  val ret = @{path=SDL_PathFileExtension(path.path)}:fpath
}

//  timing functions
implement timer_start ( id, tag ) = (
	  println!("Timer ", id, tag, "Start: ", (0.0f));
          @{id=id, start_time=SDL_GetTicks(), end_time=int_to_ulint(0), split=SDL_GetTicks()}:timer
)

implement timer_split ( t, tag ) = let
  val curr = SDL_GetTicks()
  val difference = (curr - t.split) / int_to_ulint(1000)
  var ret = t
in
  println!("Timer ", t.id, tag, "Split: ", difference);
  ret.split := curr;
  ret
end

implement timer_stop ( t, tag ) = let
  val curr = SDL_GetTicks()
  val difference = (curr - t.split) / int_to_ulint(1000)
  var ret = t
in
  println!("Timer ", t.id, tag, "End: ", difference);
  ret.end_time := SDL_GetTicks();
  ret
end

var timestamp_counter: int = 0

implement timestamp ( out, ts_counter ) = let
  var ltime = $TIME.time_get()
  var time_value: $TIME.tm_struct
  val p = $TIME.localtime_r(ltime, time_value)
  prval () = opt_unsome (time_value)
in
  println!(out,
  time_value.tm_mday,
  time_value.tm_mon,
  time_value.tm_year,
  time_value.tm_hour,
  time_value.tm_min,
  time_value.tm_sec,
  ts_counter);
  (ts_counter + 1)
end

var frame_rate_var: int = 0
var frame_time_var: double = 0.0

var frame_start_time: ulint = int_to_ulint(0)
var frame_end_time: ulint = int_to_ulint(0)

val frame_update_rate = 0.5

var frame_counter: int = 0
var frame_acc_time: double = 0.0

implement frame_begin () = begin
  SDL_GetTicks()
end

implement frame_end ( fstartt, fendt, ftimev, facct, fcntr, frv ) = let
  val fendt = SDL_GetTicks()
  val ftimev = (fendt - fstartt) / int_to_ulint(1000)
  var facct = facct + ftimev
  var fcntr = fcntr + int_to_ulint(1)
  var frv = frv
in
  if (ulint_to_float(facct) > frame_update_rate) then begin
    frv := $MATH.round(fcntr / facct);
    fcntr := int_to_ulint(0);
    facct := int_to_ulint(0);
    (fstartt, fendt, ftimev, facct, fcntr, frv)
  end else (fstartt, fendt, ftimev, facct, fcntr, frv)
end

implement frame_end_at_rate ( fps, fstartt, fendt, ftimev, facct, fcntr, frv ) = let
  val end_ticks = SDL_GetTicks()
  val active_frame_time = (end_ticks - fstartt) / int_to_ulint(1000)
  val wait = (1.0 / fps) - ulint_to_double(active_frame_time)
  val milliseconds = float_to_uint(max(wait, 0.0) * 1000.f)
  val () = SDL_Delay(milliseconds)
  val fe = frame_end(fstartt, fendt, ftimev, facct, fcntr, frv)
in
  ()
end

//implement frame_rate () = frame_rate_var

//implement frame_time () = frame_time_var

//  vector math
fn rawcast {} ( x: float ): int = g0float2int(x)

implement clamp ( x, bottom, top ) = min(max(x, bottom), top)

implement between ( x, bottom, top ) = (x > bottom) && (x < top)

implement between_or ( x, bottom, top ) = (x >= bottom) && (x <= top)

implement saturate ( x ) = min(max(x, 0.0f), 1.0)

implement lerp ( p1, p2, amount ) = (p2 * amount) + (p1 * (1 - amount))

implement smoothstep ( p1, p2, amount ) = lerp(p1, p2, amount * amount * (3 - 2 * amount))

implement smootherstep ( p1, p2, amount ) = let
	  val scaled_amount = amount * amount * amount * ( amount * (amount * 6 - 15) + 10)
in
	lerp(p1, p2, scaled_amount)
end

implement cosine_interp ( p1, p2, amount ) = let
	  val mu2 = (1 - $MATH.cos(amount * g0float2float_double_float($MATH.M_PI))) / 2
in
	(p2 * (1 - mu2) + p1 * mu2)
end

implement nearest_interp ( p1, p2, amount ) = let
	  val rounded_amount = g0float2float_double_float($MATH.round(amount))
in
	if rounded_amount != 0.f
	   then p2
	else p1
end

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

implement binearest_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val x_amount:float = $MATH.round(x_amount)
	  val y_amount:float = $MATH.round(y_amount)
in
	if (x_amount != 0.f && y_amount = 0.f) then (br)
	else if (x_amount = 0.f && y_amount != 0.f) then (tl)
	else if (x_amount = 0.f && y_amount = 0.f) then (bl)
	else if (x_amount != 0.f && y_amount != 0.f) then (tr)
	else 0.0f
end

implement bilinear_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val left = lerp(tl, bl, y_amount)
	  val right = lerp(tr, br, y_amount)
in
	lerp(right, left, x_amount)
end

implement bicosine_interp ( tl, tr, bl, br, x_amount, y_amount ) = let
	  val left = cosine_interp(tl, bl, y_amount)
	  val right = cosine_interp(tr, br, y_amount)
in
	cosine_interp(right, left, x_amount)
end

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

implement vec2_new ( x, y ) = @{ x=x, y=y }:vec2

implement vec2_zero () = vec2_new(0.f, 0.f)

implement vec2_one () = vec2_new(0.f, 0.f)

implement vec2_add ( v1, v2 ) = @{ x=(v1.x + v2.x), y=(v1.y + v2.y) }:vec2

implement vec2_sub ( v1, v2 ) = @{ x=(v1.x - v2.x), y=(v1.y - v2.y) }:vec2

implement vec2_div ( v, fac ) = @{ x=(v.x / fac), y=(v.y / fac) }:vec2

implement vec2_div_vec2 ( v1, v2 ) = @{ x=(v1.x / v2.x), y=(v1.y / v2.y) }:vec2

implement vec2_mul ( v, fac ) = @{ x=(v.x * fac), y=(v.y * fac) }:vec2

implement vec2_mul_vec2 ( v1, v2 ) = @{ x=(v1.x * v2.x), y=(v1.y * v2.y) }:vec2

implement vec2_pow ( v, exp ) = @{ x=($MATH.pow(v.x, exp)), y=($MATH.pow(v.y, exp)) }:vec2

implement vec2_neg ( v ) = @{ x=(~v.x), y=(~v.y) }:vec2

implement vec2_abs ( v ) = @{ x=(abs(v.x)), y=(abs(v.y)) }:vec2

implement vec2_floor ( v ) = @{ x=($MATH.floor(v.x)), y=($MATH.floor(v.y)) }:vec2

implement vec2_fmod ( v, vl ) = @{ x=($MATH.fmod(v.x, vl)), y=($MATH.fmod(v.y, vl)) }:vec2

implement vec2_max ( v, x ) = @{ x=(max(v.x, x)), y=(max(v.y, x)) }:vec2

implement vec2_min ( v, x ) = @{ x=(min(v.x, x)), y=(min(v.y, x)) }:vec2

implement vec2_clamp ( v, b, t ) = @{ x=(clamp(v.x, b, t)), y=(clamp(v.y, b, t)) }:vec2

implement vec2_print ( v ) = begin
	  print("vec2 (");
	  print_float(v.x);
	  print(", ");
	  print_float(v.y);
	  print(")");
end

implement vec2_dot ( v1, v2 ) = (v1.x * v2.x) + (v1.y * v2.y)

implement vec2_length_sqrd ( v ) = (v.x * v.x) + (v.y * v.y)

implement vec2_length ( v ) = $MATH.sqrt(vec2_length_sqrd(v))

implement vec2_dist_sqrd ( v1, v2 ) =
	  (v1.x - v2.x) * (v1.x - v2.x) +
	  (v1.y - v2.y) * (v1.y - v2.y);

implement vec2_dist ( v1, v2 ) = $MATH.sqrt(vec2_dist_sqrd(v1, v2))

implement vec2_dist_manhattan ( v1, v2 ) =
	  abs(v1.x - v2.x) + abs(v1.y - v2.y)

implement vec2_normalize ( v ) =
	  vec2_div(v, vec2_length(v))

implement vec2_reflect ( v1, v2 ) =
	  vec2_sub(v1, vec2_mul(v2, 2 * vec2_dot(v1, v2)))

implement vec2_equ ( v1, v2 ) =
	  if (not(v1.x = v2.x)) then false
	  else if (not(v1.y = v2.y)) then false
	  else true

implement vec2_to_array ( v, out ) =
(
  out[0] := v.x;
  out[1] := v.y
)

extern fn bin_xor ( x1: int, x2: int ) : int = "ext#bin_xor_c"
%{
int bin_xor_c ( int x1, int x2 ) {
  return x1 ^ x2
}
%}

implement vec2_hash ( v ) = abs(bin_xor(rawcast(v.x), rawcast(v.y)))

implement vec2_mix_hash ( v ) = let
	  val raw_vx = abs(rawcast(v.x))
	  val raw_vy = abs(rawcast(v.y))

	  val h1 = raw_vx << 1
	  val h2 = raw_vy << 3
	  val h3 = raw_vx >> 8

	  val h4 = raw_vy << 7
	  val h5 = raw_vx >> 12
	  val h6 = raw_vy >> 15

	  val h7 = raw_vx << 2
	  val h8 = raw_vy << 6
	  val h9 = raw_vx >> 2

	  val h10 = raw_vy << 9
	  val h11 = raw_vx >> 21
	  val h12 = raw_vy >> 13

	  val res1 = bin_xor(bin_xor(h1, h2), h3)
	  val res2 = bin_xor(bin_xor(h4, h5), h6)
	  val res3 = bin_xor(bin_xor(h7, h8), h9)
	  val res4 = bin_xor(bin_xor(h10, h11), h12)
in
	bin_xor(bin_xor(bin_xor((res1 * 10252247), (res2 * 70209673)), (res3 * 104711)), (res4 * 63589))
end

implement vec2_saturate ( v ) =
	  @{x=saturate(v.x), y=saturate(v.y)}:vec2

implement vec2_lerp ( v1, v2, amount ) =
	  @{x=lerp(v1.x, v2.x, amount), y=lerp(v1.y, v2.y, amount)}:vec2

implement vec2_smoothstep ( v1, v2, amount ) = let
	  val scaled_amount = amount * amount * (3 - 2 * amount);
in
	vec2_lerp(v1, v2, scaled_amount)
end

implement vec2_smootherstep  ( v1, v2, amount ) = let
	  val scaled_amount = amount * amount * amount * (amount * (amount * 6 - 15) + 10);
in
	vec2_lerp(v1, v2, scaled_amount)
end

//  vec3

implement vec3_new ( x, y, z ) =
	  @{x=x, y=y, z=z}:vec3

implement vec3_zero () =
	  vec3_new(0.f, 0.f, 0.f)

implement vec3_one () =
	  vec3_new(1.f, 1.f, 1.f)

implement vec3_red () =
	  vec3_new(1.f, 0.f, 0.f)

implement vec3_green () =
	  vec3_new(0.f, 1.f, 0.f)

implement vec3_blue () =
	  vec3_new(0.f, 0.f, 1.f)

implement vec3_white () =
	  vec3_new(1.f, 1.f, 1.f)

implement vec3_black () =
	  vec3_new(0.f, 0.f, 0.f)

implement vec3_grey () =
	  vec3_new(0.5f, 0.5f, 0.5f)

implement vec3_light_grey () =
	  vec3_new(0.75f, 0.75f, 0.75f)

implement vec3_dark_grey () =
	  vec3_new(0.25f, 0.25f, 0.25f)

implement vec3_up () =
	  vec3_new(0.f, 1.f, 0.f)

implement vec3_add ( v1, v2 ) =
	  vec3_new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

implement vec3_sub ( v1, v2 ) =
	  vec3_new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)

implement vec3_div ( v, fac ) =
	  vec3_new(v.x / fac, v.y / fac, v.z / fac)

implement vec3_div_vec3 ( v1, v2 ) =
	  vec3_new(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z)

implement vec3_mul ( v, fac ) =
	  vec3_new(v.x * fac, v.y * fac, v.z * fac)

implement vec3_mul_vec3 ( v1, v2 ) =
	  vec3_new(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)

implement vec3_pow ( v, fac ) =
	  vec3_new($MATH.pow(v.x, fac), $MATH.pow(v.y, fac), $MATH.pow(v.z, fac))

implement vec3_neg ( v ) =
	  vec3_new((~v.x), (~v.y), (~v.z))

implement vec3_abs ( v ) =
	  vec3_new(abs(v.x), abs(v.y), abs(v.z))

implement vec3_floor ( v ) =
	  vec3_new($MATH.floor(v.x), $MATH.floor(v.y), $MATH.floor(v.z))

implement vec3_fmod ( v, vl ) =
	  vec3_new($MATH.fmod(v.x, vl), $MATH.fmod(v.y, vl), $MATH.fmod(v.z, vl))

implement vec3_print ( v ) = begin
	  print("vec3 (");
	  print_float(v.x);
	  print(", ");
	  print_float(v.y);
	  print(", ");
	  print_float(v.z);
	  print(")");
end

implement vec3_dot ( v1, v2 ) =
	  (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z)

implement vec3_cross ( v1, v2 ) =
	  @{x=((v1.y * v2.z) - (v1.z * v2.y)), y=((v1.z * v2.x) - (v1.x * v2.z)), z=((v1.x * v2.y) - (v1.y * v2.x))}:vec3

implement vec3_length_sqrd ( v ) =
	  (v.x * v.x) + (v.y * v.y) + (v.z * v.z)

implement vec3_length ( v ) =
	  $MATH.sqrt(vec3_length_sqrd(v))

implement vec3_dist_sqrd ( v1, v2 ) =
	  (v1.x - v2.x) * (v1.x - v2.x) +
	  (v1.y - v2.y) * (v1.y - v2.y) +
	  (v1.z - v2.z) * (v1.z - v2.z);

implement vec3_dist ( v1, v2 ) =
	  $MATH.sqrt(vec3_dist_sqrd(v1, v2))

implement vec3_dist_manhattan ( v1, v2 ) =
	  abs(v1.x - v2.x) + abs(v1.y - v2.y) + abs(v1.z - v2.z)

implement vec3_normalize ( v ) = let
	  val len = vec3_length(v);
in
	if (len = 0.0f) then vec3_zero()
	else vec3_div(v, len)
end

implement vec3_reflect ( v1, v2 ) =
	  vec3_sub(v1, vec3_mul(v2, 2 * vec3_dot(v1, v2)))

implement vec3_project ( v1, v2 ) =
	  vec3_sub(v1, vec3_mul(v2, vec3_dot(v1, v2)))

implement vec3_equ ( v1, v2 ) =
	  if (not(v1.x = v2.x)) then false
	  else if (not(v1.y = v2.y)) then false
	  else if (not(v1.z = v2.z)) then false
	  else true

implement vec3_neq ( v1, v2 ) =
	  if (not(v1.x = v2.x)) then true
	  else if (not(v1.y = v2.y)) then true
	  else if (not(v1.z = v2.z)) then true
	  else false

implement vec3_to_array ( v, out ) = begin
  out[0] := v.x;
  out[1] := v.y;
  out[2] := v.z
end

implement vec3_hash ( v ) =
	  abs( bin_xor(bin_xor(rawcast(v.x), rawcast(v.y)), rawcast(v.z)) )

implement vec3_to_homogeneous ( v ) =
	  vec4_new(v.x, v.y, v.z, 1.0f)

implement vec3_saturate ( v ) =
	  @{x=saturate(v.x), y=saturate(v.y), z=saturate(v.z)}:vec3

implement vec3_lerp ( v1, v2, amount ) =
	  @{x=lerp(v1.x, v2.x, amount), y=lerp(v1.y, v2.y, amount), z=lerp(v1.z, v2.z, amount)}:vec3

implement vec3_smoothstep ( v1, v2, amount ) = let
	  val scaled_amount = amount * amount * (3 - 2 * amount)
in
	vec3_lerp(v1, v2, scaled_amount)
end

implement vec3_smootherstep ( v1, v2, amount ) = let
	  val scaled_amount = amount*amount*amount*(amount*(amount*6 - 15) + 10)
in
	vec3_lerp(v1, v2, scaled_amount)
end

//  vec4
implement vec4_new ( x, y, z, w ) =
	  @{x=x, y=y, z=z, w=w}:vec4

implement vec4_zero () =
	  vec4_new(0.f, 0.f, 0.f, 0.f)

implement vec4_one () =
	  vec4_new(1.f, 1.f, 1.f, 1.f)

implement vec4_red () =
	  vec4_new(1.f, 0.f, 0.f, 1.f)

implement vec4_green () =
	  vec4_new(0.f, 1.f, 0.f, 1.f)

implement vec4_blue () =
	  vec4_new(0.f, 0.f, 1.f, 1.f)

implement vec4_white () =
	  vec4_new(1.f, 1.f, 1.f, 1.f)

implement vec4_black () =
vec4_new(0.f, 0.f, 0.f, 1.f)

implement vec4_grey () =
	  vec4_new(0.5f, 0.5f, 0.5f, 1.f)

implement vec4_light_grey () =
	  vec4_new(0.75f, 0.75f, 0.75f, 1.f)

implement vec4_dark_grey () =
	  vec4_new(0.25f, 0.25f, 0.25f, 1.f)

implement vec4_add ( v1, v2 ) =
	  @{x=(v1.x + v2.x), y=(v1.y + v2.y), z=(v1.z + v2.z), w=(v1.w + v2.w)}:vec4

implement vec4_sub ( v1, v2 ) =
	  @{x=(v1.x - v2.x), y=(v1.y - v2.y), z=(v1.z - v2.z), w=(v1.w - v2.w)}:vec4

implement vec4_div ( v, fac ) =
	  @{x=(v.x / fac), y=(v.y / fac), z=(v.z / fac), w=(v.w / fac)}:vec4

implement vec4_mul ( v, fac ) =
	  @{x=(v.x * fac), y=(v.y * fac), z=(v.z * fac), w=(v.w * fac)}:vec4

implement vec4_mul_vec4 ( v1, v2 ) =
	  @{x=(v1.x * v2.x), y=(v1.y * v2.y), z=(v1.z * v2.z), w=(v1.w * v2.w)}:vec4

implement vec4_pow ( v, exp ) =
	  @{x=$MATH.pow(v.x, exp), y=$MATH.pow(v.y, exp), z=$MATH.pow(v.z, exp), w=$MATH.pow(v.w, exp)}:vec4

implement vec4_neg ( v ) = @{x=(~v.x), y=(~v.y), z=(~v.z), w=(~v.w)}:vec4

implement vec4_abs ( v ) =
	  @{x=abs(v.x), y=abs(v.y), z=abs(v.z), w=abs(v.w)}:vec4

implement vec4_floor ( v ) =
	  @{x=$MATH.floor(v.x), y=$MATH.floor(v.y), z=$MATH.floor(v.z), w=$MATH.floor(v.w)}:vec4

implement vec4_fmod ( v, vl ) =
	  @{x=$MATH.fmod(v.x, vl), y=$MATH.fmod(v.y, vl), z=$MATH.fmod(v.z, vl), w=$MATH.fmod(v.w, vl)}:vec4

implement vec4_sqrt ( v ) =
	  @{x=$MATH.sqrt(v.x), y=$MATH.sqrt(v.y), z=$MATH.sqrt(v.z), w=$MATH.sqrt(v.w)}:vec4

implement vec4_print ( v ) = begin
	  print("vec4 (");
	  print_float(v.x);
	  print(", ");
	  print_float(v.y);
	  print(", ");
	  print_float(v.z);
	  print(", ");
	  print_float(v.w);
	  print(")");
end

implement vec4_dot ( v1, v2 ) =
	  (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z) + (v1.w * v2.w)

implement vec4_length_sqrd ( v ) =
	  (v.x * v.x) + (v.y * v.y) + (v.z * v.z) + (v.w * v.w)

implement vec4_length ( v ) =
	  $MATH.sqrt(vec4_length_sqrd(v))

implement vec4_dist_sqrd ( v1, v2 ) =
	  (v1.x - v2.x) * (v1.x - v2.x) +
	  (v1.y - v2.y) * (v1.y - v2.y) +
	  (v1.z - v2.z) * (v1.z - v2.z) +
	  (v1.w - v2.w) * (v1.w - v2.w);

implement vec4_dist ( v1, v2 ) =
	  $MATH.sqrt(vec4_dist_sqrd(v1, v2))

implement vec4_dist_manhattan ( v1, v2 ) =
	  abs(v1.x - v2.x) + abs(v1.y - v2.y) + abs(v1.z - v2.z) + abs(v1.w - v2.w)

implement vec4_normalize ( v ) = let
	  val len = vec4_length(v)
in
	  if (len = 0.0f) then vec4_zero()
	  else vec4_div(v, len)
end

implement vec4_reflect ( v1, v2 ) =
	  vec4_sub(v1, vec4_mul(v2, 2 * vec4_dot(v1, v2)))

implement vec4_max ( v1, v2 ) =
	  @{x=max(v1.x, v2.x), y=max(v1.y, v2.y), z=max(v1.z, v2.z), w=max(v1.w, v2.w)}:vec4

implement vec4_min ( v1, v2 ) =
	  @{x=min(v1.x, v2.x), y=min(v1.y, v2.y), z=min(v1.z, v2.z), w=min(v1.w, v2.w)}:vec4

implement vec4_equ ( v1, v2 ) =
	  if (not(v1.x = v2.x)) then false
	  else if (not(v1.y = v2.y)) then false
	  else if (not(v1.z = v2.z)) then false
	  else if (not(v1.w = v2.w)) then false
	  else true

implement vec4_to_array ( v, out ) = begin
  out[0] := v.x;
  out[1] := v.y;
  out[2] := v.z;
  out[3] := v.w
end

implement vec4_from_homogeneous ( v ) =
	  vec3_div(vec3_new(v.x, v.y, v.z), v.w)

implement vec4_hash ( v ) =
	  abs( bin_xor(bin_xor(bin_xor(rawcast(v.x), rawcast(v.y)), rawcast(v.z)), rawcast(v.w)) )

implement vec4_saturate ( v ) =
	  @{x=saturate(v.x), y=saturate(v.y), z=saturate(v.z), w=saturate(v.w)}:vec4

implement vec4_lerp ( v1, v2, amount ) =
	  @{x=lerp(v1.x, v2.x, amount), y=lerp(v1.y, v2.y, amount), z=lerp(v1.z, v2.z, amount), w=lerp(v1.w, v2.w, amount)}:vec4

implement vec4_smoothstep ( v1, v2, amount ) = let
	  val scaled_amount = amount * amount * (3 - 2 * amount)
in
	vec4_lerp( v1, v2, scaled_amount )
end

implement vec4_smootherstep ( v1, v2, amount ) = let
	  val scaled_amount = amount * amount * amount * ( amount * ( amount * 6 - 15 ) + 10 )
in
	vec4_lerp(v1, v2, scaled_amount)
end

implement vec4_nearest_interp ( v1, v2, amount ) =
	  @{x=nearest_interp(v1.x, v2.x, amount), y=nearest_interp(v1.y, v2.y, amount), z=nearest_interp(v1.z, v2.z, amount), w=nearest_interp(v1.w, v2.w, amount)}:vec4

implement vec4_binearest_interp ( tl, tr, bl, br, x_amount, y_amount ) =
	  @{x=binearest_interp(tl.x, tr.x, bl.x, br.x, x_amount, y_amount), y=binearest_interp(tl.y, tr.y, bl.y, br.y, x_amount, y_amount), z=binearest_interp(tl.z, tr.z, bl.z, br.z, x_amount, y_amount), w=binearest_interp(tl.w, tr.w, bl.w, br.w, x_amount, y_amount)}:vec4

implement vec4_bilinear_interp ( tl, tr, bl, br, x_amount, y_amount ) =
	  @{x=bilinear_interp(tl.x, tr.x, bl.x, br.x, x_amount, y_amount), y=bilinear_interp(tl.y, tr.y, bl.y, br.y, x_amount, y_amount), z=bilinear_interp(tl.z, tr.z, bl.z, br.z, x_amount, y_amount), w=bilinear_interp(tl.w, tr.w, bl.w, br.w, x_amount, y_amount)}:vec4

implement quat_id () =
	  quat_new(0.f, 0.f, 0.f, 1.f)

implement quat_new ( x, y, z, w ) =
	  @{x=x, y=y, z=z, w=w}:vec4

implement quat_at ( q, i ) = let
  var values = @[float](q.x, q.y, q.z, q.w)
in
  values[i]
end

implement quat_real ( q ) = q.w

implement quat_imaginaries ( q ) =
	  vec3_new(q.x, q.y, q.z)

implement quat_from_euler ( r ) = let
	  val fc1 = $MATH.cos(r.z / 2.0f)
	  val fc2 = $MATH.cos(r.x / 2.0f)
	  val fc3 = $MATH.cos(r.y / 2.0f)
	  val fs1 = $MATH.sin(r.z / 2.0f)
	  val fs2 = $MATH.sin(r.x / 2.0f)
	  val fs3 = $MATH.sin(r.y / 2.0f)
in
	quat_new(
	fc1 * fc2 * fs3 - fs1 * fs2 * fc3,
	fc1 * fs2 * fc3 + fs1 * fc2 * fs3,
	fs1 * fc2 * fc3 - fc1 * fs2 * fs3,
	fc1 * fc2 * fc3 + fs1 * fs2 * fs3
	)
end

implement quat_angle_axis ( angle, axis ) = let
	  val sine = $MATH.sin(angle / 2.0f)
	  val cosine = $MATH.cos(angle / 2.0f)
in
	quat_normalize(quat_new(
	axis.x * sine,
	axis.y * sine,
	axis.z * sine,
	cosine
	))
end

implement quat_rotation_x ( angle ) =
	  quat_angle_axis(angle, vec3_new(1.f,0.f,0.f))

implement quat_rotation_y ( angle ) =
	  quat_angle_axis(angle, vec3_new(0.f,1.f,0.f))

implement quat_rotation_z ( angle ) =
	  quat_angle_axis(angle, vec3_new(0.f,0.f,1.f))

implement quat_to_angle_axis ( pf_ax, pf_an | q, axis, angle ) = let
  val () = !angle := 2.f * $MATH.acos(q.w)
  val divisor = $MATH.sin(!angle / 2.f)
in
  if ( abs(divisor) < $FLOAT.FLT_EPSILON ) then (
    !axis.x := 0.f;
    !axis.y := 1.f;
    !axis.z := 0.f
  ) else (
    !axis.x := q.x / divisor;
    !axis.y := q.y / divisor;
    !axis.z := q.z / divisor;
    !axis := vec3_normalize(!axis)
  )
end

implement quat_to_euler ( q ) = let
	  val sqrx = q.x * q.x
	  val sqry = q.y * q.y
	  val sqrz = q.z * q.z
	  val sqrw = q.w * q.w
in
	vec3_new(
	$MATH.asin(~2.0f * (q.x * q.z - q.y * q.w)),
	$MATH.atan2(~2.0f * (q.y * q.z + q.x * q.w), ((~sqrx) - sqry + sqrz + sqrw)),
	$MATH.atan2(~2.0f * (q.x * q.y + q.z * q.w), (sqrx - sqry - sqrz + sqrw))
	)
end

implement quat_mul_quat ( q1, q2 ) =
	  quat_new(
	  (q1.w * q2.x) + (q1.x * q2.w) + (q1.y * q2.z) - (q1.z * q2.y),
	  (q1.w * q2.y) - (q1.x * q2.z) + (q1.y * q2.w) + (q1.z * q2.x),
	  (q1.w * q2.z) + (q1.x * q2.y) - (q1.y * q2.x) + (q1.z * q2.w),
	  (q1.w * q2.w) - (q1.x * q2.x) - (q1.y * q2.y) - (q1.z * q2.z)
	  )

implement quat_mul_vec3 ( q, v ) = let
	  val work = quat_mul_quat(
	  quat_mul_quat( q, quat_normalize(quat_new(v.x, v.y, v.z, 0.0f)) ),
	  quat_inverse(q)
	  )
	  val res = vec3_new(work.x, work.y, work.z)
in
	vec3_mul(res, vec3_length(v))
end

implement quat_inverse ( q ) = let
	  val scale = quat_length(q)
	  val result = quat_unit_inverse(q)
in
	if ( scale > $FLOAT.FLT_EPSILON ) then
	   @{
	   x=result.x / scale,
	   y=result.y / scale,
	   z=result.z / scale,
	   w=result.w / scale
	   }:quat
	else
		result
end

implement quat_unit_inverse ( q ) =
	  quat_new(~q.x, ~q.y, ~q.z, ~q.w)

implement quat_length ( q ) =
	  $MATH.sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w)

implement quat_normalize ( q ) = let
	  val scale = quat_length(q)
in
	if (scale > $FLOAT.FLT_EPSILON)
	   then quat_new(q.x/scale, q.y/scale, q.z/scale, q.w/scale)
	else
		quat_new(0.f,0.f,0.f,0.f)
end

implement quat_slerp ( from, to, amount ) = let
	  val cosom0 = from.x * to.x + from.y * to.y + from.z * to.z + from.w * to.w
	  val cosom = if (cosom0 < 0.0f) then ~cosom0 else cosom0
	  val omega = $MATH.acos(cosom)
	  val sinom = $MATH.sin(omega)
	  val QUATERNION_DELTA_COS_MIN = 0.01f
	  val afto1 = if (cosom0 < 0.0f) then quat_new(~to.x, ~to.y, ~to.z, ~to.w) else to
	  val scale0 = if ((1.0f - cosom) > QUATERNION_DELTA_COS_MIN)
	      then ($MATH.sin((1.0f - amount) * omega) / sinom)
	      else 1.0f - amount
	  val scale1 = if ((1.0f - cosom) > QUATERNION_DELTA_COS_MIN)
	      then ($MATH.sin(amount * omega) / sinom)
	      else amount
in
	quat_new(
	(scale0 * from.x) + (scale1 * afto1.x),
	(scale0 * from.y) + (scale1 * afto1.y),
	(scale0 * from.z) + (scale1 * afto1.z),
	(scale0 * from.w) + (scale1 * afto1.w)
	)
end

implement quat_dot ( q1, q2 ) =
	  q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w

implement quat_exp ( w ) = let
	  val theta = $MATH.sqrt(vec3_dot(w, w))
	  val len = if (theta < $FLOAT.FLT_EPSILON) then 1.f else $MATH.sin(theta)/theta
	  val v = vec3_mul(w, len)
in
	quat_new(v.x, v.y, v.z, $MATH.cos(theta))
end

implement quat_log ( q ) = let
	  val len0 = vec3_length(quat_imaginaries(q))
	  val angle = $MATH.atan2(len0, q.w)
	  val len = if (len0 > $FLOAT.FLT_EPSILON) then (angle/len0) else 1.f
in
	vec3_mul(quat_imaginaries(q), len)
end

fn quat_get_value ( t: float, axis: vec3 ) : quat =
	  quat_exp( vec3_mul(axis, t / 2.0f) )

implement quat_constrain ( q, axis ) = let
	  val orient = quat_new(0.f, 0.f, 0.f, 1.f)
	  val vs = quat_imaginaries(q)
	  val v0 = quat_imaginaries(orient)
	  val a = q.w * orient.w + vec3_dot(vs, v0)
	  val b = orient.w * vec3_dot(axis, vs) - q.w * vec3_dot(axis, v0) + vec3_dot(vs, vec3_mul_vec3(axis, v0))
	  val alpha = $MATH.atan2(a, b)
	  val t1 = ~2 * alpha + $MATH.M_PI
	  val t2 = ~2 * alpha - $MATH.M_PI
in
	if (quat_dot(q, quat_get_value(t1, axis)) > quat_dot(q, quat_get_value(t2, axis)))
	   then quat_get_value(t1, axis)
	else quat_get_value(t2, axis)
end

implement quat_constrain_y ( q ) =
	  quat_constrain(q, vec3_new(0.f, 1.f, 0.f))

implement quat_distance ( q0, q1 ) = let
	  val comb = quat_mul_quat(quat_inverse(q0), q1)
in
	$MATH.sin(vec3_length(quat_log(comb)))
end

implement quat_neg ( q ) =
	  @{x=(~q.x), y=(~q.y), z=(~q.z), w=(~q.w)}:quat

implement quat_scale ( q, f ) =
	  @{x=q.x * f, y=q.y * f, z=q.z * f, w=q.w * f}:quat

implement quat_interpolate ( qs, ws, count ) = let
	  val ref = quat_id()
	  val ref_inv = quat_inverse(ref)
	  val acc = vec3_zero()
	  fun loop (i:int, acc1: vec3) : vec3 = let
	      val qlog0 = quat_log(quat_mul_quat(ref_inv, qs[i]))
	      val qlog1 = quat_log(quat_mul_quat(ref_inv, quat_neg(qs[i])))
	  in
		if i >= count
		   then acc1
		else
			if (vec3_length(qlog0) < vec3_length(qlog1)) then
			   loop(i-1, vec3_add(acc1, vec3_mul(qlog0, ws[i])))
			else
				loop(i-1, vec3_add(acc1, vec3_mul(qlog1, ws[i])))
	  end
in
	quat_normalize(quat_mul_quat(ref, quat_exp( loop(count, acc) )))
end

implement quat_dual_new ( real, dual ) =
	  @{real=real, dual=dual}:quat_dual

implement quat_dual_id () =
	  quat_dual_new(quat_id(), vec4_zero())

implement quat_dual_transform ( q, t ) =
	  quat_dual_new(
	  q,
	  quat_new(
		0.5f * (t.x * q.w + t.y * q.z - t.z * q.y),
		0.5f * (~t.x * q.z + t.y * q.w + t.z * q.x),
		0.5f * (t.x * q.y - t.y * q.x + t.z * q.w),
		~0.5f * (t.x * q.x + t.y * q.y + t.z * q.z)
	  ))

implement quat_dual_mul ( q0, q1 ) =
	  quat_dual_new(
		quat_mul_quat(q0.real, q1.real),
		vec4_add(
			quat_mul_quat(q0.real, q1.dual),
			quat_mul_quat(q0.dual, q1.real)
		)
	  )

implement quat_dual_normalize ( q ) = let
	  val l = quat_length(q.real)
	  val real = vec4_mul(q.real, 1.0f / l)
	  val dual = vec4_mul(q.dual, 1.0f / l)
in
	quat_dual_new(real, vec4_sub(dual, vec4_mul(real, quat_dot(real, dual))))
end

implement quat_dual_mul_vec3 ( q, v ) = let
	  val rvc = vec3_cross(quat_imaginaries(q.real), v)
	  val real = vec3_cross(quat_imaginaries(q.real), vec3_add(rvc, vec3_mul(v, q.real.w)))
	  val rdc = vec3_cross(quat_imaginaries(q.real), quat_imaginaries(q.dual))
	  val rimg = vec3_mul(quat_imaginaries(q.real), q.dual.w)
	  val dimg = vec3_mul(quat_imaginaries(q.dual), q.real.w)
	  val dual = vec3_sub(rimg, vec3_add(dimg, rdc))
in
	vec3_add(v, vec3_add(vec3_mul(real, 2), vec3_mul(dual, 2)))
end

implement quat_dual_mul_vec3_rot ( q, v ) = let
	  val rvc = vec3_cross(quat_imaginaries(q.real), v)
	  val real = vec3_cross(quat_imaginaries(q.real), vec3_add(rvc, vec3_mul(v. q.real.w)))
in
	vec3_add(v, vec3_mul(real, 2.0f))
end

//  matrix functions
implement mat2_id () =
	  @{xx=1.0f, xy=0.0f, yx=0.0f, yy=1.0f}:mat2

implement mat2_zero () =
	  @{xx=0.0f, xy=0.0f, yx=0.0f, yy=0.0f}:mat2

implement mat2_new ( xx, xy, yx, yy ) =
	  @{xx=xx, xy=xy, yx=yx, yy=yy}:mat2

implement mat2_mul_mat2 ( m1, m2 ) =
	  mat2_new(
	  (m1.xx * m2.xx + m1.xy * m2.yx),
	  (m1.xx * m2.xy + m1.xy * m2.yy),
	  (m1.yx * m2.xx + m1.yy * m2.yx),
	  (m1.yx * m2.xy + m1.yy * m2.yy)
	  )

implement mat2_mul_vec2 ( m, v ) =
	  vec2_new(
	  (v.x * m.xx + v.y * m.xy),
	  (v.x * m.yx + v.y * m.yy)
	  )

implement mat2_transpose ( m ) =
	  mat2_new(
	  (m.xx),
	  (m.yx),
	  (m.xy),
	  (m.yy)
	  )

implement mat2_det ( m ) =
	  m.xx * m.yy - m.xy * m.yx

implement mat2_inverse ( m ) = let
	  val det = mat2_det(m)
	  val fac = 1.0f/det
in
	mat2_new(
	(fac * m.yy),
	(fac * ~m.xy),
	(fac * ~m.yx),
	(fac * m.xx)
	)
end

implement mat2_to_array ( m, out ) = begin
  out[0] := m.xx;
  out[1] := m.xy;
  out[2] := m.yx;
  out[3] := m.yy
end

implement mat2_print ( m ) =
  println!("|", m.xx, " ", m.xy, "|\n",
  "|", m.yx, " ", m.yy, "|")

implement mat2_rotation ( a ) =
	  mat2_new(
	  ($MATH.cos(a)),
	  (~$MATH.sin(a)),
	  ($MATH.sin(a)),
	  ($MATH.cos(a))
	  )

//  matrix 3 by 3
implement mat3_zero (  ) =
	  @{
	  xx=0.0f,
	  xy=0.0f,
	  xz=0.0f,
	  yx=0.0f,
	  yy=0.0f,
	  yz=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=0.0f
	  }:mat3

implement mat3_id (  ) =
	  @{
	  xx=1.0f,
	  xy=0.0f,
	  xz=0.0f,
	  yx=0.0f,
	  yy=1.0f,
	  yz=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=1.0f
	  }:mat3

implement mat3_new
(
xx, xy, xz,
yx, yy, yz,
zx, zy, zz
) =
  @{
  xx=xx,
  xy=xy,
  xz=xz,
  yx=yx,
  yy=yy,
  yz=yz,
  zx=zx,
  zy=zy,
  zz=zz
  }:mat3

implement mat3_mul_mat3 ( m1, m2 ) =
  @{
  xx=(m1.xx * m2.xx) + (m1.xy * m2.yx) + (m1.xz * m2.zx),
  xy=(m1.xx * m2.xy) + (m1.xy * m2.yy) + (m1.xz * m2.zy),
  xz=(m1.xx * m2.xz) + (m1.xy * m2.yz) + (m1.xz * m2.zz),
  yx=(m1.yx * m2.xx) + (m1.yy * m2.yx) + (m1.yz * m2.zx),
  yy=(m1.yx * m2.xy) + (m1.yy * m2.yy) + (m1.yz * m2.zy),
  yz=(m1.yx * m2.xz) + (m1.yy * m2.yz) + (m1.yz * m2.zz),
  zx=(m1.zx * m2.xx) + (m1.zy * m2.yx) + (m1.zz * m2.zx),
  zy=(m1.zx * m2.xy) + (m1.zy * m2.yy) + (m1.zz * m2.zy),
  zz=(m1.zx * m2.xz) + (m1.zy * m2.yz) + (m1.zz * m2.zz)
  }:mat3

implement mat3_mul_vec3 ( m, v ) =
	  @{
	  x= (m.xx * v.x) + (m.xy * v.y) + (m.xz * v.z),
	  y= (m.yx * v.x) + (m.yy * v.y) + (m.yz * v.z),
	  z= (m.zx * v.x) + (m.zy * v.y) + (m.zz * v.z)
	  }:vec3

implement mat3_transpose ( m ) =
	  @{
	  xx= m.xx,
	  xy= m.yx,
	  xz= m.zx,
	  yx= m.xy,
	  yy= m.yy,
	  yz= m.zy,
	  zx= m.xz,
	  zy= m.yz,
	  zz= m.zz
	  }:mat3

implement mat3_det ( m ) =
	  (m.xx * m.yy * m.zz) + (m.xy * m.yz * m.zx) + (m.xz * m.yz * m.zy) -
	  (m.xz * m.yy * m.zx) - (m.xy * m.yx * m.zz) - (m.xx * m.yz * m.zy);

implement mat3_inverse ( m ) = let
	  val det = mat3_det(m)
	  val fac = 1.0f / det
in
	@{
	xx= fac * mat2_det(mat2_new(m.yy, m.yz, m.zy, m.zz)),
	xy= fac * mat2_det(mat2_new(m.xz, m.xy, m.zz, m.zy)),
	xz= fac * mat2_det(mat2_new(m.xy, m.xz, m.yy, m.yz)),
	yx= fac * mat2_det(mat2_new(m.yz, m.yx, m.zz, m.zx)),
	yy= fac * mat2_det(mat2_new(m.xx, m.xz, m.zx, m.zz)),
	yz= fac * mat2_det(mat2_new(m.xz, m.xx, m.yz, m.yx)),
	zx= fac * mat2_det(mat2_new(m.yx, m.yy, m.zx, m.zy)),
	zy= fac * mat2_det(mat2_new(m.xy, m.xx, m.zy, m.zx)),
	zz= fac * mat2_det(mat2_new(m.xx, m.xy, m.yx, m.yy))
	}:mat3
end

implement mat3_to_array ( m, out ) = begin
  out[0] := m.xx;
  out[1] := m.yx;
  out[2] := m.zx;
  out[3] := m.xy;
  out[4] := m.yy;
  out[5] := m.zy;
  out[6] := m.xz;
  out[7] := m.yz;
  out[8] := m.zz
end

implement mat3_print ( m ) = begin
  println!("|", m.xx, " ", m.xy, " ", m.xz, "|\n");
  println!("|", m.yx, " ", m.yy, " ", m.yz, "|\n");
  println!("|", m.zx, " ", m.zy, " ", m.zz, "|\n")
end

implement mat3_rotation_x ( a ) =
	  @{
	  xx=1.0f,
	  xy=0.0f,
	  xz=0.0f,
	  yx=0.0f,
	  yy=$MATH.cos(a),
	  yz=(~$MATH.sin(a)),
	  zx=0.0f,
	  zy=$MATH.sin(a),
	  zz=$MATH.cos(a)
	  }:mat3

implement mat3_scale ( s ) =
	  @{
	  xx=s.x,
	  xy=0.0f,
	  xz=0.0f,
	  yx=0.0f,
	  yy=s.y,
	  yz=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=s.z
	  }:mat3

implement mat3_rotation_y ( a ) =
	  @{
	  xx=$MATH.cos(a),
	  xy=0.0f,
	  xz=$MATH.sin(a),
	  yx=0.0f,
	  yy=1.0f,
	  yz=0.0f,
	  zx=(~$MATH.sin(a)),
	  zy=0.0f,
	  zz=$MATH.cos(a)
	  }:mat3

implement mat3_rotation_z ( a ) =
	  @{
	  xx=$MATH.cos(a),
	  xy=(~$MATH.sin(a)),
	  xz=0.0f,
	  yx=$MATH.sin(a),
	  yy=$MATH.cos(a),
	  yz=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=1.0f
	  }:mat3

implement mat3_rotation_angle_axis ( a, v ) = let
	  val c = $MATH.cos(a)
	  val s = $MATH.sin(a)
	  val nc = 1 - c
in
	@{
	xx=v.x * v.x * nc + c,
	xy=v.x * v.y * nc - v.z * s,
	xz=v.x * v.z * nc + v.y * s,
	yx=v.y * v.x * nc * v.z * s,
	yy=v.y * v.y * nc + c,
	yz=v.y * v.z * nc - v.x * s,
	zx=v.z * v.x * nc - v.y * s,
	zy=v.z * v.y * nc + v.x * s,
	zz=v.z * v.z * nc + c
	}:mat3
end

//  matrix 4 by 4
implement mat4_zero (  ) =
	  @{
	  xx=0.0f,
	  xy=0.0f,
	  xz=0.0f,
	  xw=0.0f,
	  yx=0.0f,
	  yy=0.0f,
	  yz=0.0f,
	  yw=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=0.0f,
	  zw=0.0f,
	  wx=0.0f,
	  wy=0.0f,
	  wz=0.0f,
	  ww=0.0f
	  }:mat4

implement mat4_id (  ) =
	  @{
	  xx=1.0f,
	  xy=0.0f,
	  xz=0.0f,
	  xw=0.0f,
	  yx=0.0f,
	  yy=1.0f,
	  yz=0.0f,
	  yw=0.0f,
	  zx=0.0f,
	  zy=0.0f,
	  zz=1.0f,
	  zw=0.0f,
	  wx=0.0f,
	  wy=0.0f,
	  wz=0.0f,
	  ww=1.0f
	  }:mat4

implement mat4_at ( m, x, y ) = let
  var values = @[float](m.xx, m.xy, m.xz, m.xw, m.yx, m.yy, m.yz, m.yw, m.zx, m.zy, m.zz, m.zw, m.wx, m.wy, m.wz, m.ww)
in
  values[x + (y*4)]
end

implement mat4_set ( m, x, y, v ) = let
  var values = @[float](m.xx, m.xy, m.xz, m.xw, m.yx, m.yy, m.yz, m.yw, m.zx, m.zy, m.zz, m.zw, m.wx, m.wy, m.wz, m.ww)
in
  values[x + (y*4)] := v;
  m
end

implement mat4_new
(
  xx, xy, xz, xw,
  yx, yy, yz, yw,
  zx, zy, zz, zw,
  wx, wy, wz, ww
) = let
  var mat = @{
  xx=xx, xy=xy, xz=xz, xw=xw,
  yx=yx, yy=yy, yz=yz, yw=yw,
  zx=zx, zy=zy, zz=zz, zw=zw,
  wx=wx, wy=wy, wz=wz, ww=ww
  }:mat4
in
  mat
end

implement mat4_transpose ( m ) =
  mat4_new(
  m.xx,
  m.xy,
  m.xz,
  m.xw,
  m.yx,
  m.yy,
  m.yz,
  m.yw,
  m.zx,
  m.zy,
  m.zz,
  m.zw,
  m.wx,
  m.wy,
  m.wz,
  m.ww
  )

implement mat3_to_mat4 ( m ) =
  mat4_new(
    m.xx,
    m.xy,
    m.xz,
    0.f,
    m.yx,
    m.yy,
    m.yz,
    0.f,
    m.zx,
    m.zy,
    m.zz,
    0.f,
    0.f,
    0.f,
    0.f,
    1.f
  )

implement mat4_mul_mat4 ( m1, m2 ) =
  mat4_new(
    (m1.xx * m2.xx) + (m1.xy * m2.yx) + (m1.xz * m2.zx) + (m1.xw * m2.wx),
    (m1.xx * m2.xy) + (m1.xy * m2.yy) + (m1.xz * m2.zy) + (m1.xw * m2.wy),
    (m1.xx * m2.xz) + (m1.xy * m2.yz) + (m1.xz * m2.zz) + (m1.xw * m2.wz),
    (m1.xx * m2.xw) + (m1.xy * m2.yw) + (m1.xz * m2.zw) + (m1.xw * m2.ww),
    (m1.yx * m2.xx) + (m1.yy * m2.yx) + (m1.yz * m2.zx) + (m1.yw * m2.wx),
    (m1.yx * m2.xy) + (m1.yy * m2.yy) + (m1.yz * m2.zy) + (m1.yw * m2.wy),
    (m1.yx * m2.xz) + (m1.yy * m2.yz) + (m1.yz * m2.zz) + (m1.yw * m2.wz),
    (m1.yx * m2.xw) + (m1.yy * m2.yw) + (m1.yz * m2.zw) + (m1.yw * m2.ww),
    (m1.zx * m2.xx) + (m1.zy * m2.yx) + (m1.zz * m2.zx) + (m1.zw * m2.wx),
    (m1.zx * m2.xy) + (m1.zy * m2.yy) + (m1.zz * m2.zy) + (m1.zw * m2.wy),
    (m1.zx * m2.xz) + (m1.zy * m2.yz) + (m1.zz * m2.zz) + (m1.zw * m2.wz),
    (m1.zx * m2.xw) + (m1.zy * m2.yw) + (m1.zz * m2.zw) + (m1.zw * m2.ww),
    (m1.wx * m2.xx) + (m1.wy * m2.yx) + (m1.wz * m2.zx) + (m1.ww * m2.wx),
    (m1.wx * m2.xy) + (m1.wy * m2.yy) + (m1.wz * m2.zy) + (m1.ww * m2.wy),
    (m1.wx * m2.xz) + (m1.wy * m2.yz) + (m1.wz * m2.zz) + (m1.ww * m2.wz),
    (m1.wx * m2.xw) + (m1.wy * m2.yw) + (m1.wz * m2.zw) + (m1.ww * m2.ww)
  )

implement mat4_mul_vec4 ( m, v ) =
  vec4_new(
    (m.xx * v.x) + (m.xy * v.y) + (m.xz * v.z) + (m.xw * v.w),
    (m.yx * v.x) + (m.yy * v.y) + (m.yz * v.z) + (m.yw * v.w),
    (m.zx * v.x) + (m.zy * v.y) + (m.zz * v.z) + (m.zw * v.w),
    (m.wx * v.x) + (m.wy * v.y) + (m.wz * v.z) + (m.ww * v.w)
  )

implement mat4_mul_vec3 ( m, v ) = let
  var v_homo = vec4_new(v.x, v.y, v.z, 1.f)
in
  v_homo := mat4_mul_vec4(m, v_homo);
  v_homo := vec4_div(v_homo, v_homo.w);
  vec3_new(v_homo.x, v_homo.y, v_homo.z)
end

implement mat4_to_mat3 ( m ) =
  mat3_new(
  m.xx,
  m.xy,
  m.xz,
  m.yx,
  m.yy,
  m.yz,
  m.zx,
  m.zy,
  m.zz
  )

implement mat4_to_quat ( m ) = let
  val tr = m.xx + m.yy + m.zz
in
  if tr > 0.f then let
    val s = $MATH.sqrt(tr + 1.f)
    val w = s / 2.f
    val x = ( mat4_at(m, 1, 2) - mat4_at(m, 2, 1) ) * (0.5f / s)
    val y = ( mat4_at(m, 2, 0) - mat4_at(m, 0, 2) ) * (0.5f / s)
    val z = ( mat4_at(m, 0, 1) - mat4_at(m, 1, 0) ) * (0.5f / s)
  in
    quat_new(x, y, z, w)
  end else let
    val nxt = @[int](1, 2, 0)
    var q = @[float][4](0.f)
    var i = 0.f
    var j = 0.f
    var k = 0.f
    var s = 0.f
  in
    i := begin if mat4_at(m, 1, 1) > mat4_at(m, 0, 0) then 1.f else i end;
    i := begin if mat4_at(m, 2, 2) > mat4_at(m, i, i) then 2.f else i end;
    j := nxt[i];
    k := nxt[j];
    s := $MATH.sqrt( (mat4_at(m, i, i) - (mat4_at(m, j, j) mat4_at(m, k, k))) + 1.f );
    q[i] := s * 0.5f;
    s := begin if (s != 0.f) then 0.5f / s else s end;
    q[3] := (mat4_at(m, j, k) - mat4_at(m, k, j)) * s;
    q[j] := (mat4_at(m, i, j) + mat4_at(m, j, i)) * s;
    q[k] := (mat4_at(m, i, k) + mat4_at(m, k, i)) * s;
    quat_new(q[0], q[1], q[2], q[3])
  end
end

implement mat4_to_quat_dual ( m ) = let
  val rotation = mat4_to_quat(m)
  val translation = mat4_mul_vec3(m, vec3_zero())
in
  quat_dual_transform(rotation, translation)
end

implement mat4_det ( m ) = let
  val cofact_xx = mat3_det(mat3_new(m.yy, m.yz, m.yw, m.zy, m.zz, m.zw, m.wy, m.wz, m.ww))
  val cofact_xy = ~(mat3_det(mat3_new(m.yx, m.yz, m.yw, m.zx, m.zz, m.zw, m.wx, m.wz, m.ww)))
  val cofact_xz = mat3_det(mat3_new(m.yx, m.yy, m.yw, m.zx, m.zy, m.zw, m.wx, m.wy, m.ww))
  val cofact_xw = ~(mat3_det(mat3_new(m.yx, m.yy, m.yz, m.zx, m.zy, m.zz, m.wx, m.wy, m.wz)))
in
  (cofact_xx * m.xx) + (cofact_xy * m.xy) + (cofact_xz * m.xz) + (cofact_xw * m.xw)
end

implement mat4_inverse ( m ) = let
  val det = mat4_det(m)
  val fac = 1.f / det
  var ret = mat4_new(
    fac * mat3_det(mat3_new(m.yy, m.yz, m.yw, m.zy, m.zz, m.zw, m.wy, m.wz, m.ww)),
    fac * ~(mat3_det(mat3_new(m.yx, m.yz, m.yw, m.zx, m.zz, m.zw, m.wx, m.wz, m.ww))),
    fac * mat3_det(mat3_new(m.yx, m.yy, m.yw, m.zx, m.zy, m.zw, m.wx, m.wy, m.ww)),
    fac * ~(mat3_det(mat3_new(m.yx, m.yy, m.yz, m.zx, m.zy, m.zz, m.wx, m.wy, m.wz))),
    fac * ~(mat3_det(mat3_new(m.xy, m.xz, m.xw, m.zy, m.zz, m.zw, m.wy, m.wz, m.ww))),
    fac * mat3_det(mat3_new(m.xx, m.xz, m.xw, m.zx, m.zz, m.zw, m.wx, m.wz, m.ww)),
    fac * ~(mat3_det(mat3_new(m.xx, m.xy, m.xw, m.zx, m.zy, m.zw, m.wx, m.wy, m.ww))),
    fac * mat3_det(mat3_new(m.xx, m.xy, m.xz, m.zx, m.zy, m.zz, m.wx, m.wy, m.wz)),
    fac * mat3_det(mat3_new(m.xy, m.xz, m.xw, m.yy, m.yz, m.yw, m.wy, m.wz, m.ww)),
    fac * ~(mat3_det(mat3_new(m.xx, m.xz, m.xw, m.yx, m.yz, m.yw, m.wx, m.wz, m.ww))),
    fac * mat3_det(mat3_new(m.xx, m.xy, m.xw, m.yx, m.yy, m.yw, m.wx, m.wy, m.ww)),
    fac * ~(mat3_det(mat3_new(m.xx, m.xy, m.xz, m.yx, m.yy, m.yz, m.wx, m.wy, m.wz))),
    fac * ~(mat3_det(mat3_new(m.xy, m.xz, m.xw, m.yy, m.yz, m.yw, m.zy, m.zz, m.zw))),
    fac * mat3_det(mat3_new(m.xx, m.xz, m.xw, m.yx, m.yz, m.yw, m.zx, m.zz, m.zw)),
    fac * ~(mat3_det(mat3_new(m.xx, m.xy, m.xw, m.yx, m.yy, m.yw, m.zx, m.zy, m.zw))),
    fac * mat3_det(mat3_new(m.xx, m.xy, m.xz, m.yx, m.yy, m.yz, m.zx, m.zy, m.zz))
  )
in
  ret
end

implement mat4_to_array ( m, out ) = begin
  out[0] := m.xx;
  out[1] := m.yx;
  out[2] := m.zx;
  out[3] := m.wx;
  out[4] := m.xy;
  out[5] := m.yy;
  out[6] := m.zy;
  out[7] := m.wy;
  out[8] := m.xz;
  out[9] := m.yz;
  out[10] := m.zz;
  out[11] := m.wz;
  out[12] := m.xw;
  out[13] := m.yw;
  out[14] := m.zw;
  out[15] := m.ww
end

implement mat4_to_array_trans ( m, out ) = begin
  out[0] := m.xx;
  out[1] := m.xy;
  out[2] := m.xz;
  out[3] := m.xw;
  out[4] := m.yx;
  out[5] := m.yy;
  out[6] := m.yz;
  out[7] := m.yw;
  out[8] := m.zx;
  out[9] := m.zy;
  out[10] := m.zz;
  out[11] := m.zw;
  out[12] := m.wx;
  out[13] := m.wy;
  out[14] := m.wz;
  out[15] := m.ww
end

implement mat4_print ( m ) = begin
  println!("|", m.xx, " ", m.xy, " ", m.xz, " ", m.xw, "|\n");
  println!("|", m.yx, " ", m.yy, " ", m.yz, " ", m.yw, "|\n");
  println!("|", m.zx, " ", m.zy, " ", m.zz, " ", m.zw,  "|\n");
  println!("|", m.wx, " ", m.wy, " ", m.wz, " ", m.ww, "|\n")
end

implement mat4_view_look_at ( position, target, up ) = let
  val zaxis = vec3_normalize(vec3_sub(target, position))
  var xaxis = vec3_normalize(vec3_cross(up, zaxis))
  var yaxis = vec3_cross(zaxis, xaxis)
  var view_matrix = mat4_id()
in
  view_matrix.xx := xaxis.x;
  view_matrix.xy := xaxis.y;
  view_matrix.xz := xaxis.z;
  view_matrix.yx := yaxis.x;
  view_matrix.yy := yaxis.y;
  view_matrix.yz := yaxis.z;
  view_matrix.zx := ~(zaxis.x);
  view_matrix.zy := ~(zaxis.y);
  view_matrix.zz := ~(zaxis.z);
  view_matrix := mat4_mul_mat4(view_matrix, mat4_translation(vec3_neg(position)));
  view_matrix
end

implement mat4_perspective ( fov, near_clip, far_clip, ratio ) = let
  var right = 0.f
  var left = 0.f
  var bottom = 0.f
  var top = 0.f
  var proj_matrix = mat4_zero()
in
  right := ~(near_clip * $MATH.tan(fov));
  left := ~(right);
  top := ratio * near_clip * $MATH.tan(fov);
  bottom := ~(top);
  proj_matrix.xx := (2.f * near_clip) / (right - left);
  proj_matrix.yy := (2.f * near_clip) / (top - bottom);
  proj_matrix.xz := (right * left) / (right - left);
  proj_matrix.yz := (top + bottom) / (top - bottom);
  proj_matrix.zz := (~(far_clip) - near_clip) / (far_clip - near_clip);
  proj_matrix.wz := ~(1.f);
  proj_matrix.zw := (~(2.f * near_clip) * far_clip) / (far_clip - near_clip);
  proj_matrix
end

implement mat4_orthographic ( left, right, bottom, top, clip_near, clip_far ) = let
  var m = mat4_id()
in
  m.xx := 2.f / (right - left);
  m.yy := 2.f / (top - bottom);
  m.zz := 1.f / (clip_near - clip_far);
  m.xw := ~(1.f) - 2.f * left / (right - left);
  m.yw := 1.f + 2.f * top / (bottom - top);
  m.zw := clip_near / (clip_near - clip_far);
  m
end

implement mat4_translation ( v ) = let
  var m = mat4_id()
in
  m.xw := v.x;
  m.yw := v.y;
  m.zw := v.z;
  m
end

implement mat4_scale ( v ) = let
  var m = mat4_id()
in
  m.xx := v.x;
  m.yy := v.y;
  m.zz := v.z;
  m
end

implement mat4_rotation_x ( a ) = let
  var m = mat4_id()
in
  m.yy := $MATH.cos(a);
  m.yz := ~($MATH.sin(a));
  m.zy := $MATH.sin(a);
  m.zz := $MATH.cos(a);
  m
end

implement mat4_rotation_y ( a ) = let
  var m = mat4_id()
in
  m.xx := $MATH.cos(a);
  m.xz := $MATH.sin(a);
  m.zx := ~($MATH.sin(a));
  m.zz := $MATH.cos(a);
  m
end

implement mat4_rotation_z ( a ) = let
  var m = mat4_id()
in
  m.xx := $MATH.cos(a);
  m.xy := ~($MATH.sin(a));
  m.yx := $MATH.sin(a);
  m.yy := $MATH.cos(a);
  m
end

implement mat4_rotation_axis_angle ( v, angle ) = let
  var m = mat4_id()
  val c = $MATH.cos(angle)
  val s = $MATH.sin(angle)
  val nc = 1.f - c
in
  m.xx := v.x * v.x * nc + c;
  m.xy := v.x * v.y * nc - v.z * s;
  m.xz := v.x * v.z * nc + v.y * s;
  m.yx := v.y * v.x * nc + v.z * s;
  m.yy := v.y * v.y * nc + c;
  m.yz := v.y * v.z * nc - v.x * s;
  m.zx := v.z * v.x * nc - v.y * s;
  m.zy := v.z * v.y * nc + v.x * s;
  m.zz := v.z * v.z * nc + c;
  m
end

implement mat4_rotation_euler ( x, y, z ) = let
  val m = mat4_zero()
  val cosx = $MATH.cos(x)
  val cosy = $MATH.cos(y)
  val cosz = $MATH.cos(z)
  val sinx =  $MATH.sin(x)
  val siny =  $MATH.sin(y)
  val sinz =  $MATH.sin(z)
in
  m.xx := cosy * cosz;
  m.yx := ~(cosx) * sinz + sinx * siny * cosz;
  m.zx := sinx * sinz + cosx * siny * cosz;
  m.xy := cosy * sinz;
  m.yy := cosx * cosz + sinx * siny * sinz;
  m.zy := ~(sinx) * cosz + cosx * siny * sinz;
  m.xz := ~(siny);
  m.yz := sinx * cosy;
  m.zz := cosx * cosy;
end

implement mat4_rotation_quat ( q ) = let
  val x2 = q.x + q.x
  val y2 = q.y + q.y
  val z2 = q.z + q.z
  val xx = q.x * x2
  val yy = q.y * y2
  val wx = q.w * x2
  val xy = q.x * y2
  val yz = q.y * z2
  val wy = q.w * y2
  val xz = q.x * z2
  val zz = q.z * z2
  val wz = q.w * z2
in
  mat4_new(
    1.f - (yy + zz),
    xy - wz,
    xz + wy,
    0.f,
    xy + wz,
    1.f - (xx + zz),
    yz - wx,
    0.f,
    xz - wy,
    yz + wx,
    1.f - (xx + yy),
    0.f,
    0.f,
    0.f,
    0.f,
    1.f
  )
end

implement mat4_rotation_quat_dual ( q ) = let
  val rx = q.real.x
  val ry = q.real.y
  val rz = q.real.z
  val rw = q.real.w
  val tx = q.dual.x
  val ty = q.dual.y
  val tz = q.dual.z
  val tw = q.dual.w
  var m = mat4_id()
in
  m.xx := rw * rw + rx * rx - ry * ry - rz * rz;
  m.xy := 2.f * (rx * ry - rw * rz);
  m.xz := 2.f * (rx * rz + rw * ry);
  m.yx := 2.f * (rx * ry + rw * rz);
  m.yy := rw * rw - rx * rx + ry * ry - rz * rz;
  m.yz := 2.f * (ry * rz - rw * rx);
  m.zx := 2.f * (rx * rz - rw * ry);
  m.zy := 2.f * (ry * rz + rw * rx);
  m.zz := rw * rw - rx * rx - ry * ry + rz * rz;
  m.xw := ~(2.f) * tw * rx + 2.f * rw * tx - 2.f * ty * rz + 2.f * ry * tz;
  m.yw := ~(2.f) * tw * ry + 2.f * tx * rz - 2.f * rx * tz + 2.f * rw * ty;
  m.zw := ~(2.f) * tw * rz + 2.f * rx * ty + 2.f * rw * tz - 2.f * tx * ry;
  m
end

implement mat4_world ( position, scale, rotation ) = let
  val pos_m = mat4_translation(position)
  val rot_m = mat4_rotation_quat(rotation)
  val sca_m = mat4_scale(scale)
  var result = mat4_id()
in
  result := mat4_mul_mat4(result, pos_m);
  result := mat4_mul_mat4(result, rot_m);
  result := mat4_mul_mat4(result, sca_m);
  result
end

implement mat4_lerp ( m1, m2, amount ) =
  mat4_new(
    lerp(m1.xx, m2.xx, amount),
    lerp(m1.xy, m2.xy, amount),
    lerp(m1.xz, m2.xz, amount),
    lerp(m1.xw, m2.xw, amount),
    lerp(m1.yx, m2.yx, amount),
    lerp(m1.yy, m2.yy, amount),
    lerp(m1.yz, m2.yz, amount),
    lerp(m1.yw, m2.yw, amount),
    lerp(m1.zx, m2.zx, amount),
    lerp(m1.zy, m2.zy, amount),
    lerp(m1.zz, m2.zz, amount),
    lerp(m1.zw, m2.zw, amount),
    lerp(m1.wx, m2.wx, amount),
    lerp(m1.wy, m2.wy, amount),
    lerp(m1.wz, m2.wz, amount),
    lerp(m1.ww, m2.ww, amount)
  )

implement mat4_smoothstep ( m1, m2, amount ) =
  mat4_new(
    smoothstep(m1.xx, m2.xx, amount),
    smoothstep(m1.xy, m2.xy, amount),
    smoothstep(m1.xz, m2.xz, amount),
    smoothstep(m1.xw, m2.xw, amount),
    smoothstep(m1.yx, m2.yx, amount),
    smoothstep(m1.yy, m2.yy, amount),
    smoothstep(m1.yz, m2.yz, amount),
    smoothstep(m1.yw, m2.yw, amount),
    smoothstep(m1.zx, m2.zx, amount),
    smoothstep(m1.zy, m2.zy, amount),
    smoothstep(m1.zz, m2.zz, amount),
    smoothstep(m1.zw, m2.zw, amount),
    smoothstep(m1.wx, m2.wx, amount),
    smoothstep(m1.wy, m2.wy, amount),
    smoothstep(m1.wz, m2.wz, amount),
    smoothstep(m1.ww, m2.ww, amount)
  )

//  geometry functions
implement plane_new ( position, direction ) = @{position=position, direction=direction}:plane

implement plane_distance ( p, point ) =
  vec3_dot(vec3_sub(point, p.position), p.direction)

implement plane_transform ( p, world, world_normal ) = let
  val () = p.position := mat4_mul_vec3(world, p.position)
  val () = p.direction := mat3_mul_vec3(world_normal, p.direction)
  val () = p.direction := vec3_normalize(p.direction)
in
  p
end

implement plane_transform_space (p, space, space_normal) = let
  val () = p.position := mat3_mul_vec3(space, p.position)
  val () = p.direction := mat3_mul_vec3(space_normal, p.direction)
  val () = p.direction := vec3_normalize(p.direction)
in
  p
end

implement point_inside_plane ( point, p ) = vec3_dot(vec3_sub(point, p.position), p.direction) < 0.f

implement point_outside_plane ( point, p ) = vec3_dot(vec3_sub(point, p.position), p.direction) > 0.f

implement point_intersects_plane ( point, p ) = vec3_dot(vec3_sub(point, p.position), p.direction) == 0.f

implement plane_project ( p, v ) = vec3_sub(v, vec3_mul(p.direction, vec3_dot(v, p.direction)))

implement plane_closest ( p, v ) = vec3_sub(v, vec3_mul(p.direction, plane_distance(p, v)))

implement point_swept_inside_plane ( point, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(point, p.position))
in
  if ~(dist) <= 0.f then false
  else not(between_or(~(dist) / angle, 0.f, 1.f))
end

implement point_swept_outside_plane ( point, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(point, p.position))
in
  if dist <= 0.f then false
  else not(between_or(~(dist) / angle, 0.f, 1.f))
end

implement point_swept_intersects_plane ( point, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(point, p.position))
in
  if dist == 0.f then true
  else between_or(~(dist) / angle, 0.f, 1.f)
end

implement box_new ( x_min, x_max, y_min, y_max, z_min, z_max ) =
  @{
    top=plane_new(vec3_new(0.f, y_max, 0.f), vec3_new(0.f, 1.f, 0.f)),
    bottom=plane_new(vec3_new(0.f, y_min, 0.f), vec3_new(0.f, ~(1.f), 0.f)),
    left=plane_new(vec3_new(x_max, 0.f, 0.f), vec3_new(1.f, 0.f, 0.f)),
    right=plane_new(vec3_new(x_min, 0.f, 0.f), vec3_new(~(1.f), 0.f, 0.f)),
    front=plane_new(vec3_new(0.f, 0.f, z_max), vec3_new(0.f, 0.f, 1.f)),
    back=plane_new(vec3_new(0.f, 0.f, z_min), vec3_new(0.f, 0.f, ~(1.f)))
  }:box

implement box_sphere ( center, radius ) =
  @{
    top=plane_new(vec3_new(0.f, radius, 0.f), vec3_new(0.f, 1.f, 0.f)),
    bottom=plane_new(vec3_new(0.f, ~(radius), 0.f), vec3_new(0.f, ~(1.f), 0.f)),
    left=plane_new(vec3_new(radius, 0.f, 0.f), vec3_new(1.f, 0.f, 0.f)),
    right=plane_new(vec3_new(~(radius), 0.f, 0.f), vec3_new(~(1.f), 0.f, 0.f)),
    front=plane_new(vec3_new(0.f, 0.f, radius), vec3_new(0.f, 0.f, 1.f)),
    back=plane_new(vec3_new(0.f, 0.f, ~(radius)), vec3_new(0.f, 0.f, ~(1.f)))
  }:box

implement box_invert ( b ) = begin
  b.front.direction := vec3_neg(b.front.direction);
  b.back.direction := vec3_neg(b.back.direction);
  b.left.direction := vec3_neg(b.left.direction);
  b.right.direction := vec3_neg(b.right.direction);
  b.top.direction := vec3_neg(b.top.direction);
  b.bottom.direction := vec3_neg(b.bottom.direction);
  b
end

implement box_invert_depth ( b ) = begin
  b.front.direction := vec3_neg(b.front.direction);
  b.back.direction := vec3_neg(b.back.direction);
  b
end

implement box_invert_width ( b ) = begin
  b.left.direction := vec3_neg(b.left.direction);
  b.right.direction := vec3_neg(b.right.direction);
  b
end

implement box_invert_height ( b ) = begin
  b.top.direction := vec3_neg(b.top.direction);
  b.bottom.direction := vec3_neg(b.bottom.direction);
  b
end

implement point_inside_box ( point, b ) =
(
  if not(point_inside_plane(point, b.top)) then false
  else if not(point_inside_plane(point, b.bottom)) then false
  else if not(point_inside_plane(point, b.left)) then false
  else if not(point_inside_plane(point, b.right)) then false
  else if not(point_inside_plane(point, b.front)) then false
  else if not(point_inside_plane(point, b.back)) then false
  else true
)

implement point_outside_box ( point, b ) =
  not(point_intersects_box(point, b)) || point_inside_box(point, b)

implement point_intersects_box ( point, b ) =
  if point_intersects_plane(point, b.top) then true
  else if point_intersects_plane(point, b.bottom) then true
  else if point_intersects_plane(point, b.left) then true
  else if point_intersects_plane(point, b.right) then true
  else if point_intersects_plane(point, b.front) then true
  else if point_intersects_plane(point, b.back) then true
  else false

implement box_merge ( b1, b2 ) = let
  val b1_x_max = b1.left.position.x
  val b1_x_min = b1.right.position.x
  val b1_y_max = b1.top.position.y
  val b1_y_min = b1.bottom.position.y
  val b1_z_max = b1.front.position.z
  val b1_z_min = b1.back.position.z
  val b2_x_max = b2.left.position.x
  val b2_x_min = b2.right.position.x
  val b2_y_max = b2.top.position.y
  val b2_y_min = b2.bottom.position.y
  val b2_z_max = b2.front.position.z
  val b2_z_min = b2.back.position.z
  val x_min = min(b1_x_min, b2_x_min)
  val x_max = max(b1_x_max, b2_x_max)
  val y_min = min(b1_y_min, b2_y_min)
  val y_max = max(b1_y_max, b2_y_max)
  val z_min = min(b1_z_min, b2_z_min)
  val z_max = max(b1_z_max, b2_z_max)
in
  box_new(x_min, x_max, y_min, y_max, z_min, z_max)
end

implement box_transform ( bb, world, world_normal ) =
  box_new(
    plane_transform(bb.top, world, world_normal),
    plane_transform(bb.bottom, world, world_normal),
    plane_transform(bb.left, world, world_normal),
    plane_transform(bb.right, world, world_normal),
    plane_transform(bb.front, world, world_normal),
    plane_transform(bb.back, world, world_normal)
  )

implement frustum_new ( ntr, ntl, nbr, nbl, ftr, ftl, fbr, fbl ) =
  @{
    ntr=ntr,
    ntl=ntl,
    nbr=nbr,
    nbl=nbl,
    ftr=ftr,
    ftl=ftl,
    fbr=fbr,
    fbl=fbl
  }:frustum

implement frustum_new_clipbox (  ) =
  frustum_new(
    vec3_new(1.f, 1.f, ~(1.f)), vec3_new(~1.f, 1.f, ~1.f),
    vec3_new(1.f, ~1.f, ~1.f), vec3_new(~1.f, ~1.f, ~1.f),
    vec3_new(1.f, 1.f, 1.f), vec3_new(~1.f, 1.f, 1.f),
    vec3_new(1.f, ~1.f, 1.f), vec3_new(~1.f, ~1.f, 1.f)
  )

implement frustum_new_camera ( view, proj ) = let
  var f = frustum_new_clipbox()
in
  f := frustum_transform(f, mat4_inverse(proj));
  f := frustum_transform(f, mat4_inverse(view));
  f
end

implement frustum_slice ( f, f_start, f_end ) = let
  var r = @{
  ntr=vec3_add(f.ntr, vec3_mul(vec3_sub(f.ftr, f.ntr), f_start)),
  ftr=vec3_add(f.ntr, vec3_mul(vec3_sub(f.ftr, f.ntr), f_end)),
  ntl=vec3_add(f.ntl, vec3_mul(vec3_sub(f.ftl, f.ntl), f_start)),
  ftl=vec3_add(f.ntl, vec3_mul(vec3_sub(f.ftl, f.ntl), f_end)),
  nbr=vec3_add(f.nbr, vec3_mul(vec3_sub(f.fbr, f.nbr), f_start)),
  fbr=vec3_add(f.nbr, vec3_mul(vec3_sub(f.fbr, f.nbr), f_end)),
  nbl=vec3_add(f.nbl, vec3_mul(vec3_sub(f.fbl, f.nbl), f_start)),
  fbl=vec3_add(f.nbl, vec3_mul(vec3_sub(f.fbl, f.nbl), f_end))
  }:frustum
in
  r
end

implement frustum_center ( f ) = let
  var total = vec3_zero()
in
  total := vec3_add(total, f.ntr);
  total := vec3_add(total, f.ftr);
  total := vec3_add(total, f.ntl);
  total := vec3_add(total, f.ftl);
  total := vec3_add(total, f.nbr);
  total := vec3_add(total, f.fbr);
  total := vec3_add(total, f.nbl);
  total := vec3_add(total, f.fbl);
  vec3_div(total, 8)
end

implement frustum_maximums ( f ) = let
  var r = vec3_zero()
in
  r.x := max(max(max(max(max(max(max(f.ntr.x, f.ftr.x), f.ntl.x), f.ftl.x), f.nbr.x), f.fbr.x), f.nbl.x), f.fbl.x);
  r.y := max(max(max(max(max(max(max(f.ntr.y, f.ftr.y), f.ntl.y), f.ftl.y), f.nbr.y), f.fbr.y), f.nbl.y), f.fbl.y);
  r.z := max(max(max(max(max(max(max(f.ntr.z, f.ftr.z), f.ntl.z), f.ftl.z), f.nbr.z), f.fbr.z), f.nbl.z), f.fbl.z);
  r
end

implement frustum_minimums ( f ) = let
  var r = vec3_zero()
in
  r.x := min(min(min(min(min(min(min(f.ntr.x, f.ftr.x), f.ntl.x), f.ftl.x), f.nbr.x), f.fbr.x), f.nbl.x), f.fbl.x);
  r.y := min(min(min(min(min(min(min(f.ntr.y, f.ftr.y), f.ntl.y), f.ftl.y), f.nbr.y), f.fbr.y), f.nbl.y), f.fbl.y);
  r.z := min(min(min(min(min(min(min(f.ntr.z, f.ftr.z), f.ntl.z), f.ftl.z), f.nbr.z), f.fbr.z), f.nbl.z), f.fbl.z);
  r
end

implement frustum_transform ( f, m ) =
  frustum_new(
    mat4_mul_vec3(m, f.ntr),
    mat4_mul_vec3(m, f.ftr),
    mat4_mul_vec3(m, f.ntl),
    mat4_mul_vec3(m, f.ftl),
    mat4_mul_vec3(m, f.nbr),
    mat4_mul_vec3(m, f.fbr),
    mat4_mul_vec3(m, f.nbl),
    mat4_mul_vec3(m, f.fbl)
  )

implement frustum_translate ( f, v ) =
  frustum_new(
    vec3_add(f.ntr, v),
    vec3_add(f.ftr, v),
    vec3_add(f.ntl, v),
    vec3_add(f.ftl, v),
    vec3_add(f.nbr, v),
    vec3_add(f.fbr, v),
    vec3_add(f.nbl, v),
    vec3_add(f.fbl, v)
  )

implement frustum_box ( f ) =
  box_new(
    plane_new(f.ntr, vec3_normalize(vec3_cross(vec3_sub(f.ftr, f.ntr), vec3_sub(f.ntl, f.ntr)))),
    plane_new(f.nbr, vec3_normalize(vec3_cross(vec3_sub(f.nbl, f.nbr), vec3_sub(f.fbr, f.nbr)))),
    plane_new(f.ntl, vec3_normalize(vec3_cross(vec3_sub(f.ftl, f.ntl), vec3_sub(f.nbl, f.ntl)))),
    plane_new(f.ntr, vec3_normalize(vec3_cross(vec3_sub(f.nbr, f.ntr), vec3_sub(f.ftr, f.ntr)))),
    plane_new(f.ftr, vec3_normalize(vec3_cross(vec3_sub(f.ftl, f.ftr), vec3_sub(f.fbr, f.ftr)))),
    plane_new(f.ntr, vec3_normalize(vec3_cross(vec3_sub(f.nbr, f.ntr), vec3_sub(f.ntl, f.ntr))))
  )

//  this function is unimplemented
implement frustum_outside_box ( f, b ) = false

implement sphere_outside_frustum ( s, f ) =
  sphere_outside_box(s, frustum_box(f))

implement sphere_inside_frustum ( s, f ) =
  sphere_inside_box(s, frustum_box(f))

implement sphere_intersects_frustum ( s, f ) =
  sphere_intersects_box(s, frustum_box(f))

implement sphere_outside_sphere ( s1, s2 ) = let
  val rtot = (s1.radius + s2.radius)
in
  vec3_dist_sqrd(s1.center, s2.center) > rtot * rtot
end

implement sphere_unit () = sphere_new(vec3_zero(), 1.f)

implement sphere_point () = sphere_new(vec3_zero(), 0.f)

implement sphere_new ( center, radius ) =
  @{
    center=center,
    radius=radius
  }:sphere

implement sphere_of_box ( bb ) = let
  val x_max = bb.left.position.x
  val x_min = bb.right.position.x
  val y_max = bb.top.position.y
  val y_min = bb.bottom.position.y
  val z_max = bb.front.position.z
  val z_min = bb.back.position.z
  val center = vec3_new( ((x_min + x_max) / 2.f), ((y_min + y_max) / 2.f), ((z_min + z_max) / 2.f) )
  var radius = 0.f
  var bs = sphere_unit()
in
  radius := max(radius, vec3_dist(center, vec3_new(x_min, y_min, z_min)));
  radius := max(radius, vec3_dist(center, vec3_new(x_max, y_min, z_min)));
  radius := max(radius, vec3_dist(center, vec3_new(x_min, y_max, z_min)));
  radius := max(radius, vec3_dist(center, vec3_new(x_min, y_min, z_max)));
  radius := max(radius, vec3_dist(center, vec3_new(x_min, y_max, z_max)));
  radius := max(radius, vec3_dist(center, vec3_new(x_max, y_max, z_min)));
  radius := max(radius, vec3_dist(center, vec3_new(x_max, y_min, z_max)));
  radius := max(radius, vec3_dist(center, vec3_new(x_max, y_max, z_max)));
  bs.center := center;
  bs.radius := radius;
  bs
end

implement sphere_of_frustum ( f ) = let
  var s: sphere
in
  s.center := frustum_center(f);
  s.radius := 0.f;
  s.radius := max(s.radius, vec3_dist(s.center, f.ntr));
  s.radius := max(s.radius, vec3_dist(s.center, f.ftr));
  s.radius := max(s.radius, vec3_dist(s.center, f.ntl));
  s.radius := max(s.radius, vec3_dist(s.center, f.ftl));
  s.radius := max(s.radius, vec3_dist(s.center, f.nbr));
  s.radius := max(s.radius, vec3_dist(s.center, f.fbr));
  s.radius := max(s.radius, vec3_dist(s.center, f.nbl));
  s.radius := max(s.radius, vec3_dist(s.center, f.fbl));
  s
end

implement sphere_merge ( bs1, bs2 ) = let
  val dir = vec3_sub(bs2.center, bs1.center)
  val dirnorm = vec3_normalize(dir)
  val p0 = vec3_sub(bs1.center, vec3_mul(dirnorm, bs1.radius))
  val p1 = vec3_add(bs2.center, vec3_mul(dirnorm, bs2.radius))
  val center = vec3_div(vec3_add(p0, p1), 2.f)
  val dist = vec3_dist(center, p0)
in
  sphere_new(center, dist)
end

implement sphere_merge_many {n} ( s, count ) = let
  fun loop {i:nat} .<i>. ( s: @[sphere][n], ret: sphere, i: int i ): sphere =
    if (i > 0) then
      loop(s, sphere_merge(ret, s[i]), i-1)
    else
      ret
in
  loop(s, s[0], count-1)
end

implement sphere_inside_box ( s, b ) =
  if not(sphere_inside_plane(s, b.front)) then false
  else if not(sphere_inside_plane(s, b.back)) then false
  else if not(sphere_inside_plane(s, b.top)) then false
  else if not(sphere_inside_plane(s, b.bottom)) then false
  else if not(sphere_inside_plane(s, b.left)) then false
  else if not(sphere_inside_plane(s, b.right)) then false
  else true

implement sphere_outside_box ( s, b ) =
  not(sphere_inside_box(s, b) || sphere_intersects_box(s, b))

implement sphere_intersects_box ( s, b ) = let
  var point: vec3
  var radius = 0.f
  val plane_size_check = lam@(): bool => if (
    plane_distance(b.left, point) <= radius &&
    plane_distance(b.right, point) <= radius &&
    plane_distance(b.front, point) <= radius &&
    plane_distance(b.back, point) <= radius
  ) then true
in
  if sphere_intersects_plane_point(s, b.top, addr@(point), addr@(radius)) then plane_size_check()
  else if sphere_intersects_plane_point(s, b.bottom, addr@(point), addr@(radius)) then plane_size_check()
  else if sphere_intersects_plane_point(s, b.left, addr@(point), addr@(radius)) then plane_size_check()
  else if sphere_intersects_plane_point(s, b.right, addr@(point), addr@(radius)) then plane_size_check()
  else if sphere_intersects_plane_point(s, b.front, addr@(point), addr@(radius)) then plane_size_check()
  else if sphere_intersects_plane_point(s, b.back, addr@(point), addr@(radius)) then plane_size_check()
  else false
end

implement sphere_transform ( s, world ) = let
  val center = mat4_mul_vec3(world, s.center)
  val radius = s.radius * max(max(world.xx, world.yy), world.zz)
in
  sphere_new(center, radius)
end

implement sphere_translate ( s, x ) = begin
  s.center := vec3_add(s.center, x);
  s
end

implement sphere_scale ( s, x ) = begin
  s.radius := s.radius * x;
  s
end

implement sphere_transform_space ( s, space ) = let
  val center = mat3_mul_vec3(space, s.center)
  val radius = s.radius * max(max(space.xx, space.yy), space.zz)
in
  sphere_new(center, radius)
end

implement point_inside_sphere ( s, point ) =
  vec3_dist(s.center, point) < s.radius

implement point_outside_sphere ( s, point ) =
  vec3_dist(s.center, point) > s.radius

implement point_intersects_sphere ( s, point ) =
  vec3_dist(s.center, point) == s.radius

implement line_inside_sphere ( s, l_start, l_end ) =
  point_swept_inside_sphere(s, vec3_sub(l_end, l_start), l_start)

implement line_outside_sphere ( s, l_start, l_end ) =
  point_swept_outside_sphere(s, vec3_sub(l_end, l_start), l_start)

implement line_intersects_sphere ( s, l_start, l_end ) =
  point_swept_intersects_sphere(s, vec3_sub(l_end, l_start), l_start)

implement sphere_inside_plane ( s, p ) =
  ~(plane_distance(p, s.center)) > s.radius

implement sphere_outside_plane ( s, p ) =
  plane_distance(p, s.center) > s.radius

implement sphere_intersects_plane ( s, p ) =
  abs(plane_distance(p, s.center)) <= s.radius

implement sphere_intersects_plane_point {l1,l2} ( pfpnt, pfrds | s, p, point, radius ) = let
  val d = plane_distance(p, s.center)
  val proj = vec3_mul(p.direction, d)
in
  !point := vec3_sub(s.center, proj);
  !radius := $MATH.sqrt(max(s.radius * s.radius - d * d, 0.f));
  abs(d) <= s.radius
end

implement sphere_swept_inside_plane ( s, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(s.center, p.position))
in
  if ~(dist) <= s.radius then false
  else let
    val t0 = (s.radius - dist) / angle
    val t1 = (~(s.radius) - dist) / angle
  in
    not(between_or(t0, 0.f, 1.f)) && not(between_or(t1, 0.f, 1.f))
  end
end

implement sphere_swept_outside_plane ( s, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(s.center, p.position))
in
  if dist <= s.radius then false
  else let
    val t0 = (s.radius - dist) / angle
    val t1 = (~s.radius - dist) / angle
  in
    not(between_or(t0, 0.f, 1.f)) && not(between_or(t1, 0.f, 1.f))
  end
end

implement sphere_swept_intersects_plane ( s, v, p ) = let
  val angle = vec3_dot(p.direction, v)
  val dist = vec3_dot(p.direction, vec3_sub(s.center, p.position))
in
  if abs(dist) <= s.radius then true
  else let
    val t0 = (s.radius - dist) / angle
    val t1 = (~s.radius - dist) / angle
  in
    between_or(t0, 0.f, 1.f) || between_or(t1, 0.f, 1.f)
  end
end

fn quadratic {l1,l2:addr} ( pf1: !float @ l1, pf2: !float @ l2 | a: float, b: float, c: float, t0: ptr l1, t1: ptr l2 ) : bool = let
  val descrim = b*b - 4.f*a*c
in
  if descrim < 0 then false
  else let
    val d = $MATH.sqrt(descrim)
    val q = if (b < 0) then ((~b - d) / 2.f) else ((~b + d) / 2.f)
  in
    !t0 := q / a;
    !t1 := c / q;
    true
  end
end

//  uninplemented
implement point_swept_inside_sphere ( s, v, point ) = false

implement point_swept_outside_sphere ( s, v, point ) = let
  val sdist = vec3_dist_sqrd(point, s.center)
in
  if (sdist <= s.radius * s.radius) then false
  else let
    val o = vec3_sub(point, s.center)
    val A = vec3_dot(v, v)
    val B = 2.f * vec3_dot(v, o)
    val C = vec3_dot(o, o) - (s.radius * s.radius)
    var t0: float
    var t1: float
    var t: float
  in
    if not(quadratic(A, B, C, addr@(t0), addr@(t1))) then true
    else not(between_or(t0, 0.f 1.f)) && not(between_or(t1, 0.f, 1.f))
  end
end

//  unimplemented
implement point_swept_intersects_sphere ( s, v, point ) = false

implement sphere_swept_outside_sphere ( s1, v, s2 ) = let
  val sdist = vec3_dist_sqrd(s1.center, s2.center)
  val rtot = s1.radius + s2.radius
in
  if sdist <= rtot * rtot then false
  else let
    val o = vec3_sub(s1.center, s2.center)
    val A = vec3_dot(v, v)
    val B = 2.f * vec3_dot(v, v)
    val C = vec3_dot(o, o) - (rtot * rtot)
    var t0: float
    var t1: float
    var t: float
  in
    if not(quadratic(A, B, C, addr@(t0), addr@(t1))) then true
    else not(between_or(t0, 0.f, 1.f)) && not(between_or(t1, 0.f, 1.f))
  end
end

//  unimplemented
implement sphere_swept_inside_sphere ( s1, v, s2 ) = false

//  unimplemented
implement sphere_swept_intersects_sphere ( s1, v, s2 ) = false

implement point_inside_triangle ( p, v0, v1, v2 ) = let
  val d0 = vec3_sub(v2, v0)
  val d1 = vec3_sub(v1, v0)
  val d2 = vec3_sub(p, v0)
  val dot00 = vec3_dot(d0, d0)
  val dot01 = vec3_dot(d0, d1)
  val dot02 = vec3_dot(d0, d2)
  val dot11 = vec3_dot(d1, d1)
  val dot12 = vec3_dot(d1, d2)
  val inv_dom = 1.f / (dot00 * dot11 - dot01 * dot01)
  val u = (dot11 * dot02 - dot01 * dot12) * inv_dom
  val v = (dot00 * dot12 - dot01 * dot02) * inv_dom
in
  (u >= 0.f) && (v >= 0.f) && (u + v < 1.f)
end

implement sphere_intersects_face ( s, v0, v1, v2, norm ) =
  if not(sphere_intersects_plane(s, plane_new(v0, norm))) then false
  else let
    val c = plane_closest(plane_new(v0, norm), s.center)
  in
    point_inside_triangle(c, v0, v1, v2)
  end

implement ellipsoid_new ( center, radiuses ) =
  @{center=center, radiuses=radiuses}:ellipsoid

implement ellipsoid_of_sphere ( s ) = let
  val radiuses = vec3_new(s.radius, s.radius, s.radius)
in
  ellipsoid_new(s.center, radiuses)
end

implement ellipsoid_transform ( e, m ) = let
in
  e.center := mat4_mul_vec3(m, e.center);
  e.radiuses := mat3_mul_vec3(mat4_to_mat3(m), e.radiuses);
  e
end

implement ellipsoid_space ( e ) =
  mat3_new(
  1.f/e.radiuses.x, 0.f, 0.f,
  0.f, 1.f/e.radiuses.y, 0.f,
  0.f, 0.f, 1.f/e.radiuses.z
  )

implement ellipsoid_inv_space ( e ) =
  mat3_new(
    e.radiuses.x, 0.f, 0.f,
    0.f, e.radiuses.y, 0.f,
    0.f, 0.f, e.radiuses.z
  )

implement capsule_new ( c_start, c_end, radius ) =
  @{c_start=c_start, c_end=c_end, radius=radius}:capsule

implement capsule_transform ( c, m ) =
  capsule_new(
    mat4_mul_vec3(m, c.c_start),
    mat4_mul_vec3(m, c.c_end),
    c.radius * max(max(m.xx, m.yy), m.zz)
  )

implement capsule_inside_plane ( c, p ) =
  sphere_inside_plane(sphere_new(c.c_start, c.radius), p) && sphere_inside_plane(sphere_new(c.c_end, c.radius), p)

implement capsule_outside_plane ( c, p ) =
  sphere_outside_plane(sphere_new(c.c_start, c.radius), p) && sphere_inside_plane(sphere_new(c.c_end, c.radius), p)

implement capsule_intersects_plane ( c, p ) =
  not(capsule_inside_plane(c, p)) && not(capsule_outside_plane(c, p))

implement vertex_new (  ) = let
  var vert: vertex
in
  vert
end

implement vertex_equal ( v1, v2 ) =
  if not(vec3_equ(v1.position, v2.position)) then false
  else if not(vec3_equ(v1.normal, v2.normal)) then false
  else if not(vec2_equ(v1.uvs, v2.uvs)) then false
  else true

implement vertex_print ( v ) =
(
  println!("V\(Position: "); vec3_print(v.position);
  println!(", Normal: "); vec3_print(v.normal);
  println!(", Tangent: "); vec3_print(v.tangent);
  println!(", Binormal: "); vec3_print(v.binormal);
  println!(", Color: "); vec4_print(v.color);
  println!(", Uvs: "); vec2_print(v.uvs);
  println!(")")
)

implement mesh_print ( pfm | m ) = let
  val verts_from_m = !m.verticies
  val tris_from_m = !m.triangles
  fun vert_print_loop {i:nat} .<i>. ( i: int i ): void =
    if not(i < 0) then begin
      vertex_print(verts_from_m[i]);
      vert_print_loop(i-1)
    end else ()
  fun tri_print_loop {i:nat} .<i>. ( i: int i ): void =
    if not(i < 0) then begin
      println!(tris_from_m[i]);
      tri_print_loop(i-1)
    end else ()
in
  println!("Num Verts: ", !m.num_verts);
  vert_print_loop(!m.num_verts - 1);
  println!("Num Tris: ", !m.num_triangles);
  println!("Triangle Indicies");
  tri_print_loop(!m.num_triangles - 1)
end

//  use malloc_gc & mfree_gc to alloc & dealloc ptrs for mesh_new & mesh_delete (may need to rework mesh type)
implement mesh_new (  ) = let
  var res = ptr_alloc{mesh}()
in
  res.num_verts := 0;
  res.num_triangles := 0;
  res.verticies := array_ptr_alloc<vertex>(1);
  res.triangles := array_ptr_alloc<uint32>(1);
  res
end

implement mesh_delete ( pfm, pfmf | m ) =
(
  array_ptr_free(m.verticies)
  array_ptr_free(m.triangles)
  ptr_free(pfm, pfmf | m)
)

implement mesh_generate_tangents ( m ) =
(
)

implement mesh_generate_normals ( m ) =
(
)

implement mesh_generate_orthagonal_tangents ( m ) =
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

implement model_generate_orthagonal_tangents ( m ) =
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