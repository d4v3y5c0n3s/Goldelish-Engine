(*
###  cmesh.sats  ###

definition of 3D mesh in the game engine
*)

staload "./../g_engine.sats"

typedef ctri = @{ a=vec3, b=vec3, c=vec3, norm=vec3, bound=sphere }

fn ctri_new ( a: vec3, b: vec3, c: vec3, norm: vec3 ) : ctri
fn ctri_transform ( t: ctri, m: mat4, mn: mat3 ) : ctri
fn ctri_transform_space ( t: ctri, s: mat3, sn: mat3 ) : ctri

fn ctri_inside_plane ( t: ctri, p: plane ) : bool
fn ctri_outside_plane ( t: ctri, p: plane ) : bool
fn ctri_intersects_plane ( t: ctri, p: plane ) : bool

absvt@ype cmesh

fn col_load_file ( filename: string ) : cmesh
fn cmesh_delete ( cm: cmesh ) : void

fn cmesh_bound ( cm: !cmesh ) : sphere
fun cmesh_subdivide {it:nat} ( cm: &cmesh, iterations: int it ) : void
