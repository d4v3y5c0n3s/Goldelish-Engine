(*
###  g_asset.dats  ###

source file for dealing with assets
*)

#include "share/atspre_staload.hats"

staload "./g_asset.sats"
staload "./g_engine.sats"

extern castfn int_to_usint( x: int ): usint

local

assume asset_hndl = [l:addr][a:vt@ype] @{ path=fpath, asset_ptr=(a? @ l | ptr l), timestamp=usint }

assume asset_handler = [l1,l2:addr][a:vt@ype] @{ extension=fpath, load_func=string -<cloptr1> (a @ l1 | ptr l1), del_func=(a? @ l2 | ptr l2) -<cloptr1> void }

assume path_variable = @{ variable=fpath, mapping=fpath }

in

(*
This compiles, proof-of-concept for handling assets

vtypedef asset_hndl_tst = [l:addr][a:vt@ype] @{ path=strptr, asset_ptr=(a? @ l | ptr l), timestamp=usint }
fn test ( ah: &asset_hndl_tst ): void = (
  strptr_free(ah.path);
  ah.path := strptr_null()
)
*)

end////
implement{a} asset_hndl_null () = let//@{path=P(""), asset_ptr=, timestamp=int_to_usint(0)}:asset_hndl
  var res: asset_hndl
  val test = res.path
in
  //res.timestamp := int_to_usint(0);
  res
end
end////
implement{a} asset_hndl_new ( v, path, pv ) = @{path=asset_map_filename(path, pv), asset_ptr=v, timestamp=int_to_usint(0)}:asset_hndl

implement{a} asset_hndl_new_load ( v, path, pv ) = let
  var ah = asset_hndl_new(v, path, pv)
  //val loaded = file_load(ah)
in
  strptr_free(ah.path);
  ah.path := path
  //(@{path=ah.path, asset_ptr=loaded, timestamp=ah.timestamp}:asset_hndl)
end

implement{a} asset_hndl_new_ptr ( asset ) =

implement{a} asset_hndl_isnull ( ah ) =

implement{a} asset_hndl_path ( ah ) =

implement{a} asset_hndl_ptr ( ah ) =

implement{a} asset_hndl_eq ( ah0, ah1 ) =

implement asset_cache_flush ( asset_timestamp ) =

implement asset_add_path_variable ( variable, mapping ) =

implement asset_map_filename ( filename, pv ) =

implement asset_unmap_filename ( filename, pv ) =

implement{a} file_load ( filename, ah ) =

implement{a} file_reload ( filename, ah, asset_timestamp ) =

implement file_exists ( path ) =

implement{a} asset_get_load ( path ) =

implement{a} asset_get ( path ) =

end