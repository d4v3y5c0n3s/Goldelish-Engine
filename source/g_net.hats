(*
###  g_net.hats  ###

a basic networking layer
*)

#include "g_engine.hats"

fun net_init () : void = "sta#%"
fun net_finish () : void = "sta#%"

fun net_set_server ( server: bool ) : void = "sta#%"
fun net_is_server () : bool = "sta#%"
fun net_is_client () : bool = "sta#%"

datatype HTTP_ERR_TYPE =
	 | NONE of ()
	 | URL of ()
	 | HOST of ()
	 | SOCKET of ()
	 | DATA of ()
	 | NO_FILE of ()

fun net_http_get ( out: char ptr, max: int, fmt: char ptr, ... ) : int = "sta#%"
fun net_http_upload ( filename: char ptr, fmt: char ptr, ... ) : int = "sta#%"
