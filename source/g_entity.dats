(*
###  g_entity.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./data/dict.sats"
staload "./g_entity.sats"

local

sortdef esz = {s:int | s > 0}

assume entity_table = [n:esz] dict(entity, n)

in

implmnt entity_table_init() = dict_new<entity>(MAX_ENTITIES)

implmnt entity_table_finish ( e ) = dict_delete(e)

end
