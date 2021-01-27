(*
###  g_audio.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_audio.sats"
staload "./SDL2/SDL_local.sats"

val audio_format = AUDIO_S16
val audio_rate: int = 22050
val audio_channels: int = 2
val audio_buffers: int = 4096

extern castfn float_to_int( f:float ): int
extern castfn int_to_float( i: int ): float

implement audio_init () = let
  var a_rate = audio_rate
  var a_format = audio_format
  var a_channels = audio_channels
in
  if (SDL_InitSubSystem(SDL_INIT_AUDIO) = ~1)
    then println!("Could not start audio!")
  else if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers) = ~1)
    then println!("Unable to start audio mixer!")
  else if (Mix_QuerySpec(a_rate, a_format, a_channels) = ~1)
    then println!("Issue with SDL_mixer query spec")
  else ((*there were no issues*))
end


implement audio_finish () = begin
  Mix_CloseAudio()
end

implement audio_sound_play ( s, loops ) = let
  val chan = Mix_PlayChannel(~1, s.sample, loops);
in
  if (chan = ~1) then println!("unable to play sound: ", Mix_GetError());
  chan
end

implement audio_sound_pause ( channel ) =
  Mix_Pause(channel)

implement audio_sound_resume ( channel ) =
  Mix_Resume(channel)

implement audio_sound_stop ( channel ) =
  Mix_HaltChannel(channel)

val fade_time: int = 5000

implement audio_music_play ( m ) = let
  var music_p: Mix_Music = m.handle
  val chan = Mix_FadeInMusic(music_p, ~1, fade_time);
in
  if (chan = ~1) then println!("unable to play music: ", Mix_GetError())
end

implement audio_music_pause () =
  Mix_PauseMusic()

implement audio_music_resume () =
  Mix_ResumeMusic()

implement audio_music_stop () = let
  val err = Mix_FadeOutMusic(fade_time)
in
end

implement audio_music_set_volume ( volume ) = let
  val temp = Mix_VolumeMusic(float_to_int(mul_int_float(MIX_MAX_VOLUME, volume)))
in
end

implement audio_music_get_volume () =
  int_to_float(Mix_VolumeMusic(~1) * MIX_MAX_VOLUME)
