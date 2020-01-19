(*
###  dict.dats  ###


*)

#include "share/atspre_staload.hats"
staload "data/dict.sats"
staload UN = "prelude/SATS/unsafe.sats"

fun hash {n:int} {m:int | m > 0} ( s: string n, size: int m ) : int = let
    fun loop {i,j:int} .<i>. ( index: int i, h: int j ) : int = if (i >= 0) then (abs(h) % size) else (loop (index - 1, h * 101 + ))//<--  need to add the value for that char in the string here, check prelude lib
in
	loop
end

implement dict_new ( size ) =
(
)

implement dict_delete ( d ) =
(
)

implement dict_contains ( d, key ) =
(
)

implement dict_get ( d, key ) =
(
)

implement dict_set ( d, key, item ) =
(
)

implement dict_remove_with ( d, key, func ) =
(
)

implement dict_map ( d, func ) =
(
)

implement dict_filter_map ( d, filter, func ) =
(
)

implement dict_print ( d ) =
(
)

implement dict_find ( d, item ) =
(
)

implement bucket_new ( string, item ) =
(
)

implement bucket_map ( b, func ) =
(
)

implement bucket_filter_map ( b, filter, func ) =
(
)

implement bucket_delete_with ( b, func ) =
(
)

implement bucket_delete_recursive ( b ) =
(
)

implement bucket_print ( b ) =
(
)