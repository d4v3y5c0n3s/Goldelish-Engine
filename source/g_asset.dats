(*
###  g_asset.dats  ###

source file for dealing with assets
*)

#include "share/atspre_staload.hats"

staload "./g_asset.sats"
staload "./g_engine.sats"
staload "./SDL2/SDL_local.sats"

implmnt file_exists ( filename ) = let
  val mapped = map_fullpath(filename)
  val file = SDL_RWFromFile(fpath_string(mapped), "r")
in
  if ptr_isnot_null(file) then true
  else false
end

implmnt{a} asset_get ( filename ) = file_load<a>(filename)

local
assume asset_hndl (a:vt@ype) = [l:addr] @{ path=fpath, x=(a @ l, mfree_gc_v(l) | ptr l) }
in

implmnt{a} asset_hndl_new ( filename ) = let
	val (pfat, pfgc | pointer) = ptr_alloc<a>()
	val () = !pointer := asset_get(filename)
in
	@{path=filename, x=(pfat, pfgc | pointer)}:asset_hndl(a)
end

implmnt{a} asset_hndl_get_path ( ah ) = ah.path

implmnt{a} asset_hndl_get_asset ( ah ) = let
	val (pfat, pfgc | p) = ah.x
	val ret = !p
	val () = ptr_free(pfgc, pfat | p)
in
	ret
end

implmnt{a} asset_hndl_set_path ( ah, path ) = begin
	fpath_delete(ah.path);
	ah.path := path;
	()
end

implmnt{a} asset_hndl_set_asset ( ah, x ) = let
	val (pfat, pfgc | p) = ah.x
	val () = !p := x
	val () = ah.x := (pfat, pfgc | p)
in
end

end
////
implmnt map_fullpath ( filename ) = P(SDL_PathFullName(fpath_string(filename)))

implmnt map_shortpath ( filename ) = P(SDL_PathRelative(fpath_string(filename)))
