(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  config.sats  ###

defines configuration files
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../data/dict.sats"


absvtype config_entry = ptr
absvt0ype config

fn cfg_save_file ( c: !config, filename: string ) : void
fn cfg_load_file ( filename: string ) : Option_vt(config)

fn config_delete ( c: config ) : void
fn{a:vt@ype} config_get {k:int | k>0} ( c: !config, key: string(k) ) : a

fn{a:vt@ype} config_set {k:int | k>0} ( c: !config, key: string(k), value: a ) : void

fn{a:vt@ype} option_graphics {k:int | k>0} ( c: !config, key: string(k), high: a, medium: a, low: a ) : a
