(*
###  goldelish.hats  ###

This code is the main header file for the engine.
*)

(*  Engine Modules  *)
#include "g_audio.hats"
#include "g_engine.hats"
#include "g_graphics.hats"
#include "g_joystick.hats"
#include "g_net.hats"
#include "g_physics.hats"

(*  Engine Functions  *)
fn goldelish_init(core_assets_path: ptr) : void = "sta#goldelish_init"
fn goldelish_finish() : void = "sta#goldelish_finish"

(*  Entities  *)
#include "g_entity.hats"
#include "entities/camera.hats"
#include "entities/light.hats"
#include "entities/static_object.hats"
#include "entities/animated_object.hats"
#include "entities/physics_object.hats"
#include "entities/instance_object.hats"
#include "entities/landscape.hats"
#include "entities/particles.hats"

(*  Assets  *)
#include "g_asset.hats"
#include "assets/config.hats"
#include "assets/image.hats"
#include "assets/sound.hats"
#include "assets/music.hats"
#include "assets/lang.hats"
#include "assets/font.hats"
#include "assets/shader.hats"
#include "assets/texture.hats"
#include "assets/material.hats"
#include "assets/renderable.hats"
#include "assets/cmesh.hats"
#include "assets/skeleton.hats"
#include "assets/animation.hats"
#include "assets/terrain.hats"
#include "assets/effect.hats"

(*  UI  *)
#include "g_ui.hats"
#include "ui/ui_style.hats"
#include "ui/ui_text.hats"
#include "ui/ui_rectangle.hats"
#include "ui/ui_spinner.hats"
#include "ui/ui_button.hats"
#include "ui/ui_textbox.hats"
#include "ui/ui_browser.hats"
#include "ui/ui_toast.hats"
#include "ui/ui_dialog.hats"
#include "ui/ui_listbox.hats"
#include "ui/ui_option.hats"
#include "ui/ui_slider.hats"

(*  Rendering  *)
#include "rendering/sky.hats"
#include "rendering/renderer.hats"

(*  Data Structures  *)
#include "data/dict.hats"
#include "data/list.hats"
#include "data/int_list.hats"
#include "data/vertex_list.hats"
#include "data/vertex_hashtable.hats"
#include "data/spline.hats"
#include "data/randf.hats"
