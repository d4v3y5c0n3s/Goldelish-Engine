(*
###  dict.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./dict.sats"

fn hash {n:int | n > 0}
( s: string(n), size: int(n) ) : [o:int | o >= 0; o < n] int o = let
	fun hash_num {i:nat | i <= n}
	( i: int i, h: int ) : int =
		if i < size then let
			val c_at_i = string_get_at_gint(s, i)
		in
			hash_num(i+1, h * 101 + g0int_of_char(c_at_i))
		end else h
in
	g1int_nmod(abs(g1ofg0(hash_num(0, 0))), size)
end

local
assume dict(n:int) = [l:addr] @{ size=int n, buckets=arrayptr(bucket, l, n) }

datavtype BUCKET =
| bucket_empty of ()
| {a:vt@ype} bucket_filled of (Strptr1, a, BUCKET)

assume bucket = BUCKET
in

implmnt dict_new {s} ( size ) = let
    val size_st = size_of_int(size)
    val [b:addr] bucket_arr = arrayptr_make_uninitized<bucket>(size_st)
    fun init_arr {n:nat} .<n>.
    ( p: ptr, asz: size_t n ) : void = let
    in
        if asz > 0 then let
            val () = $UNSAFE.ptr0_set<bucket>(p, bucket_empty())
        in
            init_arr(ptr0_succ<bucket>(p), asz - size_of_int(1))
        end else ()
    end
    
    val () = init_arr(ptrcast(bucket_arr), size_st)
in
    @{size=size, buckets=$UNSAFE.castvwtp0{arrayptr(bucket, b, s)}(bucket_arr)}:dict(s)
end

implmnt dict_delete ( d ) = arrayptr_freelin(d.buckets, size_of_int(d.size))

implmnt dict_contains {s} ( d, key ) = let
    fn b_array_index {n:int}{i:nat | i < n}{l:addr}
    (ar: !arrayptr(bucket, l, n), i: int i) : bucket = let
        val p = ptrcast(ar)
    in
        $UNSAFE.ptr0_get<bucket>(ptr1_add_gint(p, i))
    end
    fun loop ( b: !bucket ) : bool = case+ b of
        | bucket_empty() => false
        | bucket_filled(str, _, next_bucket) => if eq_strptr_string(str, key) then true else loop(next_bucket)
    val d2 = d
    val index = hash(key, d2.size)
    val b_i = b_array_index(d2.buckets, index)
    val ret = loop(b_i)
    val () = bucket_delete_recursive(b_i)
    val () = d := d2
in
    ret
end

end////
implmnt{a} dict_get ( d, key ) =

implmnt{a} dict_set ( d, key, item ) =

implmnt{a} dict_remove_with ( d, key, remove_func ) =

implmnt{a} dict_map ( d, mapper ) =

implmnt{a} dict_filter_map ( d, filter, mapper ) =

implmnt dict_print ( d ) =

implmnt{a} dict_find ( d, item ) =

implmnt{a} bucket_new ( key, item ) =

implmn{a}{a} bucket_map ( b, mapper ) =

implmnt{a} bucket_filter_map ( b, filter, mapper ) =

implmnt{a} bucket_delete_with ( b, deleter ) =

implmnt{a} bucket_delete_recursive ( b ) =

implmnt{a} bucket_print ( b ) =

end
