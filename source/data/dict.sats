(*
###  dict.sats  ###


*)

staload "./../g_engine.sats"

(*  buckets (aka linked lists)  *)
absvt@ype bucket(a:vt@ype)

fn{a:vt@ype} bucket_new ( string, a ) : bucket(a)

fn{a:vt@ype} bucket_map ( !bucket(a) ) : void
fn{a:vt@ype} bucket_filter_map ( b: !bucket(a) ) : void

fn{a:vt@ype} bucket_item$delete ( x: a ): void
fn{a:vt@ype} bucket_item$map ( x: &a ): void
fn{a:vt@ype} bucket_item$filter ( x: !a ): bool
fn{a:vt@ype} bucket_item$to_string ( x: !a ): string

fn{a:vt@ype} bucket_delete_recursive ( b: bucket(a) ) : void

fn{a:vt@ype} bucket_print ( b: !bucket(a) ) : void

(*  dictionaries  *)
sortdef dsz = {s:int | s > 0}
absvt@ype dict(a:vt@ype, n:int)

fn{a:vt@ype} dict_new {s:dsz} ( int s ) : dict(a, s)
fn{a:t@ype} dict_delete {s:dsz} ( d: dict(a, s) ) : void
fn{a:vt@ype} dict_delete_lin {s:dsz} ( d: dict(a, s) ) : void
fn{a:vt@ype} dict_delete_fun {s:dsz} ( d: dict(a, s), (a) -> void ) : void

fn{a:vt@ype} dict_contains {s:dsz}{n:int | n>0} ( !dict(a, s), string(n) ) : bool
fn{a:vt@ype} dict_get {s:dsz}{n:int | n>0} ( !dict(a, s), string(n) ) : Option_vt(a)
fn{a:t@ype} dict_set {s:dsz}{n:int | n>0} ( !dict(a, s), string(n), a ) : void
fn{a:vt@ype} dict_set_lin {s:dsz}{n:int | n>0} ( !dict(a, s), string(n), a ) : void
fn{a:vt@ype} dict_set_fun {s:dsz}{n:int | n>0} ( !dict(a, s), string(n), a, (a) -> void ) : void

fn{a:t@ype} dict_remove {s:dsz}{n:int | n>0} ( !dict(a, s), string(n) ) : void
fn{a:vt@ype} dict_remove_lin {s:dsz}{n:int | n>0} ( !dict(a, s), string(n) ) : void
fn{a:vt@ype} dict_remove_fun {s:dsz}{n:int | n>0} ( !dict(a, s), string(n), (a) -> void ) : void

fn{a:vt@ype} dict_bucket_operate {s:dsz} ( !dict(a, s) ) : void
fn{a:vt@ype} dict_map {s:dsz} ( !dict(a, s) ) : void
fn{a:vt@ype} dict_map_fun {s:dsz} ( !dict(a, s), (&a) -> void ) : void
fn{a:vt@ype} dict_filter_map {s:dsz} ( d: !dict(a, s) ) : void
fn{a:vt@ype} dict_filter_map_fun {s:dsz} ( d: !dict(a, s), (!a) -> bool, (&a) -> void ) : void

fn{a:vt@ype} dict_print {s:dsz} ( d: !dict(a, s) ) : void
fn{a:vt@ype} dict_print_fun {s:dsz} ( d: !dict(a, s), (!a) -> string ) : void
