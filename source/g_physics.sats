(*
###  g_physics.sats  ###

a basic physics system definition
*)

#include "g_engine.sats"
#include "assets/cmesh.sats"

fun vec3_gravity () : vec3 = "sta#%"

fun quadratic ( a: float, b: float, c: float, t0: float ptr, t1: float ptr ) : bool = "sta#%"

typedef collision = @{
	collided=bool,
	time=float,
	point=vec3,
	norm=vec3,
	flags=int
}

fun collision_none () : collision = "sta#%"
fun collision_new ( time: float, point: vec3, norm: vec3 ) : collision = "sta#%"
fun collision_merge ( c0: collision, c1: collision ) : collision = "sta#%"

fun point_collide_point ( p: vec3, v: vec3, p0: vec3 ) : collision = "sta#%"
fun point_collide_sphere ( p: vec3, v: vec3, s: sphere ) : collision = "sta#%"
fun point_collide_ellipsoid ( p: vec3, v: vec3, e: ellipsoid ) : collision = "sta#%"
fun point_collide_edge ( p: vec3, v: vec3, e0: vec3, e1: vec3 ) : collision = "sta#%"
fun point_collide_face ( p: vec3, v: vec3, ct: ctri ) : collision = "sta#%"
fun point_collide_ctri ( p: vec3, v: vec3, ct: ctri ) : collision = "sta#%"
fun point_collide_mesh ( p: vec3, v: vec3, m: cmesh ptr, world: mat4, world_normal: mat3 ) : collision = "sta#%"

fun sphere_collide_point ( s: sphere, v: vec3, p: vec3 ) : collision = "sta#%"
fun sphere_collide_sphere ( s: sphere, v: vec3, s0: sphere ) : collision = "sta#%"
fun sphere_collide_edge ( s: sphere, v: vec3, e0: vec3, e1: vec3 ) : collision = "sta#%"
fun sphere_collide_face ( s: sphere, v: vec3, ct: ctri ) : collision = "sta#%"
fun sphere_collide_ctri ( s: sphere, v: vec3, ct: ctri ) : collision = "sta#%"
fun sphere_collide_mesh ( s: sphere, v: vec3, m: mesh ptr, world: mat4, world_normal: mat3 ) : collision = "sta#%"

fun ellipsoid_collide_mesh ( e: ellipsoid, v: vec3, m: cmesh ptr, world: mat4, world_normal: mat3 ) : collision = "sta#%"
fun ellipsoid_collide_point ( e: ellipsoid, v: vec3, p: vec3 ) : collision = "sta#%"
fun ellipsoid_collide_sphere ( e: ellipsoid, v: vec3, s: sphere ) : collision = "sta#%"

fun collision_response_slide ( x: void ptr, position: vec3 ptr, velocity: vec3 ptr, collision (*colfunc)(void* x, vec3* pos, vec3* vel)(*<--this will need to be rewritten*) ) : void = "sta#%"
