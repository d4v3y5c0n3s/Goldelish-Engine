(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_net.sats  ###

a basic networking layer
*)

staload "./g_engine.sats"

absvt0ype net_running

fn net_init () : Option_vt(net_running) = "sta#%"
fn net_finish ( net_running ) : void = "sta#%"

fn net_set_server ( nr: &net_running, server: bool ) : void = "sta#%"
fn net_is_server ( !net_running ) : bool = "sta#%"
fn net_is_client ( !net_running ) : bool = "sta#%"

datavtype HTTP_ERR =
| HTTP_ERR_NONE of ()
| HTTP_ERR_URL of ()
| HTTP_ERR_HOST of ()
| HTTP_ERR_SOCKET of ()
| HTTP_ERR_DATA of ()
| HTTP_ERR_NOFILE of ()

fn net_http_get ( nr: &net_running, out: !Strptr1 >> _, max: int, host_b: Strptr1, path_b: Strptr1 ) : HTTP_ERR = "sta#%"
fn net_http_upload ( nr: &net_running, inpt: !Strptr1, host_b: Strptr1, path_b: Strptr1 ) : HTTP_ERR = "sta#%"
