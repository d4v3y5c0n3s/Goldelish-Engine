(*
###  g_audio.hats  ###

This is the main header file for handling audio within the engine.
*)

(*  includes  *)
#include "g_engine.hats"
#include "assets/sound.hats"
#include "assets/music.hats"

(*  functions  *)
fn audio_init() : void = "mac#"
fn audio_finish() : void = "mac#"
fn audio_sound_play( s: ptr, loops: int ) : int = 0
fn audio_sound_pause( channel: int ) : void = "mac#"
fn audio_sound_resume( channel: int ) : void = "mac#"
fn audio_sound_stop( channel: int ) : void = "mac#"
fn
fn
fn
fn
fn
fn
