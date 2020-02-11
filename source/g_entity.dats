(*
###  g_entity.dats  ###


*)

staload "./data/list.sats"
staload "./data/dict.sats"

typedef entity_handler = '{ type_id=int, new_func=void->ptr, del_func=void->void }

#define MAX_ENTITY_HANDLERS 512
var entity_handlers: entity_handler//  [MAX_ENTITY_HANDLERS]
var num_entity_handlers = 0

var entity_names: list ptr = ()
var entities: dict ptr = ()
var entity_types: dict ptr = ()

implement entity_init (  ) =
(
)

implement entity_finish (  ) =
(
)

implement entity_handler_cast ( type_id, entity_new_func, entity_del_func ) =
(
)

implement entity_new_type_id ( fmt, type_id ) =
(
)

implement entity_exists ( fmt ) =
(
)

implement entity_get ( fmt ) =
(
)

implement entity_get_as_type_id ( fmt, type_id ) =
(
)

implement entity_delete ( fmt ) =
(
)

implement entity_type_cound_type_id ( type_id ) =
(
)

implement entity_name ( e ) =
(
)

implement entity_typename ( e ) =
(
)

implement entities_new_type_id ( name_format, count, type_id ) =
(
)

implement entities_get_type_id ( out, returned, type_id ) =
(
)