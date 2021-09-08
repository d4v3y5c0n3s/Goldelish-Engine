(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  skeleton.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/skeleton.sats"

////
implement frame_new (  ) =
(
)

implement frame_copy ( f ) =
(
)

implementf frame_interpolate ( f0, f1, amount ) =
(
)

implement frame_interpolate_to ( f0, f1, amount, out ) =
(
)

implement frame_copy_to ( f, out ) =
(
)

//  ### these are probably misspelled, likely meant to use "descendant" ###
implement frame_decendant_of ( f, decendent, joint ) =
(
)

implement frame_decendants_to ( f0, f1, amount, joint, out ) =
(
)

implement frame_delete ( f ) =
(
)

implement frame_joint_transform ( f, i ) =
(
)

implement frame_joint_add ( f, parent, position, rotation ) =
(
)

implement frame_gen_transforms ( f ) =
(
)

implement frame_gen_inv_transforms ( f ) =
(
)

implement skeleton_new (  ) =
(
)

implement skeleton_delete ( s ) =
(
)

implement skeleton_joint_add ( s, name, parent ) =
(
)

implement skeleton_joint_id ( s, name ) =
(
)

implement SDL_RWreadline ( file, buffer, buffersize ) =
(
)

datatype SL =
| STATE_LOAD_EMPTY of ()
| STATE_LOAD_SKELETON of ()
| STATE_LOAD_NODES of ()

implement skl_load_file ( filename ) =
(
)
