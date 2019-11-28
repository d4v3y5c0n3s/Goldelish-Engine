(*
###  g_ui.hats  ###

user interface manager
*)

#include "ui/ui_style.hats"
#include "g_engine.hats"

typedef ui_elem = ()//  defined as void, perhaps revise this

fun ui_init () : void = "sta#%"
fun ui_finish () : void = "sta#%"
fun ui_set_style ( s: ui_style ptr ) : void = "sta#%"

fun ui_event ( e: SDL_Event ) : void = "sta#%"
fun ui_update () : void = "sta#%"
fun ui_render () : void = "sta#%"

(*
#define ui_handler(type, new, delete, event, update, render) \
  ui_handler_cast(typeid(type), \
  (ui_elem*(*)())new, \
  (void(*)(ui_elem*))delete, \
  (void(*)(ui_elem*,SDL_Event))event, \
  (void(*)(ui_elem*))update, \
  (void(*)(ui_elem*))render)
*)

(*
void ui_handler_cast(int type_id,
  void* (*ui_elem_new_func)(), 
  void (*ui_elem_del_func)(ui_elem*), 
  void (*ui_elem_event_func)(ui_elem*, SDL_Event), 
  void (*ui_elem_update_func)(ui_elem*), 
  void (*ui_elem_render_func)(ui_elem*));
*)

(*
#define ui_elem_new(fmt, type, ...) (type*)ui_elem_new_type_id(fmt, typeid(type), ##__VA_ARGS__)
*)
(*
#define ui_elem_get_as(fmt, type, ...) ((type*)ui_elem_get_as_type_id(fmt, typeid(type), ##__VA_ARGS__))
*)

fun ui_elem_exists ( fmt: char ptr, ... ) : bool = "sta#%"
fun ui_elem_get ( fmt: char ptr, ... ) : ui_elem ptr = "sta#%"
fun ui_elem_get_as_type_id ( fmt: char ptr, type_id: int, ... ) : ui_elem ptr = "sta#%"
fun ui_elem_new_type_id ( fmt: char ptr, type_id: int, ... ) : ui_elem ptr = "sta#%"
fun ui_elem_delete ( fmt: char ptr, ... ) : void = "sta#%"
fun ui_elem_event ( fmt: char ptr, ... ) : void = "sta#%"
fun ui_elem_update ( fmt: char ptr, ... ) : void = "sta#%"
fun ui_elem_render ( fmt: char ptr, ... ) : void = "sta#%"

fun ui_elem_name ( e: ui_elem ptr ) : char ptr = "sta#%"
fun ui_elem_typename ( e: ui_elem ptr ) : char ptr = "sta#%"