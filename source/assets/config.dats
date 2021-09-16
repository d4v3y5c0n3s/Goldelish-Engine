(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  config.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./config.sats"
staload "../g_asset.sats"
staload "../g_engine.sats"
staload "../data/dict.sats"

local

datavtype CONFIG_ENTRY(a:vt@ype) = CF_ETRY(a)
assume config_entry = [a:vt@ype] CONFIG_ENTRY(a)
assume config = [d:int | d>0] @( dict(config_entry, d), FILEptr1 )

in

implement cfg_save_file ( c, filename ) = let
in
end

end
