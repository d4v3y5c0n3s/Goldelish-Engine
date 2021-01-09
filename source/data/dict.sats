(*
###  dict.sats  ###


*)

staload "./../g_engine.sats"

(*  buckets (aka linked lists)  *)
absvt@ype bucket(a:vt@ype)

fn{a:vt@ype} bucket_new ( string, a ) : bucket(a)

fn{a:vt@ype} bucket_map ( !bucket(a) ) : void
fn{a:vt@ype} bucket_filter_map ( b: !bucket(a) ) : void

fn{a:vt@ype} del_bucket_a ( x: a ): void
fn{a:vt@ype} map_bucket_a ( x: &a ): void
fn{a:vt@ype} filt_bucket_a ( x: !a ): bool
fn{a:vt@ype} str_of_bucket_a ( x: !a ): string

fn{a:vt@ype} bucket_delete_recursive ( b: bucket(a) ) : void

fn{a:vt@ype} bucket_print ( b: !bucket(a) ) : void

(*  dictionaries  *)
sortdef dsz = {s:int | s > 0}
absvt@ype dict(a:vt@ype, n:int)

fn{a:vt@ype} dict_new {s:dsz} ( int s ) : dict(a, s)
fn{a:vt@ype} dict_delete {s:dsz} ( d: dict(a, s) ) : void

fn{a:vt@ype} dict_contains {s:dsz} ( !dict(a, s), string s ) : bool
fn{a:vt@ype} dict_get {s:dsz} ( !dict(a, s), string s ) : Option_vt(a)
fn{a:vt@ype} dict_set {s:dsz} ( !dict(a, s), string s, a ) : void

fn{a:vt@ype} dict_remove {s:dsz} ( !dict(a, s), string s ) : void

fn{a:vt@ype} dict_map {s:dsz} ( !dict(a, s) ) : void
fn{a:vt@ype} dict_filter_map {s:dsz} ( d: !dict(a, s) ) : void

fn{a:vt@ype} dict_print {s:dsz} ( d: !dict(a, s) ) : void
