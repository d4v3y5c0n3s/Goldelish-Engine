(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

#define ATS_PACKNAME "GLDLSH.sdl_bind"
#define ATS_EXTERN_PREFIX "gldlsh_sdl_bind_"

%{#
#include "source/SDL2/SDL_local.cats"
%}

#include "./SDL_mixer.sats"
#include "./SDL_net.sats"
#include "./SDL_opengl.sats"
#include "./SDL_rwops.sats"
#include "./SDL_thread.sats"

//  SDL functions
fun SDL_PrintStackTrace () : void = "mac#%"

fun SDL_PathFullName ( path: string ) : string = "mac#%"
fun SDL_PathFileName ( path: string ) : string = "mac#%"
fun SDL_PathFileExtension ( path: string ) : string = "mac#%"
fun SDL_PathFileLocation ( path: string ) : string = "mac#%"
fun SDL_PathRelative ( path: string ) : string = "mac#%"
fun SDL_PathForwardSlashes ( path: string ) : string = "mac#%"
fun SDL_PathJoin ( fst: string, snd: string ) : string = "mac#%"
fun SDL_PathIsFile ( path: string ) : bool = "mac#%"
fun SDL_PathIsDirectory ( path: string ) : bool = "mac#%"
fun SDL_PathParentDirectory ( path: string ) : string = "mac#%"

fun SDL_GetWorkingDir () : string = "mac#%"
fun SDL_SetWorkingDir ( dir: string ) : int = "mac#%"

fun SDL_GL_FrameBufferErrorString ( error: $extype"GLenum" ) : string = "mac#%"
fun SDL_GL_ErrorString ( error: $extype"GLenum" ) : string = "mac#%"

fun SDL_GL_PrintInfo () : void = "mac#%"
fun SDL_GL_PrintExtensions () : void = "mac#%"
fun SDL_GL_LoadExtensions () : void = "mac#%"
fun SDL_GL_ExtensionPresent ( name: string ) : bool = "sta#%"
fun SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "sta#%"

fn SDL_GetTicks() : ulint = "#mac%"
fn SDL_Delay( ms:uint32 ) : void = "#mac%"