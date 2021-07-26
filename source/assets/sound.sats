(*
###  sound.sats  ###

defines a sound
*)

staload "./../g_engine.sats"
staload "./../SDL2/SDL_local.sats"

typedef sound = @{ sample = Mix_Chunk }

fun wav_load_file ( filename: string ) : (*sound*) ptr = "sta#%"
fun sound_delete ( s: (*sound*) ptr ) : void = "sta#%"

fun sound_play ( s: (*sound*) ptr ) : int = "sta#%"
fun sound_play_looped ( s: (*sound*) ptr, loops: int ) : int = "sta#%"

fun sound_play_at ( s: (*sound*) ptr, pos: vec3, cam_pos: vec3, cam_dir: vec3 ) : int = "sta#%"
fun sound_play_at_looped ( s: (*sound*) ptr, pos: vec3, cam_pos: vec3, cam_dir: vec3, loops: int ) : int = "sta#%"
