(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  physics_object.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./entities/physics_object.sats"

staload "./assets/cmesh.sats"

////
implement physics_object_new (  ) =
{
}

implement physics_object_delete ( po ) =
{
}

implement physics_object_update ( po, timestep ) =
{
}

implement physics_object_collide_static ( po, so, timestep ) =
{
}
