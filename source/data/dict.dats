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

fn b_array_index {n:int}{i:nat | i < n}{l:addr}
(ar: !arrayptr(bucket, l, n), i: int i) : bucket = let
    val p = ptrcast(ar)
in
    $UNSAFE.ptr0_get<bucket>(ptr1_add_gint(p, i))
end

fn b_array_mutate {n:int}{i:nat | i < n}{l:addr}
(ar: !arrayptr(bucket, l, n), i: int i, x: bucket) : void = let
    val p = ptrcast(ar)
in
    $UNSAFE.ptr0_set<bucket>(ptr1_add_gint(p, i), x)
end

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
    fun loop ( b: !bucket ) : bool = case+ b of
        | bucket_empty() => false
        | bucket_filled(str, _, next_bucket) => if eq_strptr_string(str, key) then true else loop(next_bucket)
    val d2 = d
    val index = hash(key, d2.size)
    val b_i = b_array_index(d2.buckets, index)
    val ret = loop(b_i)
    val () = d := d2
    prval () = _consume_buk(b_i) where {
        extern praxi _consume_buk( b: bucket ): void
    }
in
    ret
end

implmnt dict_get ( d, key ) = let
    fun loop
    ( b: !bucket ) : [a:vt@ype] Option_vt(a) =
    case+ b of
        | bucket_empty() => None_vt()
        | bucket_filled(str, x, next_bucket) =>
            if eq_strptr_string(str, key) then Some_vt(gcopy_val(x))
            else loop(next_bucket)
    val d2 = d
    val index = hash(key, d2.size)
    val b_i = b_array_index(d2.buckets, index)
    val ret = loop(b_i)
    val () = d := d2
    prval () = _consume_buk(b_i) where {
        extern praxi _consume_buk( b: bucket ): void
    }
in
    ret
end

implmnt{a} dict_set ( d, key, item ) = {
    fun loop ( b: &bucket, itm: a ) : void =
    case+ b of
        | ~bucket_empty() => b := bucket_filled($UNSAFE.castvwtp0{Strptr1}(key), itm, bucket_empty())
        | @bucket_filled(str, x, next_bucket) =>
            if eq_strptr_string(str, key) then {
                val b2 = bucket_filled(str, itm, next_bucket)
                val () = del_bucket_a(x)
                val () = free@(b)
                val () = b := b2
            }
            else {
                val () = loop(next_bucket, itm)
                prval () = fold@(b)
            }
    val d2 = d
    val index = hash(key, d2.size)
    var new_b = b_array_index(d2.buckets, index)
    val () = loop(new_b, item)
    val () = b_array_mutate(d2.buckets, index, new_b)
    val () = d := d2
}

implmnt{a} dict_remove ( d, key ) = {
    fun loop ( b: &bucket ) : void =
        case+ b of
        | bucket_empty() => ()
        | @bucket_filled(str, x, next_bucket) =>
        if eq_strptr_string(str, key) then {
            val nb = next_bucket
            val () = del_bucket_a(x)
            val () = strptr_free(str)
            val () = free@(b)
            val () = b := nb
        } else {
            val () = loop(next_bucket)
            prval () = fold@(b)
        }
    val d2 = d
    val index = hash(key, d2.size)
    var b_i = b_array_index(d2.buckets, index)
    val () = loop(b_i)
    val () = d := d2
    prval () = _consume_buk(b_i) where {
        extern praxi _consume_buk( b: bucket ): void
    }
}

implmnt{a} dict_map ( d ) = {
    fun loop {l:addr} {n,i:int | 0 <= i+1; i+1 <= n} .<i+1>.
    ( arr: !arrayptr(bucket, l, n), i: int i ): void =
    if i >= 0 then {
        var b = b_array_index(arr, i)
        val () = bucket_map(b)
        prval () = _consume_buk(b) where {
            extern praxi _consume_buk( b: bucket ): void
        }
        val () = loop(arr, i-1)
    } else ()
    val d2 = d
    val () = loop(d2.buckets, d2.size-1)
    val () = d := d2
}

implmnt{a} dict_filter_map ( d ) = {
    fun loop {l:addr} {n,i:int | 0 <= i+1; i+1 <= n} .<i+1>.
    ( arr: !arrayptr(bucket, l, n), i: int i ): void =
    if i >= 0 then {
        var b = b_array_index(arr, i)
        val () = bucket_filter_map(b)
        prval () = _consume_buk(b) where {
            extern praxi _consume_buk( b: bucket ): void
        }
        val () = loop(arr, i-1)
    } else ()
    val d2 = d
    val () = loop(d2.buckets, d2.size-1)
    val () = d := d2
}

implmnt dict_print ( d ) = {
    fun loop {l:addr} {n,i:int | 0 <= i+1; i+1 <= n} .<i+1>.
    ( arr: !arrayptr(bucket, l, n), i: int i ): void =
    if i >= 0 then {
        var b = b_array_index(arr, i)
        val () = print(i)
        val () = print(" - ")
        val () = bucket_print(b)
        val () = print("\n")
        prval () = _consume_buk(b) where {
            extern praxi _consume_buk( b: bucket ): void
        }
        val () = loop(arr, i-1)
    } else ()
    val d2 = d
    val () = loop(d2.buckets, d2.size-1)
    val () = d := d2
}

implmnt{a} bucket_new ( key, item ) = bucket_filled($UNSAFE.castvwtp0{Strptr1}(key), item, bucket_empty())
(*
implmnt{a} bucket_map ( b ) =
    case+ b of
    | bucket_empty() => ()
    | bucket_filled(_, x, next_bucket) => {
        var x2 = x
        val () = map_bucket_a(x2)
        val () = x := x2
        val () = del_bucket_a(x2)
        val () = bucket_map(next_bucket)
    }
*)
//implmnt{a} bucket_filter_map ( b ) =

//implmnt{a} bucket_delete_with ( b ) =

//implmnt{a} bucket_delete_recursive ( b ) =//  this should have the "potentially infinite recursion" effect

//implmnt{a} bucket_print ( b ) =

end
