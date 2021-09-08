(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  landscape.sats  ###

object for rendering instance of terrain
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/image.sats"
staload "./../assets/terrain.sats"

typedef landscape_blobtree = @{
	bound=sphere,
	is_leaf=bool,
	chunk_index=int,
	child0=(*landscape_blobtree*) ptr,
	child1=(*landscape_blobtree*) ptr,
	child2=(*landscape_blobtree*) ptr,
	child3=(*landscape_blobtree*) ptr
}

vtypedef landscape = @{
	heightmap=asset_hndl(image),
	attribmap=asset_hndl(image),
	attribimage=(*image*) ptr,
	scale=float,
	size_x=float,
	size_y=float,
	blobtree=(*landscape_blobtree*) ptr,
	ground0=asset_hndl(image),
	ground1=asset_hndl(image),
	ground2=asset_hndl(image),
	ground3=asset_hndl(image),
	ground0_nm=asset_hndl(image),
	ground1_nm=asset_hndl(image),
	ground2_nm=asset_hndl(image),
	ground3_nm=asset_hndl(image)
}

fun landscape_new () : (*landscape*) ptr
fun landscape_delete ( l: (*landscape*) ptr ) : void

fun landscape_blobtree_new ( ls: (*landscape*) ptr ) : (*landscape_blobtree*) ptr
fun landscape_blobtree_delete ( lbt: (*landscape_blobtree*) ptr ) : void
fun landscape_blobtree_generate ( l: (*landscape*) ptr ) : void

fun landscape_world ( l: (*landscape*) ptr ) : mat4
fun landscape_world_normal ( l: (*landscape*) ptr ) : mat3
fun landscape_height ( l: (*landscape*) ptr, pos: vec2 ) : float
fun landscape_normal ( l: (*landscape*) ptr, pos: vec2 ) : vec3
fun landscape_axis ( l: (*landscape*) ptr, pos: vec2 ) : mat3

fun landscape_paint_height ( l: (*landscape*) ptr, pos: vec2, radius: float, value: float, opacity: float ) : void
fun landscape_paint_color ( l: (*landscape*) ptr, pos: vec2, radius: float, paint_type: int, opacity: float ) : void

fun landscape_chunks ( l: (*landscape*) ptr, pos: vec2, chunks_out: (*terrain_chunk ptr*) ptr ) : void
