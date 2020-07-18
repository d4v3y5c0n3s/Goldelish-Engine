(*
###  g_graphics.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_graphics.sats"
staload "./g_asset.sats"

staload "./assets/image.sats"

////
var screen: SDL_Window ptr = ()
var context: SDL_GLContext ptr = ()

var window_flags = 0
var window_multisamples = 0
var window_multisamplesbuffs = 0
var window_antialiasing = 0

fun graphics_viewport_start (  ) =
(
)

implement graphics_init (  ) =
(
)

implement graphics_context_new (  ) =
(
)

implement graphics_context_delete ( context ) =
(
)

implement graphics_context_current ( context ) =
(
)

implement graphics_set_antialiasing ( quality ) =
(
)

implement graphics_finish (  ) =
(
)

implement graphics_set_mulisamples ( multisamples ) =
(
)

implement graphics_get_multisamples (  ) =
(
)

implement graphics_set_vsync ( vsync ) =
(
)

implement graphics_set_fullscreen ( fullscreen ) =
(
)

implement graphics_get_fullscreen (  ) =
(
)

implement graphics_viewport_set_size ( w, h ) =
(
)

implement graphics_viewport_height (  ) =
(
)

implement graphics_viewport_width (  ) =
(
)

implement graphics_viewport_ratio (  ) =
(
)

implement graphics_viewport_set_title ( title ) =
(
)

implement graphics_viewport_set_icon ( icon ) =
(
)

implement graphics_viewport_title (  ) =
(
)

var timestamp_string: char//  [256]
var screenshot_string: char//  [256]

implement graphics_viewport_screenshot (  ) =
(
)

implement graphics_set_cursor_hidden ( hidden ) =
(
)

implement graphics_get_cursor_hidden (  ) =
(
)

implement graphics_swap (  ) =
(
)