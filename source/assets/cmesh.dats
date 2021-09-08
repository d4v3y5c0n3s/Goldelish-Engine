(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  cmesh.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./cmesh.sats"
staload "./../data/vertex_list.sats"
staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../SDL2/SDL_local.sats"

local

in

fn ctri_bound ( t: ctri ): sphere = let
    val center = vec3_div(vec3_add(vec3_add(t.a, t.b), t.c), 3.f)
    val radius = 0.f
    val radius = max(radius, vec3_dist_sqrd(t.a, center))
    val radius = max(radius, vec3_dist_sqrd(t.b, center))
    val radius = max(radius, vec3_dist_sqrd(t.c, center))
in
    sphere_new(center, $MATH.sqrt(radius))
end

implement ctri_new ( a, b, c, norm ) = let
    var t = @{a=a, b=b, c=c, norm=norm, bound=sphere_unit()}:ctri
    val () = t.bound := ctri_bound(t)
in
    t
end

implement ctri_inside_plane ( t, p ) = point_inside_plane(t.a, p) && point_inside_plane(t.b, p) && point_inside_plane(t.c, p)

implement ctri_outside_plane ( t, p ) = point_outside_plane(t.a, p) && point_outside_plane(t.b, p) && point_outside_plane(t.c, p)

implement ctri_intersects_plane ( t, p ) = ~ctri_inside_plane(t, p) && ~ctri_outside_plane(t, p)

implement ctri_transform ( t, m, mn ) = let
    var t2 = t
    val () = t2.a := mat4_mul_vec3(m, t2.a)
    val () = t2.b := mat4_mul_vec3(m, t2.b)
    val () = t2.c := mat4_mul_vec3(m, t2.c)
    val () = t2.norm := vec3_normalize(mat3_mul_vec3(mn, t2.norm))
    val () = t2.bound := ctri_bound(t2)
in
    t2
end

implement ctri_transform_space ( t, s, sn ) = let
    var t2 = t
    val () = t2.a := mat3_mul_vec3(s, t2.a)
    val () = t2.b := mat3_mul_vec3(s, t2.b)
    val () = t2.c := mat3_mul_vec3(s, t2.c)
    val () = t2.norm := vec3_normalize(mat3_mul_vec3(sn, t2.norm))
    val () = t2.bound := ctri_bound(t2)
in
    t2
end

implement{cmesh} asset_delete( cm ) = cmesh_delete($UNSAFE.castvwtp0(cm))

implement cmesh_delete ( cm ) =
    case+ cm of
    | ~CMESH_BRANCH(_, cm1, cm2) => (cmesh_delete(cm1); cmesh_delete(cm2))
    | ~CMESH_LEAF_EMPTY(_) => ()
    | ~CMESH_LEAF(arr, n, _) => arrayptr_free(arr)

fn cmesh_center ( cm: !cmesh ): vec3 =
    case+ cm of
    | CMESH_LEAF(arr, n, _) =>
        if n = 0 then vec3_zero()
        else let
        fun loop {i:nat}{j:nat | i <= j} ( a: !arrayptr(ctri, j), center: vec3, j: int j, i: int i ): vec3 =
            if i < j then let
                val c: ctri = a[i]
                val center = vec3_add(center, c.a)
                val center = vec3_add(center, c.b)
                val center = vec3_add(center, c.c)
            in
                loop(a, center, j, i+1)
            end else vec3_div(center, n*3.f)
        in
            loop(arr, vec3_zero(), n, 0)
        end
    | _ => vec3_zero()

fn cmesh_radius ( cm: !cmesh ): float =
    case+ cm of
    | CMESH_LEAF(arr, n, _) =>
        if n = 0 then 0.f
        else let
        fun loop {i:nat}{j:nat | i <= j} ( a: !arrayptr(ctri, j), center: vec3, radius: float, j: int j, i: int i ): float =
            if i < j then let
                val c: ctri = a[i]
                val radius = max(radius, vec3_dist(center, c.a))
                val radius = max(radius, vec3_dist(center, c.b))
                val radius = max(radius, vec3_dist(center, c.c))
            in
                loop(a, center, radius, j, i+1)
            end else radius
        in
            loop(arr, cmesh_center(cm), 0.f, n, 0)
        end
    | _ => 0.f

fn cmesh_box ( cm: !cmesh ): box =
    case+ cm of
    | CMESH_LEAF(arr, n, _) =>
        if n = 0 then box_new(0.f, 0.f, 0.f, 0.f, 0.f, 0.f)
        else let
        fun loop {i:nat}{j:nat | i <= j}
        ( a: !arrayptr(ctri, j),
        xyz: ((float, float), (float, float), (float, float)),
        j: int j, i: int i ): box =
            if i < j then let
                val c: ctri = a[i]
                var xyz = xyz
                val () = xyz.0.0 := min(xyz.0.0, c.a.x)
                val () = xyz.0.1 := max(xyz.0.1, c.a.x)
                val () = xyz.1.0 := min(xyz.1.0, c.a.y)
                val () = xyz.1.1 := max(xyz.1.1, c.a.y)
                val () = xyz.2.0 := min(xyz.2.0, c.a.z)
                val () = xyz.2.1 := max(xyz.2.1, c.a.z)
                //
                val () = xyz.0.0 := min(xyz.0.0, c.b.x)
                val () = xyz.0.1 := max(xyz.0.1, c.b.x)
                val () = xyz.1.0 := min(xyz.1.0, c.b.y)
                val () = xyz.1.1 := max(xyz.1.1, c.b.y)
                val () = xyz.2.0 := min(xyz.2.0, c.b.z)
                val () = xyz.2.1 := max(xyz.2.1, c.b.z)
                //
                val () = xyz.0.0 := min(xyz.0.0, c.c.x)
                val () = xyz.0.1 := max(xyz.0.1, c.c.x)
                val () = xyz.1.0 := min(xyz.1.0, c.c.y)
                val () = xyz.1.1 := max(xyz.1.1, c.c.y)
                val () = xyz.2.0 := min(xyz.2.0, c.c.z)
                val () = xyz.2.1 := max(xyz.2.1, c.c.z)
            in
                loop(a, xyz, j, i+1)
            end else box_new(xyz.0.0, xyz.0.1, xyz.1.0, xyz.1.1, xyz.2.0, xyz.2.1)
        in
            loop(arr, ((0.f, 0.f), (0.f, 0.f), (0.f, 0.f)), n, 0)
        end
    | _ => box_new(0.f, 0.f, 0.f, 0.f, 0.f, 0.f)

fn cmesh_division ( cm: !cmesh ): plane = let
    val bb = cmesh_box(cm)
    val x_diff = bb.left.position.x - bb.right.position.x
    val y_diff = bb.top.position.y - bb.bottom.position.y
    val z_diff = bb.front.position.z - bb.back.position.z
in
    if x_diff >= y_diff && x_diff >= z_diff then plane_new(cmesh_center(cm), vec3_new(1.f, 0.f, 0.f))
    else if y_diff >= x_diff && y_diff >= z_diff then plane_new(cmesh_center(cm), vec3_new(0.f, 1.f, 0.f))
    else if z_diff >= x_diff && z_diff >= y_diff then plane_new(cmesh_center(cm), vec3_new(0.f, 0.f, 1.f))
    else plane_new(cmesh_center(cm), vec3_new(1.f, 0.f, 0.f))
end

implement cmesh_bound ( cm ) =
    case+ cm of
    | CMESH_LEAF(_, _, _) => sphere_new(cmesh_center(cm), cmesh_radius(cm))
    | _ => sphere_new(vec3_zero(), 0.f)

implement cmesh_subdivide ( cm, iterations ) =
if iterations > 0 then let
  val division = cmesh_division(cm)
in
    case+ cm of
    | @CMESH_LEAF(arr, n, _) =>
      if n < 10 then fold@(cm)
      else let
        dataprop FBT_IN (int, a:addr) =
        | FBT_NIL(0, a)
        | {n:nat} FBT_CONS(n+1, a) of FBT_IN(n, a)
        
        typedef fb_count (a:addr, f:int, b:int) = [c:nat | f >= 0; b >= 0] (FBT_IN(c, a) | int f, int b)
        
        fn fb_count_init {l:addr; s:nat} ( a: !arrayptr(ctri, l, s) ) : fb_count(l, 0, 0) = (FBT_NIL() | 0, 0)
        
        fn tri_fb_test {c:nat}{l:addr}
        (
        pfin: FBT_IN(c, l) | t: ctri, dv: plane
        ): (FBT_IN(c+1, l) | intBtwe(0,2)) =
          if ctri_inside_plane(t, dv) then (FBT_CONS(pfin) | 0)
          else if ctri_outside_plane(t, dv) then (FBT_CONS(pfin) | 1)
          else (FBT_CONS(pfin) | 2)
        
        fun loop1 {i,j:nat | i <= j}{a:addr}{f1,b1:nat}
        ( a: !arrayptr(ctri, a, j), dv: plane,
        fbc: fb_count(a, f1, b1),
        j: int j, i: int i ): [f2,b2:nat] fb_count(a, f2, b2) = (
          if i < j then let
            val c: ctri = a[i]
            val (pf_tr | tr) = tri_fb_test(fbc.0 | c, dv)
            val ret_fbc = ( ifcase
              | tr=0 => (FBT_CONS(fbc.0) | fbc.1+1, fbc.2)
              | tr=1 => (FBT_CONS(fbc.0) | fbc.1, fbc.2+1)
              | _ => (FBT_CONS(fbc.0) | fbc.1+1, fbc.2+1)
            ): [f,b:nat] fb_count(a,f,b)
          in
            loop1(a, dv, ret_fbc, j, i+1)
          end else fbc
        )
        
        fun front_loop {a,b:addr; fi:nat; fc,bc:nat; c:nat}{i,j:nat | i <= j}
        ( pf_in: FBT_IN(c, a) | a: !arrayptr(ctri, a, j), dv: plane,
        fbc: fb_count(a, fc, bc), f_i: int fi, f_arr: !arrayptr(ctri, b, fc),
        j: int j, i: int i ): void = (
          if i < j then let
            val c: ctri = a[i]
            val (pf_tr | tr) = tri_fb_test(pf_in | c, dv)
          in
            ifcase
            | tr=0 || tr=2 => let
              extern praxi confirm_already_tested_array_front {a:addr}{f,b,c,i:nat}
              (
              pf_in: FBT_IN(c, a) | cnt: fb_count(a, f, b), ind: int i
              ): [i < f] void
              prval () = confirm_already_tested_array_front(pf_tr | fbc, f_i)
              val () = f_arr[f_i] := c
            in
              front_loop(pf_tr | a, dv, fbc, f_i+1, f_arr, j, i+1)
            end
            | _ => front_loop(pf_tr | a, dv, fbc, f_i, f_arr, j, i+1)
          end else ()
        )
        
        fun back_loop {a,b:addr; bi:nat; fc,bc:nat; c:nat}{i,j:nat | i <= j}
        ( pf_in: FBT_IN(c, a) | a: !arrayptr(ctri, a, j), dv: plane,
        fbc: fb_count(a, fc, bc), b_i: int bi, b_arr: !arrayptr(ctri, b, bc),
        j: int j, i: int i ): void = (
          if i < j then let
            val c: ctri = a[i]
            val (pf_tr | tr) = tri_fb_test(pf_in | c, dv)
          in
            ifcase
            | tr=1 || tr=2 => let
              extern praxi confirm_already_tested_array_back {a:addr}{f,b,c,i:nat}
              (
              pf_in: FBT_IN(c, a) | cnt: fb_count(a, f, b), ind: int i
              ): [i < b] void
              prval () = confirm_already_tested_array_back(pf_tr | fbc, b_i)
              val () = b_arr[b_i] := c
            in
              back_loop(pf_tr | a, dv, fbc, b_i+1, b_arr, j, i+1)
            end
            | _ => back_loop(pf_tr | a, dv, fbc, b_i, b_arr, j, i+1)
          end else ()
        )
        
        val fbc_init = fb_count_init(arr)
        val fb_cnt = loop1(arr, division, fbc_init, n, 0)
      in
        if fb_cnt.1 > n * 0.75f || fb_cnt.2 > n * 0.75f then fold@(cm)
        else let
          val ct0 = ctri_new(vec3_zero(), vec3_zero(), vec3_zero(), vec3_zero())
          var f_cm = ( if fb_cnt.1 > 0 then let
            var f_arr = arrayptr_make_elt<ctri>(size_of_int(fb_cnt.1), ct0)
            val () = front_loop(FBT_NIL() | arr, division, fb_cnt, 0, f_arr, n, 0)
            var ret = CMESH_LEAF(f_arr, fb_cnt.1, sphere_new(vec3_zero(), 0.f))
            val f_bound = cmesh_bound(ret)
            val- @CMESH_LEAF(_, _, bnd) = ret
            val () = bnd := f_bound
            prval () = fold@(ret)
          in
            ret
          end else CMESH_LEAF_EMPTY(sphere_new(vec3_zero(), 0.f))
          ): cmesh
          var b_cm = ( if fb_cnt.2 > 0 then let
            var b_arr = arrayptr_make_elt<ctri>(size_of_int(fb_cnt.2), ct0)
            val () = back_loop(FBT_NIL() | arr, division, fb_cnt, 0, b_arr, n, 0)
            var ret = CMESH_LEAF(b_arr, fb_cnt.2, sphere_new(vec3_zero(), 0.f))
            val b_bound = cmesh_bound(ret)
            val- @CMESH_LEAF(_, _, bnd) = ret
            val () = bnd := b_bound
            prval () = fold@(ret)
          in
            ret
          end else CMESH_LEAF_EMPTY(sphere_new(vec3_zero(), 0.f))
          ): cmesh
          val () = cmesh_subdivide(f_cm, iterations-1)
          val () = cmesh_subdivide(b_cm, iterations-1)
          val () = arrayptr_free(arr)
          val () = free@{0}(cm)
        in
          cm := CMESH_BRANCH(division, f_cm, b_cm)
        end
      end
    | _ => ()
end else ()

implement{cmesh} asset_get ( filename ) = $UNSAFE.castvwtp0(col_load_file($UNSAFE.castvwtp1(filename)))

//implmnt col_load_file ( filename ) =

end
