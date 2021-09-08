(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  camera.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./entities/camera.sats"

staload "./g_graphics.sats"

////
implement camera_new (  ) =
{
}

implement camera_delete ( c ) =
{
}

implement camera_direction ( c ) =
{
}

implement camera_view_matrix ( c ) =
{
}

implement camera_proj_matrix ( c ) =
{
}

implement camera_view_proj_matrix ( c ) =
{
}

implement camera_normalize_target ( c ) =
{
}

implement camera_control_orbit ( c, e ) =
{
}

implement camera_control_freecam ( c, timestamp ) =
{
}

implement camera_control_joyorbit ( c, timestamp ) =
{
}
