(*
###  goldelish.sats  ###

This code is the main header file for the engine.
*)

(*  Engine Modules  *)
#include "./g_audio.sats"
#include "./g_engine.sats"
#include "./g_graphics.sats"
#include "./g_joystick.sats"
#include "./g_net.sats"
#include "./g_physics.sats"

(*  Engine Functions  *)
fn goldelish_init(core_assets_path: string) : void = "sta#%"
fn goldelish_finish() : void = "sta#%"

(*  Entities  *)
#include "./g_entity.sats"
#include "./entities/camera.sats"
#include "./entities/light.sats"
#include "./entities/static_object.sats"
#include "./entities/animated_object.sats"
#include "./entities/physics_object.sats"
#include "./entities/instance_object.sats"
#include "./entities/landscape.sats"
#include "./entities/particles.sats"

(*  Assets  *)
#include "./g_asset.sats"
#include "./assets/config.sats"
#include "./assets/image.sats"
#include "./assets/sound.sats"
#include "./assets/music.sats"
#include "./assets/lang.sats"
#include "./assets/font.sats"
#include "./assets/shader.sats"
#include "./assets/texture.sats"
#include "./assets/material.sats"
#include "./assets/renderable.sats"
#include "./assets/cmesh.sats"
#include "./assets/skeleton.sats"
#include "./assets/animation.sats"
#include "./assets/terrain.sats"
#include "./assets/effect.sats"

(*  UI  *)
#include "./g_ui.sats"
#include "./ui/ui_style.sats"
#include "./ui/ui_text.sats"
#include "./ui/ui_rectangle.sats"
#include "./ui/ui_spinner.sats"
#include "./ui/ui_button.sats"
#include "./ui/ui_textbox.sats"
#include "./ui/ui_browser.sats"
#include "./ui/ui_toast.sats"
#include "./ui/ui_dialog.sats"
#include "./ui/ui_listbox.sats"
#include "./ui/ui_option.sats"
#include "./ui/ui_slider.sats"

(*  Rendering  *)
#include "./rendering/sky.sats"
#include "./rendering/renderer.sats"

(*  Data Structures  *)
#include "./data/dict.sats"
#include "./data/list.sats"
#include "./data/int_list.sats"
#include "./data/vertex_list.sats"
#include "./data/vertex_hashtable.sats"
#include "./data/spline.sats"
#include "./data/randf.sats"
