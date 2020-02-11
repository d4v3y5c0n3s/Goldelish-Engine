(*
###  dict.dats  ###


*)

#include "share/atspre_staload.hats"
staload "./data/dict.sats"
staload UN = "prelude/SATS/unsafe.sats"

fun hash {n:int} {m:int | m > 0} ( s: string n, size: int m ) : int = let
    fun loop {i,j:int} .<i>. ( index: int i, h: int j ) : int =
    	if (i >= 0)
	   then (abs(h) % size)
	   	else (loop (index - 1, h * 101 + char2int($UN.string_get_at(s, index))))
in
	loop (m, 0)
end

implement {a} dict_new ( size ) = let
	  val d = malloc_gc ( sizeof<dict> )
	  //d->size := size
	  //d->buckets :=
in
	d
end
(*psuedo:
takes in a size for the new dictionary
returns a pointer to this new dictionary
*)
(*  figure out:
 - how to use malloc & free in ATS
 - how to properly set the values of the pointers
 - how to use linear logic to keep things safe here
*)

implement dict_delete ( d ) =
(
)
(*psuedo:
takes in a pointer to a dict
deletes that dict/ptr
returns void
*)

implement dict_contains ( d, key ) =
(
)
(*psuedo:
takes in a ptr to a dict & a string
returns true if there is an entry for that string
returns false if not
*)

implement dict_get ( d, key ) =
(
)
(*psuedo:
takes in a ptr to a dict & a string
returns whatever is at that string within that dict
*)

implement dict_set ( d, key, item ) =
(
)
(*psuedo:
takes in a ptr to a dict, a string key, & a ptr to something to store at that key
returns void
*)

implement dict_remove_with ( d, key, func ) =
(
)
(*psuedo:
takes in a ptr to a dict, a string key, & a function that takes in the dict ptr and returns void
calls the higher-order function to deal with deleting that specific item in the dict
returns void
*)

implement dict_map ( d, func ) =
(
)
(*psuedo:

*)

implement dict_filter_map ( d, filter, func ) =
(
)
(*psuedo:
*)

implement dict_print ( d ) =
(
)
(*psuedo:
*)

implement dict_find ( d, item ) =
(
)
(*psuedo:
*)

implement bucket_new ( string, item ) =
(
)
(*psuedo:
*)

implement bucket_map ( b, func ) =
(
)
(*psuedo:
*)

implement bucket_filter_map ( b, filter, func ) =
(
)
(*psuedo:
*)

implement bucket_delete_with ( b, func ) =
(
)
(*psuedo:
*)

implement bucket_delete_recursive ( b ) =
(
)
(*psuedo:
*)

implement bucket_print ( b ) =
(
)
(*psuedo:
*)