(*
###  g_net.sats  ###

a basic networking layer
*)

staload "./g_engine.sats"

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

fun net_http_get ( out: string, max: int, fmt: string(*, ...  <- this means that there can be a variable number of arguements passed, could likely be modified to work with arrays/lists instead*) ) : int = "sta#%"
fun net_http_upload ( filename: string, fmt: string(*, ...*) ) : int = "sta#%"
