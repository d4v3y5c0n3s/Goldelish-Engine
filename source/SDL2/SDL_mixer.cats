/*
###  SDL_mixer.cats  ###

the direct interface to SDL_mixer
*/

#include <SDL2/SDL.h>
#include <SDL2/SDL_mixer.h>
#include <SDL2/SDL_audio.h>

#define gldlsh_sdl_bind_SDL_InitSubSystem SDL_InitSubSystem

#define gldlsh_sdl_bind_Mix_OpenAudio Mix_OpenAudio

#define gldlsh_sdl_bind_Mix_QuerySpec Mix_QuerySpec

#define gldlsh_sdl_bind_Mix_CloseAudio Mix_CloseAudio

#define gldlsh_sdl_bind_Mix_PlayChannel Mix_PlayChannel

#define gldlsh_sdl_bind_Mix_Pause Mix_Pause

#define gldlsh_sdl_bind_Mix_Resume Mix_Resume

#define gldlsh_sdl_bind_Mix_HaltChannel Mix_HaltChannel

#define gldlsh_sdl_bind_Mix_FadeInMusic Mix_FadeInMusic

#define gldlsh_sdl_bind_Mix_GetError Mix_GetError

#define gldlsh_sdl_bind_Mix_PauseMusic Mix_PauseMusic

#define gldlsh_sdl_bind_Mix_ResumeMusic Mix_ResumeMusic

#define gldlsh_sdl_bind_Mix_FadeOutMusic Mix_FadeOutMusic

#define gldlsh_sdl_bind_Mix_VolumeMusic Mix_VolumeMusic
