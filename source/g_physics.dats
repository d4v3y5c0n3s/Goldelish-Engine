(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_physics.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_physics.sats"
staload "./g_engine.sats"
staload "./assets/cmesh.sats"

local

dataprop did_collide ( c: bool ) =
| COL_SUCC(true)
| COL_FAIL(false)

typedef collision_base_type = @{ time=float, point=vec3, norm=vec3 }

assume collision (b) = (
	did_collide(b) | collision_base_type
)

in

implmnt vec3_gravity () = vec3_new(0.f, ~9.81f, 0.f)

implmnt collision_none ( suc ) = let
    val () = suc := false
in
	(COL_FAIL() | @{time=0.f, point=vec3_zero(), norm=vec3_zero()}:collision_base_type)
end

implmnt collision_new ( time, point, norm, suc ) = let
    val () = suc := true
in
	(COL_SUCC() | @{time=time, point=point, norm=norm}:collision_base_type)
end

implmnt collision_merge ( b0, c0, b1, c1, suc ) =
	if b0 then
		if b1 then let
			val t0 = (c0.1).time
			val t1 = (c1.1).time
		in
			if t0 <= t1 then (suc := b0; c0)
			else (suc := b1; c1)
		end
		else (suc := b0; c0)
	else
		if b1 then (suc := b1; c1)
		else collision_none(suc)

implmnt point_collide_point ( p, v, p0, suc ) = let
	val o = vec3_sub(p, p0)
	val A = vec3_dot(v, v)
	val B = 2.f * vec3_dot(v, o)
	val C = vec3_dot(o, o)
	var t0: float
	var t1: float
in
	if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
	else
		if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then (
			collision_new(min(t0, t1), p, vec3_normalize(vec3_sub(p, p0)), suc)
		) else if between_or(t0, 0.f, 1.f) then (
			collision_new(t0, p, vec3_normalize(vec3_sub(p, p0)), suc)
		) else if between_or(t1, 0.f, 1.f) then (
			collision_new(t1, p, vec3_normalize(vec3_sub(p, p0)), suc)
		) else collision_none(suc)
end

implmnt point_collide_sphere ( p, v, s, suc ) = let
	val o = vec3_sub(p, s.center)
	val A = vec3_dot(v, v)
	val B = 2.f * vec3_dot(v, o)
	val C = vec3_dot(o, o) - (s.radius * s.radius)
	var t0: float
	var t1: float
in
	if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
	else
		if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then (
			collision_new(min(t0, t1), p, vec3_normalize(vec3_sub(p, s.center)), suc)
		) else if between_or(t0, 0.f, 1.f) then (
			collision_new(t0, p, vec3_normalize(vec3_sub(p, s.center)), suc)
		) else if between_or(t1, 0.f, 1.f) then (
			collision_new(t1, p, vec3_normalize(vec3_sub(p, s.center)), suc)
		) else collision_none(suc)
end

implmnt point_collide_ellipsoid ( p, v, e, suc ) = let
	val p0 = vec3_sub(p, e.center)
	val p1 = vec3_div_vec3(p0, e.radiuses)
	val v0 = vec3_div_vec3(v, e.radiuses)
	var b0
	var c = point_collide_sphere(p1, v0, sphere_unit(), b0)
in
	c.1.norm := vec3_normalize(vec3_div_vec3((c.1).norm, e.radiuses));
	c.1.point := vec3_mul_vec3((c.1).point, e.radiuses);
	c.1.point := vec3_add((c.1).point, e.center);
	suc := b0;
	c
end

implmnt point_collide_edge ( p, v, e0, e1, suc ) = let
	val x0 = vec3_sub(e0, p)
	val x1 = vec3_sub(e1, p)
	val d = vec3_sub(x1, x0)
	val dlen = vec3_length_sqrd(d)
	val vlen = vec3_length_sqrd(v)
	val xlen = vec3_length_sqrd(x0)
	val A = dlen * ~vlen + vec3_dot(d, v) * vec3_dot(d, v)
	val B = dlen * 2.f * vec3_dot(v, x0) - 2.f * vec3_dot(d, v) * vec3_dot(d, x0)
	val C = dlen * ~xlen + vec3_dot(d, x0) * vec3_dot(d, x0)
	var t0: float
	var t1: float

	fn finalize ( t: float, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc) = let
        val range = (vec3_dot(d, v) * t - vec3_dot(d, x0)) / dlen
	in
        if ~between_or(range, 0.f, 1.f) then collision_none(suc)
        else let
            val spoint = vec3_add(e0, vec3_mul(d, range))
        in
            collision_new(t, spoint, vec3_normalize(vec3_sub(p, spoint)), suc)
        end
	end
in
	if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
	else
		if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then finalize(min(t0, t1), suc)
		else if between_or(t0, 0.f, 1.f) then finalize(t0, suc)
		else if between_or(t1, 0.f, 1.f) then finalize(t1, suc)
		else collision_none(suc)
end

implmnt point_collide_face ( p, v, ct, suc ) = let
    val angle = vec3_dot(ct.norm, v)
    val dist = vec3_dot(ct.norm, vec3_sub(p, ct.a))
    val t0 = ~dist / angle
    val t1 = ~dist / angle
    
    fn finalize ( t: float, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc) = let
        val cpoint = vec3_add(p, vec3_mul(v, t))
    in
        if ~point_inside_triangle(cpoint, ct.a, ct.b, ct.c) then collision_none(suc)
        else collision_new(t, cpoint, ct.norm, suc)
    end
in
    if between_or(t0, 0.f, 1.f) &&  between_or(t1, 0.f, 1.f) then finalize(min(t0, t1), suc)
    else if between_or(t0, 0.f, 1.f) then finalize(t0, suc)
    else if between_or(t1, 0.f, 1.f) then finalize(t1, suc)
    else collision_none(suc)
end

implmnt point_collide_ctri ( p, v, ct, suc ) =
    if ~point_swept_intersects_plane(p, v, plane_new(ct.a, ct.norm)) then collision_none(suc)
    else let
        var suc2
        val col = point_collide_face(p, v, ct, suc2)
    in
        if suc2 then (suc := suc2; col)
        else let
            var new_suc
            val new_c = point_collide_edge(p, v, ct.a, ct.b, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
            val new_c = point_collide_edge(p, v, ct.b, ct.c, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
            val new_c = point_collide_edge(p, v, ct.c, ct.a, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
            val new_c = point_collide_point(p, v, ct.a, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
            val new_c = point_collide_point(p, v, ct.b, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
            val new_c = point_collide_point(p, v, ct.c, new_suc)
            val col = collision_merge(suc2, col, new_suc, new_c, suc2)
        in
            (suc := suc2; col)
        end
    end


fun point_collide_mesh_space
(
    p: vec3, v: vec3, cm: !cmesh, world: mat4, world_normal: mat3,
    space: mat3, space_normal: mat3, suc: &bool? >> bool sc
) : #[sc:bool] collision(sc) =
  case+ cm of
  | CMESH_BRANCH(dv, _, _) => let
    var div1 = dv
    var div2 = plane_transform(div1, world, world_normal)
    var div3 = plane_transform_space(div2, space, space_normal)
    var bl: bool
  in
    if point_swept_inside_plane(p, v, div3) then let
      val-CMESH_BRANCH(_, _, back_cm) = cm
    in
      point_collide_mesh_space(p, v, back_cm, world, world_normal, space, space_normal, suc)
    end else if point_swept_outside_plane(p, v, div3) then let
      val-CMESH_BRANCH(_, front_cm, _) = cm
    in
      point_collide_mesh_space(p, v, front_cm, world, world_normal, space, space_normal, suc)
    end else let
      val-CMESH_BRANCH(_, front_cm, back_cm) = cm
      var b0: bool
      val c0 = point_collide_mesh_space(p, v, back_cm, world, world_normal, space, space_normal, b0)
      var b1: bool
      val c1 = point_collide_mesh_space(p, v, front_cm, world, world_normal, space, space_normal, b1)
    in
      collision_merge(b0, c0, b1, c1, suc)
    end
  end
  | CMESH_LEAF_EMPTY(_) => let
    var bl: bool
    val ret = collision_none(bl)
  in
    suc := bl;
    ret
  end
  | CMESH_LEAF(lf_arr, lf_sz, _) => let
    var bl: bool
    fun loop {i,j:nat}{ci:bool} (
      arr_in: !arrayptr(ctri, j), j: int j, i: int i,
      c: collision(ci), b: &bool ci >> bool sc
    ): #[sc:bool] collision(sc) =
      if i < j then let
        val ci = arr_in[i]
        val ci = ctri_transform(ci, world, world_normal)
        val ci = ctri_transform_space(ci, space, space_normal)
        var pc_b: bool
        val pc = point_collide_ctri(p, v, ci, pc_b)
        var ret_b: bool
        val ret_c = collision_merge(b, c, pc_b, pc, ret_b)
      in
        b := ret_b;
        loop(arr_in, j, i+1, ret_c, b)
      end else c
    val ret = collision_none(bl)
    val ret = loop(lf_arr, lf_sz, 0, ret, bl)
  in
    suc := bl;
    ret
  end

implmnt point_collide_mesh ( p, v, m, world, world_normal, suc ) = point_collide_mesh_space(p, v, m, world, world_normal, mat3_id(), mat3_id(), suc)

implmnt sphere_collide_face ( s, v, ct, suc ) = let
  val angle = vec3_dot(ct.norm, v)
  val dist = vec3_dot(ct.norm, vec3_sub(s.center, ct.a))
  val t0 = (s.radius - dist) / angle
  val t1 = (~s.radius - dist) / angle
  
  fn finalize ( t: float, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc) = let
    val cpoint = vec3_add(s.center, vec3_mul(v, t))
    val spoint = vec3_add(cpoint, vec3_mul(ct.norm, ~s.radius))
  in
    if ~point_inside_triangle(spoint, ct.a, ct.b, ct.c) then collision_none(suc)
    else collision_new(t, spoint, ct.norm, suc)
  end
in
  if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then finalize(min(t0, t1), suc)
  else if between_or(t0, 0.f, 1.f) then finalize(t0, suc)
  else if between_or(t1, 0.f, 1.f) then finalize(t1, suc)
  else collision_none(suc)
end

implmnt sphere_collide_edge ( s, v, e0, e1, suc ) = let
  val x0 = vec3_sub(e0, s.center)
  val x1 = vec3_sub(e1, s.center)
  val d = vec3_sub(x1, x0)
  val dlen = vec3_length_sqrd(d)
  val vlen = vec3_length_sqrd(v)
  val xlen = vec3_length_sqrd(x0)
  val A = dlen * ~vlen + vec3_dot(d, v) * vec3_dot(d, v)
  val B = dlen * 2.f * vec3_dot(v, x0) - 2.f * vec3_dot(d, v) * vec3_dot(d, x0)
  val C = dlen * (s.radius * s.radius - xlen) + vec3_dot(d, x0) * vec3_dot(d, x0)
  var t0: float
  var t1: float
  
  fn finalize ( t: float, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc) = let
    val range = (vec3_dot(d, v) * t - vec3_dot(d, x0)) / dlen
  in
    if ~between_or(range, 0.f, 1.f) then collision_none(suc)
    else let
      val spoint = vec3_add(e0, vec3_mul(d, range))
    in
      collision_new(t, spoint, vec3_normalize(vec3_sub(s.center, spoint)), suc)
    end
  end
in
  if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
  else if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then finalize(min(t0, t1), suc)
  else if between_or(t0, 0.f, 1.f) then finalize(t0, suc)
  else if between_or(t1, 0.f, 1.f) then finalize(t1, suc)
  else collision_none(suc)
end

implmnt sphere_collide_point ( s, v, p, suc ) = let
  val o = vec3_sub(s.center, p)
  val A = vec3_dot(v, v)
  val B = 2.f * vec3_dot(v, o)
  val C = vec3_dot(o, o) - (s.radius * s.radius)
  var t0: float
  var t1: float
in
  if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
  else if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then collision_new(min(t0, t1), p, vec3_normalize(vec3_sub(s.center, p)), suc)
  else if between_or(t0, 0.f, 1.f) then collision_new(t0, p, vec3_normalize(vec3_sub(s.center, p)), suc)
  else if between_or(t1, 0.f, 1.f) then collision_new(t1, p, vec3_normalize(vec3_sub(s.center, p)), suc)
  else collision_none(suc)
end

implmnt sphere_collide_sphere ( s, v, s0, suc ) = let
  val o = vec3_sub(s.center, s0.center)
  val A = vec3_dot(v, v)
  val B = 2.f * vec3_dot(v, o)
  val C = vec3_dot(o, o) - ((s.radius + s0.radius) * (s.radius + s0.radius))
  var t0: float
  var t1: float
  
  fn finalize ( t: float, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc) = let
    val proj = vec3_add(s.center, vec3_mul(v, t))
    val twrd = vec3_normalize(vec3_sub(s0.center, proj))
    val p = vec3_add(proj, vec3_mul(twrd, s.radius))
  in
    collision_new(t, p, vec3_normalize(vec3_sub(s.center, p)), suc)
  end
in
  if ~quadratic(A, B, C, t0, t1) then collision_none(suc)
  else if between_or(t0, 0.f, 1.f) && between_or(t1, 0.f, 1.f) then finalize(min(t0, t1), suc)
  else if between_or(t0, 0.f, 1.f) then finalize(t0, suc)
  else if between_or(t1, 0.f, 1.f) then finalize(t1, suc)
  else collision_none(suc)
end

implmnt sphere_collide_ctri ( s, v, ct, suc ) =
  if ~sphere_swept_intersects_plane(s, v, plane_new(ct.a, ct.norm)) then collision_none(suc)
  else let
    var col_b: bool
    val col = sphere_collide_face(s, v, ct, col_b)
  in
    if col_b then (suc := col_b; col)
    else let
      var tmp_col_b: bool
      val tmp_col = sphere_collide_edge(s, v, ct.a, ct.b, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
      val tmp_col = sphere_collide_edge(s, v, ct.b, ct.c, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
      val tmp_col = sphere_collide_edge(s, v, ct.c, ct.a, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
      val tmp_col = sphere_collide_point(s, v, ct.a, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
      val tmp_col = sphere_collide_point(s, v, ct.b, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
      val tmp_col = sphere_collide_point(s, v, ct.c, tmp_col_b)
      val col = collision_merge(col_b, col, tmp_col_b, tmp_col, col_b)
    in
      suc := col_b;
      col
    end
  end

implmnt ellipsoid_collide_point ( e, v, p, suc ) = let
  val p = vec3_sub(p, e.center)
  val p = vec3_div_vec3(p, e.radiuses)
  val v = vec3_div_vec3(v, e.radiuses)
  val c = sphere_collide_point(sphere_unit(), v, p, suc)
  val c_vals = c.1
  val c_norm = c_vals.norm
  val c_norm = vec3_normalize(vec3_div_vec3(c_norm, e.radiuses))
  val c_point = c_vals.point
  val c_point = vec3_mul_vec3(c_point, e.radiuses)
  val c_point = vec3_add(c_point, e.center)
in
  collision_new(c_vals.time, c_point, c_norm, suc)
end

fun sphere_collide_mesh_space (
  s: sphere, v: vec3, cm: !cmesh, world: mat4, world_normal: mat3,
    space: mat3, space_normal: mat3, suc: &bool? >> bool sc
) : #[sc:bool] collision(sc) =
  case+ cm of
  | CMESH_BRANCH(dv, _, _) => let
    var div1 = dv
    var div2 = plane_transform(div1, world, world_normal)
    var div3 = plane_transform_space(div2, space, space_normal)
    var bl: bool
  in
    if sphere_swept_inside_plane(s, v, div3) then let
      val-CMESH_BRANCH(_, _, back_cm) = cm
    in
      sphere_collide_mesh_space(s, v, back_cm, world, world_normal, space, space_normal, suc)
    end else if sphere_swept_outside_plane(s, v, div3) then let
      val-CMESH_BRANCH(_, front_cm, _) = cm
    in
      sphere_collide_mesh_space(s, v, front_cm, world, world_normal, space, space_normal, suc)
    end else let
      val-CMESH_BRANCH(_, front_cm, back_cm) = cm
      var b0: bool
      val c0 = sphere_collide_mesh_space(s, v, back_cm, world, world_normal, space, space_normal, b0)
      var b1: bool
      val c1 = sphere_collide_mesh_space(s, v, front_cm, world, world_normal, space, space_normal, b1)
    in
      collision_merge(b0, c0, b1, c1, suc)
    end
  end
  | CMESH_LEAF_EMPTY(_) => let
    var bl: bool
    val ret = collision_none(bl)
  in
    suc := bl;
    ret
  end
  | CMESH_LEAF(lf_arr, lf_sz, _) => let
    var bl: bool
    fun loop {i,j:nat}{ci:bool} (
      arr_in: !arrayptr(ctri, j), j: int j, i: int i,
      c: collision(ci), b: &bool ci >> bool sc
    ): #[sc:bool] collision(sc) =
      if i < j then let
        val ci = arr_in[i]
        val ci = ctri_transform(ci, world, world_normal)
        val ci = ctri_transform_space(ci, space, space_normal)
        var sc_b: bool
        val sc = sphere_collide_ctri(s, v, ci, sc_b)
        var ret_b: bool
        val ret_c = collision_merge(b, c, sc_b, sc, ret_b)
      in
        b := ret_b;
        loop(arr_in, j, i+1, ret_c, b)
      end else c
    val ret = collision_none(bl)
    val ret = loop(lf_arr, lf_sz, 0, ret, bl)
  in
    suc := bl;
    ret
  end

implmnt sphere_collide_mesh ( s, v, m, world, world_normal, suc ) =
  sphere_collide_mesh_space(s, v, m, world, world_normal, mat3_id(), mat3_id(), suc)

implmnt ellipsoid_collide_mesh ( e, v, m, world, world_normal, suc ) = let
  var world_tmp = world
  val () = world_tmp.xw := world_tmp.xw - e.center.x
  val () = world_tmp.yw := world_tmp.yw - e.center.y
  val () = world_tmp.zw := world_tmp.zw - e.center.z
  val space = mat3_scale(vec3_div_vec3(vec3_one(), e.radiuses))
  val space_inv = mat3_scale(e.radiuses)
  val v_tmp = mat3_mul_vec3(space, v)
  val c = sphere_collide_mesh_space(sphere_unit(), v_tmp, m, world, world_normal, space, mat3_transpose(space_inv), suc)
  val c_vals = c.1
  val c_point = mat3_mul_vec3(space_inv, c_vals.point)
  val c_point = vec3_add(c_point, e.center)
  val c_point = vec3_normalize(mat3_mul_vec3(space, c_vals.norm))
in
  collision_new(c_vals.time, c_point, c_vals.norm, suc)
end

implmnt {t1,t2} collision_response_slide ( position, velocity, t1, t2 ) = let
  fun loop {c:bool}{i:nat} (
  c: collision(c), c_b: bool c,
  thing1: !t1, thing2: !t2,
  p: &vec3, v: &vec3, i: int i
  ): void = let
    val c_vals = c.1
    val () = v := vec3_mul(v, 1.1f)
    val () = v := vec3_reflect(v, c_vals.norm)
    val () = p := vec3_add(p, v)
    var col_b: bool
    val col = collision$collide<t1,t2>(thing1, thing2, p, v, col_b)
  in
    if i = 100 || ~col_b then p := vec3_add(p, v)
    else loop(col, col_b, thing1, thing2, p, v, i+1)
  end
  var init_cb: bool
  val init_c = collision$collide<t1,t2>(t1, t2, position, velocity, init_cb)
in
  loop(init_c, init_cb, t1, t2, position, velocity, 0)
end

implmnt {t1,t2} collision_response_slide_fun ( position, velocity, t1, t2, f ) = let
  implement collision$collide<t1,t2>(c1,c2,pos,vel,suc) = f(c1,c2,pos,vel,suc)
in
  collision_response_slide<t1,t2>(position, velocity, t1, t2)
end

end
