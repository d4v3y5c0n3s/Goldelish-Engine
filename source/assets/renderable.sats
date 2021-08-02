(*
###  renderable.sats  ###

defines a renderable mesh (may be rigged or not)
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./material.sats"

staload "./../SDL2/SDL_local.sats"

typedef vertex_weight = @{ bone_ids=int, bone_weights=float }//  bone_ids[3] & bone_weights[3] in C

vtypedef renderable_surface = @{ vertex_vbo=GLuint, triangle_vbo=GLuint, num_verticies=int, num_triangles=int, bound=sphere }

fun renderable_surface_new ( m: (*mesh*) ptr ) : (*renderable_surface*) ptr
fun renderable_surface_new_rigged ( m: (*mesh*) ptr, weights: (*vertex_weight*) ptr ) : (*renderable_surface*) ptr
fun renderable_surface_delete ( surface: (*renderable_surface*) ptr ) : void

vtypedef renderable = @{ surfaces=(*renderable_surface ptr*) ptr, num_surfaces=int, is_rigged=bool, material=asset_hndl(material) }

fun renderable_new () : (*renderable*) ptr
fun renderable_delete ( r: (*renderable*) ptr ) : void

fun renderable_add_mesh ( r: (*renderable*) ptr, m: (*mesh*) ptr ) : void
fun renderable_add_model ( r: (*renderable*) ptr, m: (*model*) ptr ) : void
fun renderable_set_material ( r: (*renderable*) ptr, mat: asset_hndl(material) ) : void

fun renderable_to_model ( r: (*renderable*) ptr ) : (*model*) ptr

fun bmf_load_file ( filename: string ) : (*renderable*) ptr
fun obj_load_file ( filename: string ) : (*renderable*) ptr
fun smd_load_file ( filename: string ) : (*renderable*) ptr
fun ply_load_file ( filename: string ) : (*renderable*) ptr

fun bmf_save_file ( r: (*renderable*) ptr, filename: string ) : void
