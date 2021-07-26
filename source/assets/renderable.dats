(*
###  renderable.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/renderable.sats"

staload "./data/vertex_hashtable.sats"

////
implement renderable_add_mesh ( r, m ) =
(
)

implement renderable_add_model ( r, m ) =
(
)

implement renderable_new (  ) =
(
)

implement renderable_delete ( r ) =
(
)

implement renderable_set_material ( r, mat ) =
(
)

implement renderable_to_model ( r ) =
(
)

implement renderable_surface_new ( m ) =
(
)

implement renderable_surface_new_rigged ( m, weights ) =
(
)

implement renderable_surface_delete ( s ) =
(
)

implement renderable_surface_bouding_sphere ( verts, num_verts, stride ) =
(
)

implement bmf_load_file ( filename ) =
(
)

implement bmf_save_file ( r, filename ) =
(
)

implement SDL_RWreadline ( file, buffer, buffersize ) =
(
)

implement obj_load_file ( filename ) =
(
)

implement renderable_add_mesh_rigged ( r, m, weights ) =
(
)

implement smd_load_file ( filename ) =
(
)

implement ply_load_file ( filename ) =
(
)