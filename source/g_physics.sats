(*
###  g_physics.sats  ###

a basic physics system definition
*)

staload "./g_engine.sats"
staload "./assets/cmesh.sats"

fn vec3_gravity () : vec3

fn quadratic ( a: float, b: float, c: float, t0: &float, t1: &float ) : bool

abst0ype collision ( bool )

fn collision_none ( suc: &bool? >> bool sc ) : #[sc:bool | sc==false] collision(sc)
fn collision_new ( time: float, point: vec3, norm: vec3, suc: &bool? >> bool sc ) : #[sc:bool | sc==true] collision(sc)
fn collision_merge {b0,b1:bool} ( b0: bool b0, c0: collision(b0), b1: bool b1, c1: collision(b1), suc: &bool? >> bool sc ) : #[sc:bool | sc==b0||b1] collision(sc)

fn point_collide_point ( p: vec3, v: vec3, p0: vec3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_sphere ( p: vec3, v: vec3, s: sphere, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_ellipsoid ( p: vec3, v: vec3, e: ellipsoid, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_edge ( p: vec3, v: vec3, e0: vec3, e1: vec3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_face ( p: vec3, v: vec3, ct: ctri, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_ctri ( p: vec3, v: vec3, ct: ctri, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn point_collide_mesh ( p: vec3, v: vec3, m: &cmesh, world: mat4, world_normal: mat3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)

fn sphere_collide_point ( s: sphere, v: vec3, p: vec3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn sphere_collide_sphere ( s: sphere, v: vec3, s0: sphere, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn sphere_collide_edge ( s: sphere, v: vec3, e0: vec3, e1: vec3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn sphere_collide_face ( s: sphere, v: vec3, ct: ctri, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn sphere_collide_ctri ( s: sphere, v: vec3, ct: ctri, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn sphere_collide_mesh ( s: sphere, v: vec3, m: &cmesh, world: mat4, world_normal: mat3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)

fn ellipsoid_collide_mesh ( e: ellipsoid, v: vec3, m: &cmesh, world: mat4, world_normal: mat3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)
fn ellipsoid_collide_point ( e: ellipsoid, v: vec3, p: vec3, suc: &bool? >> bool sc ) : #[sc:bool] collision(sc)

fn{c1,c2:vt@ype} collision$collide ( c1: !c1, c2: !c2, pos: vec3, vel: vec3, suc: &bool? >> bool sc ): #[sc:bool] collision(sc)
fn{t1,t2:vt@ype} collision_response_slide ( position: &vec3, velocity: &vec3, t1: !t1, t2: !t2 ): void

fn{t1,t2:vt@ype} collision_response_slide_fun {sc:bool} (
  position: &vec3, velocity: &vec3, t1: !t1, t2: !t2, f: (!t1, !t2, vec3, vec3, &bool? >> bool sc)->collision(sc)
): void
