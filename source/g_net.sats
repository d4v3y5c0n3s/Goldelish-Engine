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
| NONE of ()
| URL of ()
| HOST of ()
| SOCKET of ()
| DATA of ()
| NOFILE of ()

fn net_http_get ( nr: !net_running, out: string, max: int, fmt: List_vt(string) ) : HTTP_ERR = "sta#%"
fn net_http_upload ( nr: !net_running, filename: string, fmt: List_vt(string) ) : HTTP_ERR = "sta#%"
