(*
###  g_asset.dats  ###

source file for dealing with assets
*)

#include "share/atspre_staload.hats"

staload "./g_asset.sats"
staload "./g_engine.sats"

implmnt{a} asset_delete ( x ) = asset$delete(x)
implmnt{a} asset_get ( filename ) = asset$load_file<a>(filename)

local
assume asset_hndl (a:vt@ype) = [l:addr] @{ path=fpath, x=(a @ l, mfree_gc_v(l) | ptr l) }
in

implmnt{a} asset_hndl_new ( filename ) = let
	val (pfat, pfgc | pointer) = ptr_alloc<a>()
	val () = !pointer := asset_get(filename)
in
	@{path=filename, x=(pfat, pfgc | pointer)}:asset_hndl(a)
end

implmnt{a} asset_hndl_get_path ( ah ) = let
  val (pfat, pfgc | p) = ah.x
  val () = asset_delete(!p)
  val () = ptr_free(pfgc, pfat | p)
in
  ah.path
end

implmnt{a} asset_hndl_get_asset ( ah ) = let
	val (pfat, pfgc | p) = ah.x
	val ret = !p
	val () = ptr_free(pfgc, pfat | p)
  val () = fpath_delete(ah.path)
in
	ret
end

implmnt{a} asset_hndl_get ( ah ) = let
	val (pfat, pfgc | p) = ah.x
	val ret = !p
	val () = ptr_free(pfgc, pfat | p)
in
  @(ah.path, ret)
end

implmnt{a} asset_hndl_set_path ( ah, path ) = begin
	fpath_delete(ah.path);
	ah.path := path;
	()
end

implmnt{a} asset_hndl_set_asset ( ah, x ) = let
	val (pfat, pfgc | p) = ah.x
  val () = asset_delete(!p)
	val () = !p := x
	val () = ah.x := (pfat, pfgc | p)
in
end

end
