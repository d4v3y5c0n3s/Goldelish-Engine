(*
###  terrain.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/terrain.sats"

staload "./g_net.sats"

staload "./assets/cmesh.sats"

////
implement terrain_chunk_delete ( tc ) =
(
)

implement terrain_new_chunk ( ter, i ) =
(
)

implement terrain_reload_chunk ( ter, i ) =
(
)

val MAX_HEIGHT = 128

implement raw_load_file ( filename ) =
(
)

implement raw_save_file ( t, filename ) =
(
)

implement terrain_get_chunk ( ter, x, y ) =
(
)

implement terrain_delete ( ter ) =
(
)

implement terrain_height ( ter, position ) =
(
)

implement terrain_tbn ( ter, position ) =
(
)

implement terrain_axis ( ter, position ) =
(
)

implement terrain_normal ( ter, position ) =
(
)