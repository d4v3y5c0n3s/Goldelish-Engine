(*
###  goldelish.sats  ###

This code is the main header file for the engine.
*)

(*  Engine Modules  *)
staload "./g_audio.sats"
staload "./g_engine.sats"
staload "./g_graphics.sats"
staload "./g_joystick.sats"
staload "./g_net.sats"
staload "./g_physics.sats"

(*  Engine Functions  *)
fn goldelish_init(core_assets_path: string) : void = "sta#%"
fn goldelish_finish() : void = "sta#%"

(*  Entities  *)
staload "./g_entity.sats"
staload "./entities/camera.sats"
staload "./entities/light.sats"
staload "./entities/static_object.sats"
staload "./entities/animated_object.sats"
staload "./entities/physics_object.sats"
staload "./entities/instance_object.sats"
staload "./entities/landscape.sats"
staload "./entities/particles.sats"

(*  Assets  *)
staload "./g_asset.sats"
staload "./assets/config.sats"
staload "./assets/image.sats"
staload "./assets/sound.sats"
staload "./assets/music.sats"
staload "./assets/lang.sats"
staload "./assets/font.sats"
staload "./assets/shader.sats"
staload "./assets/texture.sats"
staload "./assets/material.sats"
staload "./assets/renderable.sats"
staload "./assets/cmesh.sats"
staload "./assets/skeleton.sats"
staload "./assets/animation.sats"
staload "./assets/terrain.sats"
staload "./assets/effect.sats"

(*  UI  *)
staload "./g_ui.sats"
staload "./ui/ui_style.sats"
staload "./ui/ui_text.sats"
staload "./ui/ui_rectangle.sats"
staload "./ui/ui_spinner.sats"
staload "./ui/ui_button.sats"
staload "./ui/ui_textbox.sats"
staload "./ui/ui_browser.sats"
staload "./ui/ui_toast.sats"
staload "./ui/ui_dialog.sats"
staload "./ui/ui_listbox.sats"
staload "./ui/ui_option.sats"
staload "./ui/ui_slider.sats"

(*  Rendering  *)
staload "./rendering/sky.sats"
staload "./rendering/renderer.sats"

(*  Data Structures  *)
staload "./data/dict.sats"
staload "./data/list.sats"
staload "./data/int_list.sats"
staload "./data/vertex_list.sats"
staload "./data/vertex_hashtable.sats"
staload "./data/spline.sats"
staload "./data/randf.sats"
