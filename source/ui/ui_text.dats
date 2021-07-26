(*
###  ui_text.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./ui/ui_text.sats"
staload "./ui/ui_style.sats"

staload "./g_graphics.sats"

staload "./assets/material.sats"
staload "./assets/shader.sats"
staload "./assets/texture.sats"
staload "./assets/font.sats"

implement ui_text_new (  ) =
{
}

implement ui_text_new_string ( string ) =
{
}

implement ui_text_delete ( t ) =
{
}

implement ui_text_move ( t, pos ) =
{
}

implement ui_text_set_font ( t, font ) =
{
}

implement ui_text_set_color ( t, color ) =
{
}

implement ui_text_set_scale ( t, scale ) =
{
}

implement ui_text_align ( t, halign, valign ) =
{
}

implement ui_text_event ( t, e ) =
{
}

implement ui_text_update ( t ) =
{
}

implement ui_text_draw_string ( t, string ) =
{
}

implement ui_text_charcount ( t ) =
{
}

implement ui_text_draw ( t ) =
{
}

implement ui_text_render ( t ) =
{
}

implement ui_text_contains_point ( t, position ) =
{
}