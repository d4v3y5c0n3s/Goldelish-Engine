(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_ui.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_ui.sats"

staload "./data/dict.sats"
staload "./data/dict.sats"

////
typedef ui_elem_handler = '{ type_id=int, new_func=void -> ptr, del_func=ui_elem ptr -> void, event_func=(ui_elem ptr, SDL_Event) -> void, update_func=ui_elem ptr -> void, render_func=ui_elem ptr -> void }

#define MAX_UI_ELEM_HANDLERS 512
var ui_elem_handlers: ui_elem_handler//  [MAX_UI_ELEM_HANDLERS]
var num_ui_elem_handlers = 0

var ui_elem_names: list ptr = ()
var ui_elems: dict ptr = ()
var ui_elem_types: dict ptr = ()

implement ui_init (  ) =
(
)

implement ui_finish (  ) =
(
)

implement ui_set_style ( s ) =
(
)

implement ui_event ( e ) =
(
)

implement ui_update (  ) =
(
)

implement ui_render (  ) =
(
)

implement ui_handler_cast ( type_id, ui_elem_new_func, ui_elem_del_func, ui_elem_event_func, ui_elem_update_func, ui_elem_render_func ) =
(
)

implement ui_elem_exists ( fmt ) =
(
)

implement ui_elem_new_type_id ( fmt, type_id ) =
(
)

implement ui_elem_get ( fmt ) =
(
)

implement ui_elem_get_as_type_id ( fmt, type_id ) =
(
)

implement ui_elem_event ( fmt, e ) =
(
)

implement ui_elem_update ( fmt ) =
(
)

implement ui_elem_render ( fmt ) =
(
)

implement ui_elem_delete ( fmt ) =
(
)

implement ui_elem_name ( e ) =
(
)

implement ui_elem_typename ( e ) =
(
)
