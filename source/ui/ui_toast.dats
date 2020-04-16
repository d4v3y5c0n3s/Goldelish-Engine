(*
###  ui_toast.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./ui/ui_toast.sats"

staload "./g_ui.sats"
staload "./g_graphics.sats"

#define MAX_TOASTS 128
var toasts_num = 0
var toasts: ui_toast ptr = ()//[MAX_TOASTS]

implement reposition_toasts (  ) =
{
}

implement shift_toasts_down ( new ) =
{
}

implement shift_toasts_up (  ) =
{
}

implement toast_index ( t ) =
{
}

var popup_counter = 0

var popup_contents: char = ()//[1024]

implement ui_toast_popup ( fmt ) =
{
}

implement ui_toast_new (  ) =
{
}

implement ui_toast_delete ( t ) =
{
}

implement ui_toast_set_label ( t, label ) =
{
}

implement ui_toast_set_font ( t, f ) =
{
}

implement ui_toast_event ( t, e ) =
{
}

implement ui_toast_update ( t ) =
{
}

implement ui_toast_render ( t ) =
{
}