(*
###  cmesh.hats  ###

definition of 3D mesh in the game engine
*)

#include "g_engine.hats"

typedef ctri = @{ a=vec3, b=vec3, c=vec3, norm=vec3, bound=sphere }

fun ctri_new ( a: vec3, b: vec3, c: vec3, norm: vec3 ) : ctri = "sta#%"
fun ctri_transform ( t: ctri, m: mat4, mn: mat3 ) : ctri = "sta#%"
fun ctri_transform_space ( t: ctri, s: mat3, sn: mat3 ) : ctri = "sta#%"

fun ctri_inside_plane ( t: ctri, p: plane ) : bool = "sta#%"
fun ctri_outside_plane ( t: ctri, p: plane ) : bool = "sta#%"
fun ctri_intersects_plane ( t: ctri, p: plane ) : bool = "sta#%"

typedef cmesh = @{
	is_leaf=bool,
	'(
		@{ division=plane, front=cmesh ptr, back=cmesh ptr },
		@{ triangles=ctri ptr, triangles_num=int, bound=sphere }
	)
}

fun col_load_file ( filename=string ) : cmesh ptr = "sta#%"
fun cmesh_delete ( cm: cmesh ptr ) : void = "sta#%"

fun cmesh_bound ( cm: cmesh ptr ) : sphere = "sta#%"
fun cmesh_subdivide ( cm: cmesh ptr, iterations: int ) : void = "sta#%"
