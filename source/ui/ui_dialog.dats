(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  ui_dialog.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./ui/ui_dialog.sats"

staload "./g_graphics.sats"

var dialog_count = 0

implement ui_dialog_new (  ) =
{
}

implement ui_dialog_set_font ( d, fnt ) =
{
}

implement ui_dialog_set_single_button ( d, single ) =
{
}

implement ui_dialog_delete ( d ) =
{
}

implement ui_dialog_set_title ( d, title ) =
{
}

implement ui_dialog_set_contents ( d, contents ) =
{
}

implement ui_dialog_set_button_left ( d, left, onleft ) =
{
}

implement ui_dialog_set_button_right ( d, right, onright ) =
{
}

implement ui_dialog_event ( d, e ) =
{
}

implement ui_dialog_update ( d ) =
{
}

implement ui_dialog_render ( d ) =
{
}
