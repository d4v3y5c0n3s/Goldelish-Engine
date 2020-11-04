(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

#define ATS_PACKNAME "GLDLSH.sdl_bind"
#define ATS_EXTERN_PREFIX "gldlsh_sdl_bind_"

%{#
#include "source/SDL2/SDL_local.cats"
%}

staload "./SDL_mixer.sats"
staload "./SDL_net.sats"
staload "./SDL_opengl.sats"
staload "./SDL_rwops.sats"
staload "./SDL_thread.sats"

//  SDL functions
fn SDL_PrintStackTrace () : void = "mac#%"

fn SDL_PathFullName ( path: string ) : string = "mac#%"
fn SDL_PathFileName ( path: string ) : string = "mac#%"
fn SDL_PathFileExtension ( path: string ) : string = "mac#%"
fn SDL_PathFileLocation ( path: string ) : string = "mac#%"
fn SDL_PathRelative ( path: string ) : string = "mac#%"
fn SDL_PathForwardSlashes ( path: string ) : string = "mac#%"
fn SDL_PathJoin ( fst: string, snd: string ) : string = "mac#%"
fn SDL_PathIsFile ( path: string ) : bool = "mac#%"
fn SDL_PathIsDirectory ( path: string ) : bool = "mac#%"
fn SDL_PathParentDirectory ( path: string ) : string = "mac#%"

fn SDL_GetWorkingDir () : string = "mac#%"
fn SDL_SetWorkingDir ( dir: string ) : int = "mac#%"

fn SDL_GL_FrameBufferErrorString ( error: $extype"GLenum" ) : string = "mac#%"
fn SDL_GL_ErrorString ( error: $extype"GLenum" ) : string = "mac#%"

fn SDL_GL_PrintInfo () : void = "mac#%"
fn SDL_GL_PrintExtensions () : void = "mac#%"
fn SDL_GL_LoadExtensions () : void = "mac#%"
fn SDL_GL_ExtensionPresent ( name: string ) : bool = "mac#%"
fn SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "mac#%"

fn SDL_GetTicks() : ulint = "mac#%"
fn SDL_Delay ( ms:uint32 ) : void = "mac#%"

typedef SDL_RWops = ptr
fn SDL_RWFromFile ( file: string, mode: string ) : SDL_RWops = "mac#%"