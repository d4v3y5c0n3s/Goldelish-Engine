(*
###  terrain.sats  ###

definition WIP heightmap-based terrain LOD system
*)

staload "./../g_engine.sats"
staload "./cmesh.sats"

#define NUM_TERRAIN_SUBDIVISIONS 0
#define NUM_TERRAIN_BUFFERS 7

vtypedef terrain_chunk = @{
	id=int,
	x=int, y=int, width=int, height=int,
	bound=sphere,
	left=(*@{terrain_chunk*) ptr(*}*),
	right=(*@{terrain_chunk*) ptr(*}*),
	top=(*@{terrain_chunk*) ptr(*}*),
	bottom=(*@{terrain_chunk*) ptr(*}*),
	colmesh=(*cmesh*) ptr,
	num_verts=int,
	vertex_buffer=$extype"GLuint",
	num_indicies=int,//NUM_TERRAIN_BUFFERS
	index_buffers=$extype"GLuint"//NUM_TERRAIN_BUFFERS
}

(*
struct terrain_chunk;
typedef struct terrain_chunk terrain_chunk;
*)

fun terrain_chunk_delete ( tc: (*terrain_chunk*) ptr ) : void = "sta#%"

typedef terrain = @{
	width=int,
	height=int,
	heightmap=(*float*) ptr,
	chunk_width=int,
	chunk_height=int,
	num_chunks=int,
	num_cols=int,
	num_rows=int,
	chunks=(*terrain_chunk ptr*) ptr
}

fun raw_load_file ( filename: string ) : (*terrain*) ptr = "sta#%"
fun raw_save_file ( ter: (*terrain*) ptr, filename: string ) : void  = "sta#%"
fun terrain_delete ( ter: (*terrain*) ptr ) : void = "sta#%"

fun terrain_get_chunk ( ter: (*terrain*) ptr, x: int, y: int ) : (*terrain_chunk*) ptr = "sta#%"
fun terrain_reload_chunk ( ter: (*terrain*) ptr, i: int ) : void = "sta#%"

fun terrain_tbn ( ter: (*terrain*) ptr, position: vec2 ) : mat3 = "sta#%"
fun terrain_axis ( ter: (*terrain*) ptr, position: vec2 ) : mat3 = "sta#%"
fun terrain_height ( ter: (*terrain*) ptr, position: vec2 ) : float = "sta#%"
fun terrain_normal ( ter: (*terrain*) ptr, position: vec2 ) : vec3 = "sta#%"
