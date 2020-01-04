(*
###  config.sats  ###

defines configuration files
*)

#include "g_engine.sats"
#include "gasset.sats"
#include "data/dict.sats"

typedef config = @{ entries=dict ptr }

fun cfg_load_file ( filename: string ) : config ptr = "sta#%"
fun cfg_save_file ( c: config ptr, filename: string ) : void = "sta#%"
fun config_delete ( c: config ptr ) : void = "sta#%"

fun config_string ( c: config ptr, key: string ) : string = "sta#%"
fun config_int ( c: config ptr, key: string ) : int = "sta#%"
fun config_float ( c: config ptr, key: string ) : float = "sta#%"
fun config_bool ( c: config ptr, key: string ) : bool = "sta#%"

fun config_set_string ( c: config ptr, key: string, val: string ) : void = "sta#%"
fun config_set_int ( c: config ptr, key: string, val: int ) : void = "sta#%"
fun config_set_float ( c: config ptr, key: string, val: float ) : void = "sta#%"
fun config_set_bool ( c: config ptr, key: val: bool ) : void = "sta#%"

fun option_graphics_asset ( c: config ptr, key: string, high: asset_hndl, medium: asset_hndl, low: asset_hndl ) : asset_hndl = "sta#%"
fun option_graphics_int ( c: config ptr, key: string, high: int, medium: int, low: int ) : int = "sta#%"
fun option_graphics_float ( c: config ptr, key: string, high: float, medium: float, low: float ) : float = "sta#%"
