(*
###  dict.sats  ###

allows void pointers to be accessed with strings as keys
*)

staload "./../g_engine.sats"

(*  buckets (aka linked lists)  *)
absvt@ype bucket//typedef bucket = @{ key=string, item=ptr, next=ptr }

fn{a:vt@ype} bucket_new ( string, a ) : bucket

fn{a:vt@ype} bucket_map ( &bucket, (&a) -<cloref1> void ) : void
fn{a:vt@ype} bucket_filter_map ( b: &bucket, filter: !a -<cloref1> int, mapper: &a -<cloref1> void ) : void

fn{a:vt@ype} bucket_delete_with ( bucket, a -<cloref1> void ) : void
fn{a:vt@ype} bucket_delete_recursive ( b: bucket ) : void

fn{a:vt@ype} bucket_print ( b: !bucket ) : void

(*  dictionaries  *)
absvt@ype dict//typedef dict = @{ size=int, buckets=arrszref(bucket) }

fn dict_new {s:int | s > 0} ( int s ) : dict
fn dict_delete ( d: dict ) : void

fn dict_contains ( &dict, string ) : bool
fn{a:vt@ype} dict_get ( &dict, string ) : a
fn{a:vt@ype} dict_set ( &dict, string, a ) : void

fn{a:vt@ype} dict_remove_with ( &dict, string, a -<cloref1> void ) : void

fn{a:vt@ype} dict_map ( &dict, &a -<cloref1> void ) : void
fn{a:vt@ype} dict_filter_map ( d: &dict, filter: !a -> int, mapper: &a -<cloref1> void ) : void

fn dict_print ( d: !dict ) : void

fn{a:vt@ype} dict_find ( &dict, !a ) : string
