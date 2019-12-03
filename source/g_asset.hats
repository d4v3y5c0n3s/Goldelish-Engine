(*
###  g_asset.hats  ###

This defines what an asset is in the context of the engine.
*)

#include "g_engine.hats"

typedef asset = void//  double-check this later

//  storable asset handle
typedef asset_hndl = @{ path=fpath, ptr=asset ptr, timestamp=uint32_t }

fun asset_hndl_null () : asset_hndl = "sta#%"
fun asset_hndl_new ( path: fpath ) : asset_hndl = "sta#%"
fun asset_hndl_new_load ( path: fpath ) : asset_hndl = "sta#%"
fun asset_hndl_new_ptr ( as: asset ptr ) : asset_hndl = "sta#%"

fun asset_hndl_isnull ( ah: asset_hndl ptr ) : bool = "sta#%"
fun asset_hndl_path ( ah: asset_hndl ptr ) : fpath = "sta#%"
fun asset_hndl_ptr ( ah: asset_hndl ptr ) : asset ptr = "sta#%"
fun asset_hndl_eq ( ah0: asset_hndl ptr, ah1: asset_hndl ptr ) : bool = "sta#%"

fun asset_cache_flush () : void = "sta#%"

//  init and finish operations
fun asset_init () : void = "sta#%"
fun asset_finish () : void = "sta#%"

//  map a variable such as '$GOLDELISH' to a path string
fun asset_add_path_variable ( variable: fpath, mapping: fpath ) : void = "sta#%"

fun asset_map_filename ( filename: fpath ) : fpath = "sta#%"
fun asset_unmap_filename ( filename: fpath ) : fpath = "sta#%"

//  create handler for asset type; requires type, file extension, and load/unload functions
(*
#define asset_handler(type, extension, loader, deleter) \
  asset_handler_cast(typeid(type), extension, \
  (asset*(*)(const char*))loader , \
  (asset(*)(void*))deleter)

void asset_handler_cast(
  type_id type, const char* extension,
  asset* asset_loader(const char* filename) ,
  void asset_deleter(asset* asset) );
  );
*)

//  load/reload/unload assets at path or folder
fun file_load ( filename: fpath ) : void = "sta#%"
fun file_unload ( filename: fpath ) : void = "sta#%"
fun file_reload ( filename: fpath ) : void = "sta#%"
fun file_isloaded ( path: fpath ) : bool = "sta#%"
fun file_exists ( path: fpath ) : bool = "sta#%"

fun folder_load ( folder: fpath ) : void = "sta#%"
fun folder_unload ( folder: fpath ) : void = "sta#%"
fun folder_reload ( folder: fpath ) : void = "sta#%"
fun folder_load_recursive ( folder: fpath ) : void = "sta#%"

fun asset_get_load ( path: fpath ) : asset ptr = "sta#%"
fun asset_get ( path: fpath ) : asset ptr = "sta#%"

//define asset_get_as(path, type) ((type*)asset_get_as_type(path, typeid(type)))
fun asset_get_as_type ( path: fpath, type: type_id ) : asset ptr = "sta#%"

//  reload all assets of a given type
//define asset_reload_type(type) asset_reload_type_id(typeid(type))
fun asset_reload_type_id ( type: type_id ) : void = "sta#%"
fun asset_reload_all () : void = "sta#%"

//  get path or typename of asset at ptr
fun asset_ptr_path ( a: asset ptr ) : char ptr = "sta#%"
fun asset_ptr_typename ( a: asset ptr ) : char ptr = "sta#%"
