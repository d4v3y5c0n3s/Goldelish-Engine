(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_audio.sats  ###

This is the main header file for handling audio within the engine.
*)

(*  includes  *)
staload "./g_engine.sats"
staload "./assets/sound.sats"
staload "./assets/music.sats"

(*  functions  *)
fn audio_init() : void = "sta#audio_init"
fn audio_finish() : void = "sta#audio_finish"
fn audio_sound_play ( s: &sound, loops: int ) : int = "sta#audio_sound_play"
fn audio_sound_pause( channel: int ) : void = "sta#audio_sound_pause"
fn audio_sound_resume( channel: int ) : void = "sta#audio_sound_resume"
fn audio_sound_stop( channel: int ) : void = "sta#audio_sound_stop"
fn audio_music_play( m: &music ) : void = "sta#audio_music_play"
fn audio_music_pause() : void = "sta#audio_music_pause"
fn audio_music_resume() : void = "sta#audio_music_resume"
fn audio_music_stop() : void = "sta#audio_music_stop"
fn audio_music_set_volume( volume: float ) : void = "sta#audio_music_set_volume"
fn audio_music_get_volume() : float = "sta#audio_music_get_volume"
