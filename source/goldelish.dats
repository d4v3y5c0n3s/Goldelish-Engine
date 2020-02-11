(*
###  goldelish.dats  ###
*)

staload "./goldelish.sats"

//  may not need all of these... reexamine later
datatype SIG_ERR =
| ABRT of ()
| FPE of ()
| ILL of ()
| INT of ()
| SEGV of ()
| TERM of ()
exception SIG_ABRT of ()//  program aborted
exception SIG_FPE of ()//  division by zero
exception SIG_ILL of ()//  illegal instruction
exception SIG_INT of ()//  program interrupted
exception SIG_SEGV of ()//  segmentation fault
exception SIG_TERM of ()//  program terminated

fun goldelish_signal ( sig: int ) : void =
    case+ of
    | ABRT() => $raise SIG_ABRT(); error("Program Aborted");
    | FPE() => $raise SIG_FPE(); error("Division by Zero");
    | ILL() => $raise SIG_ILL(); error("Illegal Instruction");
    | INT() => $raise SIG_INT(); error("Program Interrupted");
    | SEGV() => $raise SIG_SEGV(); error("Segmentation Fault");
    | TERM() => $raise SIG_TERM(); error("Program Terminated");

val logout: FILE ptr = ()

fun goldelish_error ( str: string ) : void =
(
fprintf ( stderr, "%s\n", str ); fflush ( stderr );
fprintf ( logout, "%s\n", str ); fflush ( logout );

SDL_PrintStackTrace ()
exit (EXIT_FAILURE)
)

fun goldelish_warning ( str: string ) : void =
(
fprintf ( stderr, "%s\n", str ); fflush ( stderr );
fprintf ( logout, "%s\n", str ); fflush ( logout );
)

fun goldelish_debug ( str: string ) : void =
(
fprintf ( stderr, "%s\n", str ); fflush ( stderr );
fprintf ( logout, "%s\n", str ); fflush ( logout );
)

implement goldelish_init ( core_assets_path: string ) =
(
//  attach signal handlers
signal ( SIGABRT, corange_signal )
signal ( SIGFPE, corange_signal )
signal ( SIGILL, corange_signal )
signal ( SIGINT, corange_signal )
signal ( SIGSEGV, corange_signal )
signal ( SIGTERM, corange_signal )

logout = fopen( "output.log", "w" )

at_error (goldelish_error)
at_warning (goldelish_warning)
at_debug (goldelish_debug)

//  starting Goldelish
debug ("Starting Goldelish...")

//  asset manager
debug ("Creating Asset Manager...")
debug ("Core Assets At '%s' ...", core_assets_path)

asset_init ()
asset_add_path_variable (P("$GOLDELISH"), P(core_assets_path))

asset_handler (renderable, "bmf", bmf_load_file, renderable_delete)
asset_handler (renderable, "obj", obj_load_file, renderable_delete)
asset_handler (renderable, "smd", smd_load_file, renderable_delete)
asset_handler (renderable, "ply", ply_load_file, renderable_delete)
asset_handler (skeleton, "skl", skl_load_file, skeleton_delete)
asset_handler (animation, "ani", ani_load_file, animation_delete)
asset_handler (cmesh, "col", col_load_file, cmesh_delete)
asset_handler (terrain, "raw", raw_load_file, terrain_delete)

asset_handler (texture, "bmp", bmp_load_file, texture_delete)
asset_handler (texture, "tga", tga_load_file, texture_delete)
asset_handler (texture, "dds", dds_load_file, texture_delete)
asset_handler (texture, "lut", lut_load_file, texture_delete)
asset_handler (texture, "acv", acv_load_file, texture_delete)

asset_handler (shader, "vs", vs_load_file, shader_delete)
asset_handler (shader, "fs", fs_load_file, shader_delete)
asset_handler (shader, "gs", gs_load_file, shader_delete)
asset_handler (shader, "tcs", tcs_load_file, shader_delete)
asset_handler (shader, "tes", tes_load_file, shader_delete)

asset_handler (config, "cfg", cfg_load_file, config_delete)
asset_handler (lang, "lang", lang_load_file, lang_delete)
asset_handler (font, "fnt", font_load_file, font_delete)

asset_handler (material, "mat", mat_load_file, material_delete)
asset_handler (effect, "effect", effect_load_file, material_delete)

asset_handler (sound, "wav", wav_load_file, sound_delete)
asset_handler (music, "ogg", ogg_load_file, music_delete)
asset_handler (music, "mp3, mp3_load_file, music_delete)

//  entity manager
debug ("Creating Entity Manager...")

entity_init ()

entity_handler (static_object, static_object_new, static_object_delete)
entity_handler (animated_object, animated_object_new, animated_object_delete)
entity_handler (physics_object, physics_object_new, physics_object_delete)
entity_handler (instance_object, instance_object_new, instance_object_delete)

entity_handler (camera, camera_new, camera_delete)
entity_handler (light, light_new, light_delete)
entity_handler (landscape, landscape_new, landscape_delete)
entity_handler (particles, particles_new, particles_delete)

//  ui manager
debug ("Creating Entity Manager...")

ui_init ()

ui_handler (ui_rectagle, ui_rectangle_new, ui_rectangle_delete, ui_rectangle_event, ui_rectange_update, ui_rectangle_render)
ui_handler (ui_text, ui_text_new, ui_text_delete, ui_text_event, ui_text_update, ui_text_render)
ui_handler (ui_spinner, ui_spinner_new, ui_spinner_delete, ui_spinner_event, ui_spinner_update, ui_spinner_render)
ui_handler (ui_button, ui_button_new, ui_button_delete, ui_button_event, ui_button_update, ui_button_render)
ui_handler (ui_textbox, ui_textbox_new, ui_textbox_delete, ui_textbox_event, ui_textbox_update, ui_textbox_render)
ui_handler (ui_browser, ui_browser_new, ui_browser_delete, ui_browser_event, ui_browser_update, ui_browser_render)
ui_handler (ui_toast, ui_toast_new, ui_toast_delete, ui_toast_event, ui_toast_update, ui_toast_render)
ui_handler (ui_dialog, ui_dialog_new, ui_dialog_delete, ui_dialog_event, ui_dialog_update, ui_dialog_render)
ui_handler (ui_listbox, ui_listbox_new, ui_listbox_delete, ui_listbox_event, ui_listbox_update, ui_listbox_render)
ui_handler (ui_option, ui_option_new, ui_option_delete, ui_option_event, ui_option_update, ui_option_render)
ui_handler (ui_slider, ui_slider_new, ui_slider_delete, ui_slider_event, ui_slider_update, ui_slider_render)

//  graphics manager
debug ("Creating Graphics Manager...")
graphics_init ()

//  audio manager
debug ("Creating Audio Manager...")
audio_init()

//  joystick manager
debug ("Creating Joystick Manager...")
joystick_init ()

//  network manager
debug ("Creating Network Manager...")
net_init ()

debug ("Finished!")
)

implement goldelish_finish () =
(
ui_finish ()
entity_finish ()
asset_finish ()

net_finish ()
joystick_finish ()
audio_finish ()
graphics_finish ()

SDL_Quit ()

if logout then ( fclose (logout) )
)