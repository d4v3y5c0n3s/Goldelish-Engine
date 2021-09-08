(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_entity.sats  ###

This is an interface for interacting with entities
*)

staload "./g_engine.sats"

#define MAX_ENTITIES 512

absvt@ype entity_table
absvtype entity = ptr

fn entity_table_init () : entity_table
fn entity_table_finish ( entity_table ) : void

fn{} entity_table$retrieve () : entity_table
fn{} entity_table$return ( entity_table ) : void
fn{a:vt@ype} entity$create () : a
fn{a:vt@ype} entity$destroy ( e: a ) : void

fn{a:vt@ype} entity_new {s:int | s > 0} ( string(s) ) : void
fn entity_exists {s:int | s > 0} ( string(s) ) : bool
fn{a:vt@ype} entity_get {s:int | s > 0} ( string(s) ) : Option_vt(a)
fn entity_delete {s:int | s > 0} ( string(s) ) : void
