(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  randf.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./data/randf.sats"

////
implement randf (  ) =
{
}

typedef float_int = '{  as_float=float, as_int=uint32_t  }

implement float_to_int ( f ) =
{
}

implement randf_seed ( s ) =
{
}

implement randf_nseed ( s ) =
{
}

implement randf_n (  ) =
{
}

implement randf_scale ( s ) =
{
}

implement randf_nscale ( s ) =
{
}

implement randf_range ( s, e ) =
{
}

implement randf_circle ( radius ) =
{
}
