(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  ui_textbox.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./ui/ui_textbox.sats"
staload "./ui/ui_style.sats"

implement ui_textbox_new (  ) =
{
}

implement ui_textbox_set_password ( tb, password, l ) =
{
}

implement ui_textbox_set_max_chars ( tb, l ) =
{
}

implement ui_textbox_addchar ( tb, c ) =
{
}

implement ui_textbox_rmchar ( tb ) =
{
}

implement ui_textbox_delete ( tb ) =
{
}

implement ui_textbox_move ( tb, pos ) =
{
}

implement ui_textbox_resize ( tb, size ) =
{
}

implement ui_textbox_set_font ( tb, f ) =
{
}

implement ui_textbox_set_label ( tb, label ) =
{
}

implement ui_textbox_set_contents ( tb, label ) =
{
}

implement ui_textbox_set_alignment ( tb, halign, valign ) =
{
}

implement ui_textbox_disable ( tb ) =
{
}

implement ui_textbox_enable ( tb ) =
{
}

val time_to_delete = 0.05
var time_delete = 0

implement ui_textbox_event ( tb, e ) =
{
}

implement ui_textbox_update ( tb ) =
{
}

implement ui_textbox_render ( tb ) =
{
}

implement ui_textbox_contains_point ( tb, p ) =
{
}
