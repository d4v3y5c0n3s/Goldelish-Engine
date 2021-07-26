(*
###  dict.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./dict.sats"

fn hash {n:int | n>0}{s:int | s>0}
( s: string(s), size: int(n) ) : [o:int | o >= 0; o < n] int o = let
	fun hash_num {i:nat | i <= s}
	( i: int i, h: int, str_sz: int(s) ) : int =
		if i < str_sz then let
			val c_at_i = string_get_at_gint(s, i)
		in
			hash_num(i+1, h * 101 + g0int_of_char(c_at_i), str_sz)
		end else h
in
	g1int_nmod(abs(g1ofg0(hash_num(0, 0, sz2i(strlen(s))))), size)
end

local

datavtype BUCKET (a:vt@ype) =
| bucket_empty of ()
| bucket_filled of (Strptr1, a, BUCKET(a))

assume bucket(a:vt@ype) = BUCKET(a)

assume dict(a:vt@ype, n:int) =
@{
    size=int n,
    buckets=arrayptr(bucket(a), n)
}

extern fn{a:vt@ype} bucket_operate ( !bucket(a) ) : void

in

implmnt{a} dict_new {s} ( size ) = let
    val size_st = size_of_int(size)
    val bucket_arr = arrayptr_make_uninitized<bucket(a)>(size_st)
    implmnt array_initize$init<bucket(a)> (i, x) = x := bucket_empty()
    val () = arrayptr_initize(bucket_arr, size_st)
in
    @{size=size, buckets=bucket_arr}:dict(a, s)
end

implmnt{a} dict_delete ( d ) = let
  implmnt bucket_item$delete<a> ( x ) = ()
in
  dict_delete_lin(d)
end

implmnt{a} dict_delete_lin ( d ) = let
  implmnt array_uninitize$clear<bucket(a)> (i, x) = bucket_delete_recursive<a>(x)
in
  arrayptr_freelin(d.buckets, size_of_int(d.size))
end

implmnt{a} dict_delete_fun ( d, dltr ) = let
  implmnt bucket_item$delete<a> ( x ) = dltr(x)
in
  dict_delete_lin(d)
end

implmnt{a} dict_contains {s} ( d, key ) = let
    fun loop ( b: !bucket(a) ) : bool = case+ b of
        | bucket_empty() => false
        | bucket_filled(str, _, next_bucket) => if eq_strptr_string(str, key) then true else loop(next_bucket)
    val index = hash(key, d.size)
    val (pf_ar | ar_p) = arrayptr_takeout_viewptr(d.buckets)
    val (ari_pf, ari_fpf | ar_i) = array_ptr_takeout(pf_ar | ar_p, size_of_int(index))
    val ret = loop(!ar_i)
    prval () = pf_ar := ari_fpf(ari_pf)
    prval () = arrayptr_addback(pf_ar | d.buckets)
in
    ret
end

implmnt{a} dict_get ( d, key ) = let
    fun loop
    ( b: &bucket(a) ) : Option_vt(a) =
    case+ b of
        | bucket_empty() => None_vt()
        | @bucket_filled(str, x, next_bucket) =>
            if eq_strptr_string(str, key) then let
              val nb = next_bucket
              val () = strptr_free(str)
              val ret = x
              val () = free@(b)
              val () = b := nb
            in
              Some_vt(ret)
            end else let
              val ret = loop(next_bucket)
              prval () = fold@(b)
            in
              ret
            end
    val index = hash(key, d.size)
    val (pf_ar | ar_p) = arrayptr_takeout_viewptr(d.buckets)
    val (ari_pf, ari_fpf | ar_i) = array_ptr_takeout(pf_ar | ar_p, size_of_int(index))
    val ret = loop(!ar_i)
    prval () = pf_ar := ari_fpf(ari_pf)
    prval () = arrayptr_addback(pf_ar | d.buckets)
in
    ret
end

implmnt{a} dict_set ( d, key, item ) = let
  implmnt bucket_item$delete<a> ( x ) = ()
in
  dict_set_lin(d, key, item)
end

implmnt{a} dict_set_lin ( d, key, item ) = {
    fun loop ( b: &bucket(a), itm: a ) : void =
    case+ b of
        | ~bucket_empty() => b := bucket_filled($UNSAFE.castvwtp0{Strptr1}(key), itm, bucket_empty())
        | @bucket_filled(str, x, next_bucket) =>
            if eq_strptr_string(str, key) then {
                val b2 = bucket_filled(str, itm, next_bucket)
                val () = bucket_item$delete(x)
                val () = free@(b)
                val () = b := b2
            }
            else {
                val () = loop(next_bucket, itm)
                prval () = fold@(b)
            }
    val index = hash(key, d.size)
    val (pf_ar | ar_p) = arrayptr_takeout_viewptr(d.buckets)
    val (ari_pf, ari_fpf | ar_i) = array_ptr_takeout(pf_ar | ar_p, size_of_int(index))
    val () = loop(!ar_i, item)
    prval () = pf_ar := ari_fpf(ari_pf)
    prval () = arrayptr_addback(pf_ar | d.buckets)
}

implmnt{a} dict_set_fun ( d, key, item, dltr ) = let
  implmnt bucket_item$delete<a> ( x ) = dltr(x)
in
  dict_set_lin(d, key, item)
end

implmnt{a} dict_remove ( d, key ) = let
  implmnt bucket_item$delete<a> ( x ) = ()
in
  dict_remove_lin(d, key)
end

implmnt{a} dict_remove_lin ( d, key ) = {
    fun loop ( b: &bucket(a) ) : void =
        case+ b of
        | bucket_empty() => ()
        | @bucket_filled(str, x, next_bucket) =>
        if eq_strptr_string(str, key) then {
            val nb = next_bucket
            val () = bucket_item$delete(x)
            val () = strptr_free(str)
            val () = free@(b)
            val () = b := nb
        } else {
            val () = loop(next_bucket)
            prval () = fold@(b)
        }
    val index = hash(key, d.size)
    val (pf_ar | ar_p) = arrayptr_takeout_viewptr(d.buckets)
    val (ari_pf, ari_fpf | ar_i) = array_ptr_takeout(pf_ar | ar_p, size_of_int(index))
    val () = loop(!ar_i)
    prval () = pf_ar := ari_fpf(ari_pf)
    prval () = arrayptr_addback(pf_ar | d.buckets)
}

implmnt{a} dict_remove_fun ( d, key, dltr ) = let
  implmnt bucket_item$delete<a> ( x ) = dltr(x)
in
  dict_remove_lin(d, key)
end

implmnt{a} dict_bucket_operate ( d ) = {
  fun loop {n,i:int | 0 <= i+1; i+1 <= n} .<i+1>.
  ( arr: !arrayptr(bucket(a), n), i: int i ): void =
  if i >= 0 then {
    val (pf_ar | ar_p) = arrayptr_takeout_viewptr(arr)
    val (ari_pf, ari_fpf | ar_i) = array_ptr_takeout(pf_ar | ar_p, size_of_int(i))
    val () = bucket_operate<a>(!ar_i)
    prval () = pf_ar := ari_fpf(ari_pf)
    prval () = arrayptr_addback(pf_ar | arr)
    val () = loop(arr, i-1)
  } else ()
  val () = loop(d.buckets, d.size-1)
}

implmnt{a} dict_map ( d ) = let
  implmnt bucket_operate<a> ( b ) = bucket_map(b)
in
  dict_bucket_operate(d)
end

implmnt{a} dict_map_fun ( d, mpr ) = let
  implmnt bucket_item$map<a>( x ) = mpr(x)
in
  dict_map(d)
end

implmnt{a} dict_filter_map ( d ) = let
  implmnt bucket_operate<a> ( b ) = bucket_filter_map(b)
in
  dict_bucket_operate(d)
end

implmnt{a} dict_filter_map_fun ( d, fltr, mpr ) = let
  implmnt bucket_item$filter<a> ( x ) = fltr(x)
  implmnt bucket_item$map<a> ( x ) = mpr(x)
in
  dict_filter_map(d)
end

implmnt{a} dict_print ( d ) = let
  implmnt bucket_operate<a> ( b ) = bucket_print(b)
in
  dict_bucket_operate(d)
end

implmnt{a} dict_print_fun ( d, tstr ) = let
  implmnt bucket_item$to_string<a> (x) = tstr(x)
in
  dict_print(d)
end

implmnt{a} bucket_new ( key, item ) = bucket_filled($UNSAFE.castvwtp0{Strptr1}(key), item, bucket_empty())

implmnt{a} bucket_map ( b ) =
  case+ b of
  | bucket_empty() => ()
  | @bucket_filled(_, x, next_bucket) => {
    val () = bucket_item$map(x)
    val () = bucket_map(next_bucket)
    prval () = fold@(b)
  }

implmnt{a} bucket_filter_map ( b ) =
  case+ b of
  | bucket_empty() => ()
  | @bucket_filled(_, x, next_bucket) =>
  if bucket_item$filter(x) then {
      val () = bucket_item$map(x)
      val () = bucket_filter_map(next_bucket)
      prval () = fold@(b)
  }
  else {
    val () = bucket_filter_map(next_bucket)
    prval () = fold@(b)
  }

implmnt{a} bucket_delete_recursive ( b ) =
    case+ b of
    | ~bucket_empty() => ()
    | ~bucket_filled(str, x, next_bucket) => let
        val () = strptr_free(str)
        val () = bucket_item$delete(x)
    in
        bucket_delete_recursive(next_bucket)
    end

implmnt{a} bucket_print ( b ) =
    case+ b of
    | bucket_empty() => ()
    | bucket_filled(str, x, next_bucket) => let
        val () = print("\(")
        val () = print(str)
        val () = print(" : ")
        val () = print( bucket_item$to_string(x) )
        val () = print(")")
    in
        bucket_print(next_bucket)
    end

end
