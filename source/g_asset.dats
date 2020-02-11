(*
###  g_asset.dats  ###

source file for dealing with assets
*)

#include "share/atspre_staload.hats"

staload "./g_asset.sats"

staload "./data/dict.sats"
staload "./data/list.sats"

val MAX_ASSET_HANDLERS = 512
and MAX_PATH_VARIABLES = 512

typedef asset_handler = @{
	t=type_id, extension=string, load_func=string -<cloref1> ptr, del_func=void -> void
}

var asset_handlers: arrszref(asset_handler)//[MAX_ASSET_HANDLERS]
var num_asset_handlers = 0

typedef path_variable = @{
	variable=fpath, mapping=fpath
}

var path_variables: arrszref(path_variable)//[MAX_PATH_VARIABLES]
var num_path_variables = 0

implement
asset_add_path_variable ( variable, mapping ) =
(
			if num_path_variables == MAX_PATH_VARIABLES then error("Already reached maximum num of path variables (%i)", MAX_PATH_VARIABLES)
			if variable.path[0] != '$' then error("Variables must start with a dollar sign e.g. '$CORANGE'")
			val pv = @{ variable=variable, mapping=mapping }: path_variable
			path_variables[num_path_variables] := pv
			num_path_variables = num_path_variables + 1
)

fn asset_map_fullpath ( filename: fpath ) : fpath  = let
   var out = @{ path="" }: fpath
   SDL_PathFullName (out.path, filename.path)
in
	out
end

fn asset_map_shortpath ( filename: fpath ) = let
	  var out = @{ path="" }: fpath
	  SDL_PathRelative (out.path, filename.path)
in
	out
end

implement asset_unmap_filename ( filename ) = let
	  val fullpath: fpath = asset_map_fullpath (filename)

	  fun iterate ( i: int ) : void =
	  (
	  if not i < num_path_variables then ()
	  else (
	       val variable: fpath = path_variables[i].variable
	      val mapping: fpath = path_variables[i].mapping
	      val fullmapping: fpath = asset_map_fullpath (mapping)

	      var subptr = strstr (fullpath.path, fullmapping.path)

	      if (subptr != ~1) then (
	     val sub: fpath = (); strcpy(sub.path, fullmapping.path)

	      val replace_len = strlen (variable.path)
	      val start_len = strlen (fullpath.path) - strlen (sub.path)
	      val ext_len = strlen (sub.path) - strlen (fullmapping.path)

	      fullpath.path[start_len] := '\0'
	      strcat (fullpath.path, variable.path)
	  	 strcat (fullpath.path, "/")
	  	 strcat (fullpath.path, sub.path + strlen (fullmapping.path))
	  )

		iterate ( i + 1 )
	  )
)
in
	iterate ( 0 ); asset_map_shortpath (fullpath)
end

implement asset_map_filename ( filename ) = let
asset_map_fullpath ( out )
in
val out: fpath = filename

fun iterate ( i: int ) : void = (
if not i < num_path_variables then ( () )
else (
val variable: fpath = path_variables[i].variable
val mapping: fpath = path_variables[i].mapping

val subptr: char ptr = strstr (out.path, variable.path)

if subptr then (
val sub: fpath = (); strcpy (sub.path, subptr)

val replace_len = strlen (mapping.path)
val start_len = strlen (out.path) - strlen (sub.path)
val ext_len = strlen (sub.path) - strlen (variable.path)

out.path[start_len] = '\0'
strcat (out.path, mapping.path)
strcat (out.path, sub.path + strlen (variable.path))
)
)
)
end

implement asset_hndl_null () = let
ah
in
var ah: asset_hndl = ()
ah.path = P("")
ah.path = null
ah.timestamp = 0
end

implement asset_hndl_new ( path ) = let
ah
in
var ah: asset_hndl = ()
ah.path = asset_map_filename (path)
ah.path = null
ah.timestamp = 0
end

implement asset_hndl_new_load ( path: fpath ) = let
ah
in
var ah: asset_hndl = asset_hndl_new (path)
if not file_isloaded (ah.path) then ( file_load (ah.path) )
end

implement asset_hndl_new_ptr ( as ) = let
ah
in
var ah: asset_hndl = ()
ah.path = P(asset_ptr_path(as))
ah.path = as
ah.timestamp = SDL_GetTicks()
end

implement asset_hndl_isnull ( ah ) = ( strcmp (ah->path.path, "") == 0 )

implement asset_hndl_path ( ah ) = ( ah->path )

implement asset_hndl_eq ( ah0, ah1 ) = ( strcmp (ah0->path.path, ah1->path.path) == 0 )

implement asset_hndl_ptr ( ah ) = (
if unlikely(ah->path.path[0] == '\0') then ( error ("Cannot load NULL asset handle"); null )
if likely(ah->timestamp > asset_timestamp) then ( ah->ptr )
else (
ah->ptr = dict_get (asset_dict, ah->path.path)
ah->timestamp = SDL_GetTicks ()

if likely (ah->timestamp > asset_timestamp) then  ah->ptr
else (
ah->ptr =
ah->timestamp =

if unlikely (ah->ptr = null) then error ( "Failed to get Asset '%s', is it loaded yet?", ah->path.path ); null
)
)
)

implement asset_cache_flush () = ( asset_timestamp = SDL_GetTicks() )

implement asset_init () = ( asset_dict = dict_new (1024); asset_cache_flush () )

implement asset_handler_delete ( h ) = free (h->extension); free (h);

implement delete_bucket_list ( b ) = (
if b == null then ( () )

delete_bucket_list (b->next)

debug ("Unloading: '%s'", b->key)

val ext: fpath = null
SDL_PathFileExtension (ext.path, b->key)

fun iterate ( i: int ) : void = (
if i < num_asset_handlers then (
val handler: asset_handler = asset_handlers[i]
if strcmp (ext.path, handler.extension) == 0 then (
bucket_delete_with ( b, handler.del_func )
)
iterate ( i + 1 )
)
else ( () )
)
iterate ( 0 )
)

implement asset_finish () = (
fun iterate_bucket ( i: int ) : void = (
if i < asset_dict->size then let delete_bucket_list (b); iterate_bucket ( i - 1); in val b: bucket ptr = asset_dict->buckets[i] end
else ( () )
)
fun iterate_free ( i: int ) : void = (
if i < num_asset_handlers then ( free( asset_handlers[num_asset_handlers].extension ); iterate_free; )
else ( () )
)
)

implement asset_handler_cast ( type, extension, asset_loader, asset_deleter ) =
(
if num_asset_handlers == MAX_ASSET_HANDLERS then ( warning ( "Max number of asset handlers reached.  Handler for extension '%s' not added.", extension ) )
else (
var h: asset_handler = ()
val c: char ptr = malloc( strlen( extension ) + 1 )
val () = strcpy ( c, extension )
h.type = type
h.extension = c
h.load_func = asset_loader
h.del_func = asset_deleter

asset_handlers[ num_asset_handlers ] := h
num_asset_handlers = num_asset_handlers + 1
)
)

implement file_load ( filename ) =

implement file_exists ( filename ) =

implement folder_load ( folder ) =

implement folder_load_recursive ( folder ) =

implement file_reload ( filename ) =

implement folder_reload ( folder ) =

implement file_unload ( filename ) =

implement folder_unload ( folder ) =

implement file_isloaded ( path ) =

implement asset_get_load ( path ) =

implement asset_get ( path ) =

implement asset_get_as_type ( path, type ) =

implement asset_reload_type_id ( type ) =

implement asset_reload_all () =

implement asset_ptr_path ( a ) =

implement asset_ptr_typename ( a ) =