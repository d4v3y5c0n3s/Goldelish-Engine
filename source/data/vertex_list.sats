(*
###  vertex_list.sats  ###

a dynamically resizable array of vertices
*)

staload "./../g_engine.sats"

typedef vertex_list = @{ num_items=int, num_slots=int, items=(*vertex*) ptr }

fun vertex_list_new () : (*vertex_list*) ptr = "sta#%"
fun vertex_list_delete ( l: (*vertex_list*) ptr ) : void = "sta#%"

fun vertex_list_push_back ( l: (*vertex_list*) ptr, item: vertex ) : void = "sta#%"
fun vertex_list_pop_back ( l: (*vertex_list*) ptr ) : vertex = "sta#%"

fun vertex_list_get ( l: (*vertex_list*) ptr, index: int ) : vertex = "sta#%"
fun vertex_list_set ( l: (*vertex_list*) ptr, index: int, item: vertex ) : void = "sta#%"

fun vertex_list_clear ( l: (*vertex_list*) ptr ) : void = "sta#%"
