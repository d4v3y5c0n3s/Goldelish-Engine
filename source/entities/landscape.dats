(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  landscape.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./entities/landscape.sats"

staload "./assets/terrain.sats"
staload "./assets/texture.sats"

////
implement landscape_blobtree_new ( l ) =
{
}

implement landscape_blobtree_delete ( lbt ) =
{
}

implement landscape_blobtree_generate ( l ) =
{
}

implement landscape_new (  ) =
{
}

implement landscape_delete ( l ) =
{
}

implement landscape_world ( l ) =
{
}

implement landscape_world_normal ( l ) =
{
}

implement landscape_height ( l, pos ) =
{
}

implement landscape_normal ( l, pos ) =
{
}

implement landscape_axis ( l, pos ) =
{
}

implement landscape_paint_height ( l, pos, radius, value, opacity ) =
{
}

implement landscape_chunks ( l, pos, chunks_out ) =
{
}

implement landscape_paint_color ( l, pos, radius, type, opacity ) =
{
}
