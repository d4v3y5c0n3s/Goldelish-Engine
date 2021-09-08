(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_asset.sats  ###

This defines what an asset is in the context of the engine.
*)

staload "./g_engine.sats"

//  storable asset handle
absvt@ype asset_hndl (a:vt@ype)

fn{a:vt@ype} asset$load_file ( filename: !fpath ): a
fn{a:vt@ype} asset$delete ( a ) : void

fn{a:vt@ype} asset_delete ( x: a ) : void
fn{a:vt@ype} asset_get ( filename: !fpath ): a

fn{a:vt@ype} asset_hndl_new ( filename: fpath ): asset_hndl(a)
fn{a:vt@ype} asset_hndl_get_path ( ah: asset_hndl(a) ): fpath
fn{a:vt@ype} asset_hndl_get_asset ( ah: asset_hndl(a) ): a
fn{a:vt@ype} asset_hndl_get ( ah: asset_hndl(a) ): ( fpath, a )
fn{a:vt@ype} asset_hndl_set_path ( ah: &asset_hndl(a), path: fpath ): void
fn{a:vt@ype} asset_hndl_set_asset ( ah: &asset_hndl(a), x: a ): void
