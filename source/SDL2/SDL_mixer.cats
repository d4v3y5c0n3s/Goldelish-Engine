/*
###  SDL_mixer.cats  ###

the direct interface to SDL_mixer
*/

#include <SDL2/SDL_mixer.h>

#define //extern fun SDL_InitSubSystem ( flags: uint32 ) : int = "mac#SDL_InitSubSystem"
#define //extern fun Mix_OpenAudio ( frequency: int, format: uint16, channels: int, chunksize: int ) : int = "mac#Mix_OpenAudio"
#define //extern fun Mix_QuerySpec (frequency: &int, format: &uint16, channels: &int ) : int = "mac#Mix_QuerySpec"
#define //extern fun Mix_CloseAudio () : void = "mac#Mix_CloseAudio"
#define //extern fun Mix_PlayChannel ( channel: int, chunk: &Mix_Chunk, loops: int ) : int = "mac#Mix_PlayChannel"
#define //extern fun Mix_Pause ( channel: int ) : void = "mac#Mix_Pause"
#define //extern fun Mix_Resume ( channel: int ) : void = "mac#Mix_Resume"
#define //extern fun Mix_HaltChannel ( channel: int ) : void = "mac#Mix_HaltChannel"
#define //extern fun Mix_FadeInMusic ( music: &Mix_Music, loops: int, ms: int ) : int = "mac#Mix_FadeInMusic"
#define //extern fun Mix_GetError(): string = "mac#Mix_GetError"
#define //extern fun Mix_PauseMusic(): void = "mac#Mix_PauseMusic"
#define //extern fun Mix_ResumeMusic(): void = "mac#Mix_ResumeMusic"
#define //extern fun Mix_FadeOutMusic( ms: int ): int = "mac#Mix_FadeOutMusic"
#define //extern fun Mix_VolumeMusic( volume: int ): int = "mac#Mix_VolumeMusic"
