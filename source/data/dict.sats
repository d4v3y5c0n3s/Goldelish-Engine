(*
###  dict.sats  ###

allows void pointers to be accessed with strings as keys
*)

staload "./../g_engine.sats"

(*  buckets (aka linked lists)  *)
absvt@ype bucket

fn{a:vt@ype} bucket_new ( string, a ) : bucket

fn{a:vt@ype} bucket_map ( &bucket, (&a) -<cloref1> void ) : void
fn{a:vt@ype} bucket_filter_map ( b: &bucket, filter: !a -<cloref1> int, mapper: &a -<cloref1> void ) : void

fn{a:vt@ype} del_bucket_a ( x: a ): void//  implement this template for any type you wish to store in a dict

fn{a:vt@ype} bucket_delete_with ( bucket, a -<cloref1> void ) : void
fn{a:vt@ype} bucket_delete_recursive ( b: bucket ) : void

fn{a:vt@ype} bucket_print ( b: !bucket ) : void

(*  dictionaries  *)
sortdef dsz = {s:int | s > 0}
absvt@ype dict(n:int)

fn dict_new {s:dsz} ( int s ) : dict(s)
fn dict_delete {s:dsz} ( d: dict(s) ) : void

fn dict_contains {s:dsz} ( !dict(s), string s ) : bool
fn dict_get {s:dsz} ( !dict(s), string s ) : [a:vt@ype] Option_vt(a)
fn{a:vt@ype} dict_set {s:dsz} ( &dict(s), string s, a ) : void

fn{a:vt@ype} dict_remove_with {s:dsz} ( &dict(s), string s, a -<cloref1> void ) : void

fn{a:vt@ype} dict_map {s:dsz} ( &dict(s), &a -<cloref1> void ) : void
fn{a:vt@ype} dict_filter_map {s:dsz} ( d: &dict(s), filter: !a -> int, mapper: &a -<cloref1> void ) : void

fn dict_print {s:dsz} ( d: !dict(s) ) : void

fn{a:vt@ype} dict_find {s:dsz} ( !dict(s), !a ) : string
