(*
###  g_asset.sats  ###

This defines what an asset is in the context of the engine.
*)

#include "./g_engine.sats"

//abstype asset = ptr

//  storable asset handle
typedef asset_hndl = @{ path=fpath, asset_ptr=ptr, timestamp=usint }

fun asset_hndl_null () : asset_hndl = "sta#"
fun asset_hndl_new ( path: fpath ) : asset_hndl = "sta#"
fun asset_hndl_new_load ( path: fpath ) : asset_hndl = "sta#"
fun asset_hndl_new_ptr ( as: ptr ) : asset_hndl = "sta#"

fun asset_hndl_isnull ( ah: ptr ) : bool = "sta#"
fun asset_hndl_path ( ah: ptr ) : fpath = "sta#"
fun asset_hndl_ptr ( ah: ptr ) : ptr = "sta#"
fun asset_hndl_eq ( ah0: ptr, ah1: ptr ) : bool = "sta#"

fun asset_cache_flush () : void = "sta#"

//  init and finish operations
fun asset_init () : void = "sta#"
fun asset_finish () : void = "sta#"

//  map a variable such as '$GOLDELISH' to a path string
fun asset_add_path_variable ( variable: fpath, mapping: fpath ) : void = "sta#"

fun asset_map_filename ( filename: fpath ) : fpath = "sta#"
fun asset_unmap_filename ( filename: fpath ) : fpath = "sta#"

//  create handler for asset type
fun asset_handerler_cast ( type: type_id, extension: string, asset_loader: string -<cloref1> ptr, asset_deleter: ptr -<cloref1> void ) : void = "sta#"
fun{a,b,c,cc,d,dd:t@ype} asset_handler ( type: a, extension: b, loader: c -<cloref1> cc, deleter: d -<cloref1> dd ) : void = asset_handler_cast ( type, extension, loader, deleter )

//  load/reload/unload assets at path or folder
fun file_load ( filename: fpath ) : void = "sta#"
fun file_unload ( filename: fpath ) : void = "sta#"
fun file_reload ( filename: fpath ) : void = "sta#"
fun file_isloaded ( path: fpath ) : bool = "sta#"
fun file_exists ( path: fpath ) : bool = "sta#"

fun folder_load ( folder: fpath ) : void = "sta#"
fun folder_unload ( folder: fpath ) : void = "sta#"
fun folder_reload ( folder: fpath ) : void = "sta#"
fun folder_load_recursive ( folder: fpath ) : void = "sta#"

fun asset_get_load ( path: fpath ) : ptr = "sta#"
fun asset_get ( path: fpath ) : ptr = "sta#"

fun asset_get_as_type ( path: fpath, type: type_id ) : ptr = "sta#"
fun{p,t:t@ype} asset_get_as ( path: p, type: t ) : ptr = asset_get_as_type ( path, type )

//  reload all assets of a given type
fun asset_reload_type_id ( type: type_id ) : void = "sta#"
fun{a:t@ype} asset_reload_type ( type: a ) : void = asset_reload_type_id ( type )
fun asset_reload_all () : void = "sta#"

//  get path or typename of asset at ptr
fun asset_ptr_path ( a: ptr ) : string = "sta#"
fun asset_ptr_typename ( a: ptr ) : string = "sta#"
