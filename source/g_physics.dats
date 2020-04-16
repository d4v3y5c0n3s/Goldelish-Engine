(*
###  g_physics.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_physics.sats"

implement vec3_gravity (  ) =
(
)

implement quadratic ( a, b, c, t0, t1 ) =
(
)

implement collision_none (  ) =
(
)

implement collision_new ( time, point, norm ) =
(
)

implement collision_merge ( c0, c1 ) =
(
)

implement point_collide_point ( p, v, p0 ) =
(
)

implement point_collide_sphere ( p, v, s ) =
(
)

implement point_collide_ellipsoid ( p, v, e ) =
(
)

implement point_collide_edge ( p, v, e0, e1 ) =
(
)

implement point_collide_face ( p, v, ct ) =
(
)

implement point_collide_ctri ( p, v, ct ) =
(
)

implement point_collide_mesh_space ( p, v, cm, world, world_normal, space, space_normal ) =
(
)

implement point_collide_mesh ( p, v, m, world, world_normal ) =
(
)

implement sphere_collide_face ( s, v, ct ) =
(
)

implement sphere_collide_edge ( s, v, e0, e1 ) =
(
)

implement sphere_collide_point ( s, v, p ) =
(
)

implement sphere_collide_sphere ( s, v, s0 ) =
(
)

implement sphere_collide_ctri ( s, v, ct ) =
(
)

implement ellipsoid_collide_point ( e, v, p ) =
(
)

implement ellipsoid_collide_sphere ( e, v, s ) =
(
)

implement sphere_collide_mesh_space ( s, v, cm, world, world_normal, space, space_normal ) =
(
)

implement sphere_collide_mesh ( s, v, m, world, world_normal ) =
(
)

implement ellipsoid_collide_mesh ( e, v, m, world, world_normal ) =
(
)

implement collision_response_slide ( x, position, velocity, colfunc ) =
(
)