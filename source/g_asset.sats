(*
###  g_asset.sats  ###

This defines what an asset is in the context of the engine.
*)

#include "./g_engine.sats"

//  storable asset handle
absvt@ype asset_hndl

absvt@ype asset_handler

absvt@ype path_variable

fun{a:vtype} asset_hndl_null () : asset_hndl = "sta#"
fun{a:vtype} asset_hndl_new ( path: !fpath ) : asset_hndl = "sta#"
fun{a:vtype} asset_hndl_new_load ( path: !fpath ) : asset_hndl = "sta#"
fun{a:vtype} asset_hndl_new_ptr ( asset: !a ) : asset_hndl = "sta#"

fun{a:vtype} asset_hndl_isnull ( ah: &asset_hndl ) : bool = "sta#"
fun{a:vtype} asset_hndl_path ( ah: &asset_hndl ) : fpath = "sta#"
fun{a:vtype} asset_hndl_ptr ( ah: &asset_hndl ) : a = "sta#"
fun{a:vtype} asset_hndl_eq ( ah0: &asset_hndl, ah1: &asset_hndl ) : bool = "sta#"

fun asset_cache_flush ( asset_timestamp: &usint ) : void = "sta#"

//  map a variable such as '$GOLDELISH' to a path string
fun asset_add_path_variable ( variable: !fpath, mapping: !fpath ) : path_variable = "sta#"

fun asset_map_filename ( filename: fpath, pv: !path_variable ) : fpath = "sta#"
fun asset_unmap_filename ( filename: fpath, pv: !path_variable ) : fpath = "sta#"

//  load/reload/unload assets at path or folder
fun{a:vtype} file_load ( filename: !fpath, ah: &asset_hndl ) : a = "sta#"
fun{a:vtype} file_reload ( filename: !fpath, ah: &asset_hndl, asset_timestamp: &usint ) : a = "sta#"
fun file_exists ( path: !fpath ) : bool = "sta#"

fun{a:vtype} asset_get_load ( path: !fpath ) : a = "sta#"
fun{a:vtype} asset_get ( path: !fpath ) : a = "sta#"