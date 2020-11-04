(*
###  int_list.sats  ###

a dynamically resizable array of integers
*)

staload "./../g_engine.sats"

typedef int_list = @{ num_items=int, num_slots=int, items=(*int*) ptr }

fun int_list_new () : (*int_list*) ptr = "sta#%"
fun int_list_delete () : void = "sta#%"

fun int_list_push_back ( l: (*int_list*) ptr, item: int ) : void = "sta#%"
fun int_list_pop_back ( l: (*int_list*) ptr ) : int = "sta#%"

fun int_list_get ( l: (*int_list*) ptr, index: int ) : int = "sta#%"
fun int_list_set ( l: (*int_list*) ptr, index: int, item: int ) : void = "sta#%"

fun int_list_is_empty ( l: (*int_list*) ptr ) : bool = "sta#%"

fun int_list_clear ( l: (*int_list*) ptr ) : void = "sta#%"
