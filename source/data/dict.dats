(*
###  dict.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./dict.sats"

fn hash {n:int | n >= 0} ( s: string(n), size: int(n) ) : int = let
	fun hash_num {i:nat | i <= n} ( i: int i, h: int ) : int =
		if i < size then let
			val c_at_i = string_get_at_gint(s, i)
		in
			hash_num(i+1, h * 101 + g0int_of_char(c_at_i))
		end else h
in
	abs( hash_num(0, 0) ) % size
end
////
implmnt dict_new ( size ) =
