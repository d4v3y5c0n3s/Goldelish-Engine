(*
###  g_entity.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./data/dict.sats"
staload "./g_entity.sats"

local

sortdef esz = {s:int | s > 0}

assume entity_table = [n:esz] dict(entity, n)
vtypedef entity(a:vt@ype) = ENTITY(a)
assume entity = [a:vt@ype] entity(a)

implmnt bucket_item$delete<entity> ( x ) = let
  val+~ENTITY_GOOD(ent) = x
in
  entity$destroy(ent)
end
(*
extern fn{a,b:vt@ype} entity_is_type ( entity(b) ) : Option_vt(a)
implmnt{a,b} entity_is_type ( x ) = None_vt()// <-- Problem: this doesn't consume x ###
implmnt(a,b) entity_is_type<a,a>( x ) = let
  val+~ENTITY_GOOD(ent) = x
in
  Some_vt(ent)
end

fn{a,b:vt@ype} entity_get_type ( x: entity(b) ) : Option_vt(a) = entity_is_type<a,b>(x)
*)
in

implmnt entity_table_init() = dict_new<entity>(MAX_ENTITIES)

implmnt entity_table_finish ( e ) =  dict_delete_lin(e)

implmnt{a} entity_new ( s ) = let
  var e_t = entity_table$retrieve()
  var new_e = entity$create<a>()
  val () = dict_set_lin(e_t, s, ENTITY_GOOD(new_e))
in
  entity_table$return(e_t)
end

implmnt entity_exists ( s ) = let
  var e_t = entity_table$retrieve()
  val ret = dict_contains(e_t, s)
  val () = entity_table$return(e_t)
in
  ret
end
(*
implmnt{a} entity_get ( s ) = let
  var e_t = entity_table$retrieve()
  val ret = dict_get(e_t, s)
  val () = entity_table$return(e_t)
in
  ret
end
*)
implmnt entity_delete ( s ) = let
  var e_t = entity_table$retrieve()
  val () = dict_remove_lin(e_t, s)
in
  entity_table$return(e_t)
end

end
