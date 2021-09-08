(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  config.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/config.sats"

////
implement SDL_RWreadline ( file, buffer, buffersize ) =
(
)

implement cfg_load_file ( filename ) =
(
)

var current_cfg: config ptr = ()
var current_file: SDL_RWops = ()

implement cfg_write_entry ( x ) =
(
)

implement cfg_save_file ( c, filename ) =
(
)

implement config_delete ( c ) =
(
)

implement config_string ( c, key ) =
(
)

implement config_int ( c, key ) =
(
)

implement config_float ( c, key ) =
(
)

implement config_bool ( c, key ) =
(
)

implement config_set_string ( c, key, val ) =
(
)

implement config_set_int ( c, key, val ) =
(
)

implement config_set_float ( c, key, val ) =
(
)

implement config_set_bool ( c, key, val ) =
(
)

implement option_graphics_asset ( c, key, high, medium, low ) =
(
)

implement option_graphics_int ( c, key, high, medium, low ) =
(
)

implement option_graphics_float ( c, key, high, medium, low ) =
(
)
