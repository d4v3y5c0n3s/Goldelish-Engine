(*
###  dict.sats  ###

allows void pointers to be accessed with strings as keys
*)

#include "g_engine.sats"

(*  buckets (aka linked lists)  *)
typedef bucket = @{ key=string, item=ptr, next=ptr }

fun bucket_new {s:int} {l:addr | l > null} ( string: string s, item: ptr l ) : ptr

fun bucket_map {l:addr | l > null} ( b: ptr l, func: ptr -> void ) : void
fun bucket_filter_map {l:addr | l > null} ( b: ptr l, filter: ptr -> int, func: ptr -> void ) : void

fun bucket_delete_with {l:addr | l > null} ( b: ptr l, func: ptr -> void ) : void
fun bucket_delete_recursive {l:addr | l > null} ( b: ptr l ) : void

fun bucket_print {l:addr | l > null} ( b: ptr l ) : void

(*  dictionaries  *)
typedef dict = @{ size=int, buckets=arrszref(bucket) }

fun dict_new {a:int | a > 0} ( size: int a ) : ptr
fun dict_delete {l:addr | l > null} ( d: ptr l ) : void

fun dict_contains {l:addr | l > null} {s:int} ( d: ptr l, string: string s ) : bool
fun dict_get {l: addr | l > null} {s:int} ( d: ptr l, string: string s ) : ptr
fun dict_set {l1:addr | l1 > null} {s:int} {l2:addr | l2 > null} ( d: ptr l1, string: string s, item: ptr l2 ) : void

fun dict_remove_with {l:addr | l > null} {s:int} ( d: ptr l, string: string s, func: ptr -> void ) : void

fun dict_map {l:addr | l > null} ( d: ptr l, func: ptr -> void ) : void
fun dict_filter_map {l:addr | l > null} ( d: ptr l, filter: ptr -> int, func: ptr -> void ) : void

fun dict_print {l:addr | l > null} ( d: ptr l ) : void

fun dict_find {l1:addr | l1 > null} {l2:addr | l2 > null} ( d: ptr l1, item: ptr l2 ) : string
