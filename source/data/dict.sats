(*
###  dict.sats  ###

allows *void to be accessed with *char as keys
*)

#include "g_engine.sats"

(*  buckets (aka linked lists)  *)
typedef bucket = @{ key=string, item=ptr, next=bucket ptr }

fun bucket_new ( string: string, item: ptr ) : bucket ptr = "sta#%"

fun bucket_map ( b: bucket ptr, func: ptr -> void ) : void = "sta#%"
fun bucket_filter_map ( b: bucket ptr, filter: ptr -> int, func: ptr -> void ) : void = "sta#%"

fun bucket_delete_with ( b: bucket ptr, func: ptr -> void ) : void = "sta#%"
fun bucket_delete_recursive ( b: bucket ptr ) : void = "sta#%"

fun bucket_print ( b: bucket ptr ) : void = "sta#%"

(*  dictionaries  *)
typedef dict = @{ size=int, buckets=bucket ptr ptr }

fun dict_new ( size: int ) : dict ptr = "sta#%"
fun dict_delete ( d: dict ptr ) : void = "sta#%"

fun dict_contains ( d: dict ptr, string: string ) : bool = "sta#%"
fun dict_get ( d: dict ptr, string: string ) : ptr = "sta#%"
fun dict_set ( d: dict ptr, string: string, item: ptr ) : void = "sta#%"

fun dict_remove_with ( d: dict ptr, string: string, func: ptr -> void ) : void = "sta#%"

fun dict_map ( d: dict ptr, func: ptr -> void ) : void = "sta#%"
fun dict_filter_map ( d: dict ptr, filter: ptr -> int, func: ptr -> void ) : void = "sta#%"

fun dict_print ( d: dict ptr ) : void = "sta#%"

fun dict_find ( d: dict ptr, item: ptr ) : string = "sta#%"
