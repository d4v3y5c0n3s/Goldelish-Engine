(*
###  renderable.sats  ###

defines a renderable mesh (may be rigged or not)
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./material.sats"

typedef vertex_weight = @{ bone_ids=int, bone_weights=float }//  bone_ids[3] & bone_weights[3] in C

vtypedef renderable_surface = @{ vertex_vbo=$extype"GLuint", triangle_vbo=$extype"GLuint", num_verticies=int, num_triangles=int, bound=sphere }

fun renderable_surface_new ( m: (*mesh*) ptr ) : (*renderable_surface*) ptr = "sta#%"
fun renderable_surface_new_rigged ( m: (*mesh*) ptr, weights: (*vertex_weight*) ptr ) : (*renderable_surface*) ptr = "sta#%"
fun renderable_surface_delete ( surface: (*renderable_surface*) ptr ) : void = "sta#%"

vtypedef renderable = @{ surfaces=(*renderable_surface ptr*) ptr, num_surfaces=int, is_rigged=bool, material=asset_hndl }

fun renderable_new () : (*renderable*) ptr = "sta#%"
fun renderable_delete ( r: (*renderable*) ptr ) : void = "sta#%"

fun renderable_add_mesh ( r: (*renderable*) ptr, m: (*mesh*) ptr ) : void = "sta#%"
fun renderable_add_model ( r: (*renderable*) ptr, m: (*model*) ptr ) : void = "sta#%"
fun renderable_set_material ( r: (*renderable*) ptr, mat: asset_hndl ) : void = "sta#%"

fun renderable_to_model ( r: (*renderable*) ptr ) : (*model*) ptr = "sta#%"

fun bmf_load_file ( filename: string ) : (*renderable*) ptr = "sta#%"
fun obj_load_file ( filename: string ) : (*renderable*) ptr = "sta#%"
fun smd_load_file ( filename: string ) : (*renderable*) ptr = "sta#%"
fun ply_load_file ( filename: string ) : (*renderable*) ptr = "sta#%"

fun bmf_save_file ( r: (*renderable*) ptr, filename: string ) : void = "sta#%"
