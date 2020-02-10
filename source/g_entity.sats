(*
###  g_entity.sats  ###

This is an interface for interacting with entities
*)

#include "./g_engine.sats"

typedef entity = void

fun entity_init () : void = "sta#%"
fun entity_finish () : void = "sta#%"

(*
#define entity_handler(type, new, del) entity_handler_cast(typeid(type), (void*(*)())new , (void(*)(void*))del)
void entity_handler_cast(int type_id, void* entity_new() , void entity_del(void* entity));

/* Create, get and destroy entities */
#define entity_new(fmt, type, ...) (type*)entity_new_type_id(fmt, typeid(type), ##__VA_ARGS__)
#define entity_get_as(fmt, type, ...) ((type*)entity_get_as_type_id(fmt, typeid(type)), ##__VA_ARGS__)
*)

fun entity_exists ( fmt: string, () ) : bool = "sta#%"
fun entity_get ( fmt: string, () ) : entity ptr = "sta#%"
fun entity_get_as_type_id ( fmt: string, type_id: int, () ) : entity ptr = "sta#%"
fun entity_new_type_id ( fmt: string, type_id: int, () ) : entity ptr = "sta#%"
fun entity_delete ( fmt: string, () ) : void = "sta#%"

fun entity_name ( e: entity ptr ) : string = "sta#%"
fun entity_typename ( a: entity ptr ) : string = "sta#%"

(*
/* Get the number of a certain entity type */
#define entity_type_count(type) entity_type_count_type_id(typeid(type))
int entity_type_count_type_id(int type_id);

/* Create or get multiple entities of a certain type */
#define entities_new(name_format, count, type) entities_new_type_id(name_format, count, typeid(type))
#define entities_get(out, returned, type) entities_get_type_id((entity**)out, returned, typeid(type)) 
*)

fun entity_new_type_id ( name_format: string, count: int, type_id: int ) : void = "sta#%"
fun entity_get_type_id ( out: entity ptr ptr, returned: int ptr, type_id: int ) : void = "sta#%"