(*
###  dict.sats  ###

allows void pointers to be accessed with strings as keys
*)

staload "./../g_engine.sats"

(*  buckets (aka linked lists)  *)
absvt@ype bucket

fn{a:vt@ype} bucket_new ( string, a ) : bucket

fn{a:vt@ype} bucket_map ( &bucket ) : void
fn{a:vt@ype} bucket_filter_map ( b: &bucket ) : void

fn{a:vt@ype} del_bucket_a ( x: a ): void
fn{a:vt@ype} map_bucket_a ( x: &a ): void
fn{a:vt@ype} filt_bucket_a ( x: !a ): int

fn{a:vt@ype} bucket_delete_with ( bucket ) : void
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

fn{a:vt@ype} dict_remove {s:dsz} ( &dict(s), string s ) : void

fn{a:vt@ype} dict_map {s:dsz} ( &dict(s) ) : void
fn{a:vt@ype} dict_filter_map {s:dsz} ( d: &dict(s) ) : void

fn dict_print {s:dsz} ( d: !dict(s) ) : void
