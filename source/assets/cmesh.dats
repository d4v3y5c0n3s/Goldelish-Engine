(*
###  cmesh.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./cmesh.sats"
staload "./../data/vertex_list.sats"
staload "./../g_engine.sats"
staload "./../g_asset.sats"

local

datavtype CMESH_TREE =
| CMESH_BRANCH of (plane, CMESH_TREE, CMESH_TREE)
| {n:nat} CMESH_LEAF of (arrayptr(ctri, n), int n, sphere)

assume cmesh = CMESH_TREE

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
    | CMESH_BRANCH(_, _, _) => vec3_zero()

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
    | CMESH_BRANCH(_, _, _) => 0.f

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
    | CMESH_BRANCH(_, _, _) => box_new(0.f, 0.f, 0.f, 0.f, 0.f, 0.f)

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
    | CMESH_BRANCH(_, _, _) => sphere_new(vec3_zero(), 0.f)
end////
implement cmesh_subdivide ( cm, iterations ) =
    case+ cm of
    | CMESH_LEAF(arr, n, _) =>
      if n < 10 then ()
      else let
        val division = cmesh_division(cm)
        
        fun loop1 {i:nat}{j:nat | i <= j}
        ( a: !arrayptr(ctri, j),
        nfnb: (int, int),
        j: int j, i: int i ): (int, int) =
            if i < j then let
                val c: ctri = a[i]
            in
                if ctri_inside_plane(c, division) then (
                  loop1(a, (nfnb.0, nfnb.1+1), j, i+1)
                ) else if ctri_outside_plane(c, division) then (
                  loop1(a, (nfnb.0+1, nfnb.1), j, i+1)
                ) else loop1(a, (nfnb.0+1, nfnb.1+1), j, i+1)
            end else nfnb
            val (num_front, num_back) = loop1(arr, (0, 0), n, 0)
      in
        if num_front > n * 0.75f || num_back > n * 0.75f then ()
        else let
          val front =
          val back =
          val (i_front, i_back) =
          
          //  essentially, we need to divide the tris into "front," "back,"
          //or both; then later we will recursively call the function again
          //on "front" & "back" (may need to change fn to fun)
          (*
          as a side note, in the future it may be worth changing cmesh to
          not require this function to have two loops (because that can be
          slow); instead, you could use statics & t.p. to guarantee that
          cmeshes passes can be subdivided (you won't need some of the above
          conditionals too)
          *)
          fun loop2
        in
        end
      end
    | CMESH_BRANCH(_, _, _) => ()
end////
implement SDL_RWreadline ( file, buffer, buffersize ) =

implement col_load_file ( filename ) =

implement{cmesh} asset_get ( filename ) =
