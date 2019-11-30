(*
###  config.hats  ###

defines configuration files
*)

#include "g_engine.hats"
#include "gasset.hats"
#include "data/dict.hats"

typedef config = @{ entries=dict ptr }

fun cfg_load_file ( filename: char ptr ) : config ptr = "sta#%"
fun cfg_save_file ( c: config ptr, filename: char ptr ) : void = "sta#%"
fun config_delete ( c: config ptr ) : void = "sta#%"

fun config_string ( c: config ptr, key: char ptr ) : char ptr = "sta#%"
fun config_int ( c: config ptr, key: char ptr ) : int = "sta#%"
fun config_float ( c: config ptr, key: char ptr ) : float = "sta#%"
fun config_bool ( c: config ptr, key: char ptr ) : bool = "sta#%"

fun config_set_string ( c: config ptr, key: char ptr, val: char ptr ) : void = "sta#%"
fun config_set_int ( c: config ptr, key: char ptr, val: int ) : void = "sta#%"
fun config_set_float ( c: config ptr, key: char ptr, val: float ) : void = "sta#%"
fun config_set_bool ( c: config ptr, key: val: bool ) : void = "sta#%"

fun option_graphics_asset ( c: config ptr, key: char ptr, high: asset_hndl, medium: asset_hndl, low: asset_hndl ) : asset_hndl = "sta#%"
fun option_graphics_int ( c: config ptr, key: char ptr, high: int, medium: int, low: int ) : int = "sta#%"
fun option_graphics_float ( c: config ptr, key: char ptr, high: float, medium: float, low: float ) : float = "sta#%"
