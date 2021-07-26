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
	heightmap=asset_hndl,
	attribmap=asset_hndl,
	attribimage=(*image*) ptr,
	scale=float,
	size_x=float,
	size_y=float,
	blobtree=(*landscape_blobtree*) ptr,
	ground0=asset_hndl,
	ground1=asset_hndl,
	ground2=asset_hndl,
	ground3=asset_hndl,
	ground0_nm=asset_hndl,
	ground1_nm=asset_hndl,
	ground2_nm=asset_hndl,
	ground3_nm=asset_hndl
}

fun landscape_new () : (*landscape*) ptr = "sta#%"
fun landscape_delete ( l: (*landscape*) ptr ) : void = "sta#%"

fun landscape_blobtree_new ( ls: (*landscape*) ptr ) : (*landscape_blobtree*) ptr = "sta#%"
fun landscape_blobtree_delete ( lbt: (*landscape_blobtree*) ptr ) : void = "sta#%"
fun landscape_blobtree_generate ( l: (*landscape*) ptr ) : void = "sta#%"

fun landscape_world ( l: (*landscape*) ptr ) : mat4 = "sta#%"
fun landscape_world_normal ( l: (*landscape*) ptr ) : mat3 = "sta#%"
fun landscape_height ( l: (*landscape*) ptr, pos: vec2 ) : float = "sta#%"
fun landscape_normal ( l: (*landscape*) ptr, pos: vec2 ) : vec3 = "sta#%"
fun landscape_axis ( l: (*landscape*) ptr, pos: vec2 ) : mat3 = "sta#%"

fun landscape_paint_height ( l: (*landscape*) ptr, pos: vec2, radius: float, value: float, opacity: float ) : void = "sta#%"
fun landscape_paint_color ( l: (*landscape*) ptr, pos: vec2, radius: float, type: int, opacity: float ) : void = "sta#%"

fun landscape_chunks ( l: (*landscape*) ptr, pos: vec2, chunks_out: (*terrain_chunk ptr*) ptr ) : void = "sta#%"
