(*
###  g_asset.dats  ###

source file for dealing with assets
*)

#include "share/atspre_staload.hats"

staload "./g_asset.sats"

staload "./data/dict.sats"
staload "./data/list.sats"

local

assume asset_hndl = [a:vtype] @{ path=fpath, asset_ptr=a, timestamp=usint }

assume asset_handler = [a:vtype] @{ extension=string, load_func=string -<cloptr1> a, del_func=a -<cloptr1> void }

assume path_variable = @{ variable=fpath, mapping=fpath }

in
end