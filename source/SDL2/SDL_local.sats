(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

#define ATS_EXTERN_PREFIX "sdl_"

%{#
#include "source/SDL2/SDL_local.cats"
%}
#include "share/HATS/atslib_staload_libats_libc.hats"

fn SDL_PrintStackTrace () : void = "mac#%"

fn SDL_GL_FrameBufferErrorString ( error: $extype"GLenum" ) : string = "mac#%"
fn SDL_GL_ErrorString ( error: $extype"GLenum" ) : string = "mac#%"

fn SDL_GL_PrintInfo () : void = "mac#%"
fn SDL_GL_PrintExtensions () : void = "mac#%"
fn SDL_GL_LoadExtensions () : void = "mac#%"
fn SDL_GL_ExtensionPresent ( name: string ) : bool = "mac#%"
fn SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "mac#%"

absvtype SDL_Window_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Window_ptr0 = [l:addr] SDL_Window_ptr_base(l)
vtypedef SDL_Window_ptr1 = [l:addr | l > null] SDL_Window_ptr_base(l)

absvtype SDL_Surface_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Surface_ptr0 = [l:addr] SDL_Surface_ptr_base(l)
vtypedef SDL_Surface_ptr1 = [l:addr | l > null] SDL_Surface_ptr_base(l)

absvtype SDL_Joystick_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Joystick_ptr0 = [l:addr] SDL_Joystick_ptr_base(l)
vtypedef SDL_Joystick_ptr1 = [l:addr | l > null] SDL_Joystick_ptr_base(l)

absvtype SDL_GLContext_base (l:addr) = ptr(l)
vtypedef SDL_GLContext0 = [l:addr] SDL_GLContext_base(l)
vtypedef SDL_GLContext1 = [l:addr | l > null] SDL_GLContext_base(l)
abst@ype SDL_GLattr = $extype"SDL_GLattr"

typedef Mix_Music = ptr
typedef Mix_Chunk = $extype"Mix_Chunk"

typedef SDL_RWops = ptr

abst0ype GLsizei = $extype"GLsizei"
abst0ype GLint = $extype"GLint"

absvtype TCPsocket_base (l:addr) = ptr(l)
vtypedef TCPsocket0 = [l:addr] TCPsocket_base(l)
vtypedef TCPsocket1 = [l:addr | l > null] TCPsocket_base(l)

typedef IPaddress = $extype_struct "IPaddress" of {
    host=uint32,
    port=uint16
}

castfn uint32_to_GLsizei ( uint32 ) : GLsizei
castfn int32_to_GLint ( int32 ) : GLint

castfn int_to_GLsizei ( int ) : GLsizei
castfn int_to_GLint ( int ) : GLint

castfn sdl_wptr_to_ptr {l:addr} ( !SDL_Window_ptr_base(l) ) : ptr l
castfn sdl_glcptr_to_ptr {l:addr} ( !SDL_GLContext_base(l) ) : ptr l
castfn sdl_srptr_to_ptr {l:addr} ( !SDL_Surface_ptr_base(l) ) : ptr l
castfn sdl_jyptr_to_ptr {l:addr} ( !SDL_Joystick_ptr_base(l) ) : ptr l
castfn sdl_tcpptr_to_ptr {l:addr} ( !TCPsocket_base(l) ) : ptr l

overload ptrcast with sdl_wptr_to_ptr
overload ptrcast with sdl_glcptr_to_ptr
overload ptrcast with sdl_srptr_to_ptr
overload ptrcast with sdl_jyptr_to_ptr
overload ptrcast with sdl_tcpptr_to_ptr

//  use macdef to handle the SDL constants
macdef SDL_WINDOW_OPENGL = $extval(uint32, "SDL_WINDOW_OPENGL")
macdef AUDIO_S16 = $extval(uint16, "AUDIO_S16")
macdef MIX_MAX_VOLUME = $extval(int, "MIX_MAX_VOLUME")
macdef SDL_INIT_AUDIO = $extval(uint32, "SDL_INIT_AUDIO")
macdef SDL_INIT_VIDEO = $extval(uint32, "SDL_INIT_VIDEO")
macdef SDL_INIT_JOYSTICK = $extval(uint32, "SDL_INIT_JOYSTICK")
macdef SDL_WINDOWPOS_UNDEFINED = $extval(int, "SDL_WINDOWPOS_UNDEFINED")
macdef SDL_GL_SHARE_WITH_CURRENT_CONTEXT = $extval(SDL_GLattr, "SDL_GL_SHARE_WITH_CURRENT_CONTEXT")
macdef SDL_WINDOW_FULLSCREEN_DESKTOP = $extval(uint32, "SDL_WINDOW_FULLSCREEN_DESKTOP")
macdef SDL_DISABLE = $extval(int, "SDL_DISABLE")
macdef SDL_ENABLE = $extval(int, "SDL_ENABLE")
macdef SDL_QUERY = $extval(int, "SDL_QUERY")

fn Mix_OpenAudio ( frequency: int, format: uint16, channels: int, chunksize: int ) : int = "mac#%"
fn Mix_QuerySpec (frequency: &int, format: &uint16, channels: &int ) : int = "mac#%"
fn Mix_CloseAudio () : void = "mac#%"
fn Mix_PlayChannel ( channel: int, chunk: &Mix_Chunk, loops: int ) : int = "mac#%"
fn Mix_Pause ( channel: int ) : void = "mac#%"
fn Mix_Resume ( channel: int ) : void = "mac#%"
fn Mix_HaltChannel ( channel: int ) : void = "mac#%"
fn Mix_FadeInMusic ( music: Mix_Music, loops: int, ms: int ) : int = "mac#%"
fn Mix_GetError(): string = "mac#%"
fn Mix_PauseMusic(): void = "mac#%"
fn Mix_ResumeMusic(): void = "mac#%"
fn Mix_FadeOutMusic( ms: int ): int = "mac#%"
fn Mix_VolumeMusic( volume: int ): int = "mac#%"

fn SDL_GL_SetAttribute ( SDL_GLattr, int ) : int = "mac#%"
fn SDL_GL_CreateContext ( !SDL_Window_ptr1 ) : SDL_GLContext0 = "mac#%"
fn SDL_GL_SetSwapInterval ( int ) : int = "mac#%"
fn SDL_GL_DeleteContext ( SDL_GLContext0 ) : void = "mac#%"
fn SDL_GL_MakeCurrent ( !SDL_Window_ptr1, !SDL_GLContext1 ) : int = "mac#%"
fn SDL_GL_SwapWindow ( !SDL_Window_ptr1 ) : void = "mac#%"

//  this is an OpenGL function, not an SDL one
fn glViewport ( GLint, GLint, GLsizei, GLsizei ) : void = "mac#%"

fn SDLNet_TCP_Recv ( !TCPsocket1, &charNZ, int ) : int = "mac#%"
fn SDLNet_ResolveHost ( &IPaddress? >> IPaddress, string, uint16 ) : int = "mac#%"
fn SDLNet_GetError () : string = "mac#%"
fn SDLNet_TCP_Open ( &IPaddress ) : TCPsocket0
fn SDLNet_TCP_Send ( !TCPsocket1, !Strptr1, int ) : int = "mac#%"

fn SDL_LoadBMP ( string ) : SDL_Surface_ptr0 = "mac#%"
fn SDL_SetWindowIcon ( !SDL_Window_ptr1, !SDL_Surface_ptr1 ) : void = "mac#%"
fn SDL_FreeSurface ( SDL_Surface_ptr0 ) : void = "mac#%"
fn SDL_GetWindowTitle ( !SDL_Window_ptr1 ) : string = "mac#%"

fn SDL_NumJoysticks () : int = "mac#%"
fn SDL_JoystickOpen ( int ) : SDL_Joystick_ptr0 = "mac#%"
fn SDL_JoystickClose ( SDL_Joystick_ptr0 ) : void = "mac#%"

fn SDLNet_Init () : int = "mac#%"
fn SDLNet_Quit () : void = "mac#%"

fn SDL_InitSubSystem ( uint32 ) : int = "mac#%"
fn SDL_CreateWindow ( string, int, int, int, int, uint32 ) : SDL_Window_ptr0 = "mac#%"
fn SDL_DestroyWindow ( SDL_Window_ptr0 ) : void = "mac#%"
fn SDL_SetWindowSize ( !SDL_Window_ptr1, int, int ) : void = "mac#%"
fn SDL_GetWindowSize ( !SDL_Window_ptr1, &int >> _, &int >> _ ) : void = "mac#%"
fn SDL_SetWindowTitle ( !SDL_Window_ptr1, string ) : void = "mac#%"

fn SDL_GetTicks() : ulint = "mac#%"
fn SDL_Delay ( ms:uint32 ) : void = "mac#%"
fn SDL_ShowCursor ( int ) : int = "mac#%"

fn SDL_RWFromFile ( file: string, mode: string ) : SDL_RWops = "mac#%"
fn SDL_RWread ( SDL_RWops, &charNZ, int, int ) : size_t = "mac#%"
fn SDL_RWreadline {bfr:nat} ( file: SDL_RWops, buffersize: int bfr ) : (bool, Strptr1)

fn SDLNet_TCP_RecvLine (sock: !TCPsocket1, maxlen: int): (bool, Strptr1)
