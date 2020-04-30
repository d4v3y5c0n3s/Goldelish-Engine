(*
###  SDL_mixer.sats  ###

provide an interface to the SDL_mixer
*)

%{#
#include "source/SDL2/SDL_mixer.cats"
%}

typedef Mix_Music = $extype"Mix_Music"
typedef Mix_Chunk = $extype"Mix_Chunk"

fun SDL_InitSubSystem ( flags: uint32 ) : int = "mac#%"
fun Mix_OpenAudio ( frequency: int, format: uint16, channels: int, chunksize: int ) : int = "mac#%"
fun Mix_QuerySpec (frequency: &int, format: &uint16, channels: &int ) : int = "mac#%"
fun Mix_CloseAudio () : void = "mac#%"
fun Mix_PlayChannel ( channel: int, chunk: &Mix_Chunk, loops: int ) : int = "mac#%"
fun Mix_Pause ( channel: int ) : void = "mac#%"
fun Mix_Resume ( channel: int ) : void = "mac#%"
fun Mix_HaltChannel ( channel: int ) : void = "mac#%"
fun Mix_FadeInMusic ( music: &Mix_Music, loops: int, ms: int ) : int = "mac#%"
fun Mix_GetError(): string = "mac#%"
fun Mix_PauseMusic(): void = "mac#%"
fun Mix_ResumeMusic(): void = "mac#%"
fun Mix_FadeOutMusic( ms: int ): int = "mac#%"
fun Mix_VolumeMusic( volume: int ): int = "mac#%"

macdef AUDIO_S16 = $extval(uint16, "AUDIO_S16")
macdef MIX_MAX_VOLUME = $extval(int, "MIX_MAX_VOLUME")
macdef SDL_INIT_AUDIO = $extval(uint32, "SDL_INIT_AUDIO")