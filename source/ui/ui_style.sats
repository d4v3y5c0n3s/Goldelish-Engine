(*
###  ui_style.sats  ###

allows the appearance of the ui to be somewhat customized
*)

staload "./../g_engine.sats"
staload "./ui_text.sats"

vtypedef ui_style = @{
	box_back_image=fpath, box_back_width=int, box_back_height=int, box_back_tile=bool, box_back_border_size=int, box_back_border_color=vec4, box_glitch=float, box_blend_src=int, box_blend_dst=int,
	box_text_color=vec4, box_label_color=vec4, box_text_halign=int, box_text_valign=int, box_up_color=vec4, box_down_color=vec4, box_inset_color=vec4,
	text_font=fpath, text_color=vec4, text_scale=vec2,
	spinner_image=fpath, spinner_speed=float
}

fun ui_style_current () : ptr

fun ui_style_goldelish () : ui_style
fun ui_style_hunt () : ui_style
