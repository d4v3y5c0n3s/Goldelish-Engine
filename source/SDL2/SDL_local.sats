(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

//  include the .cats file
%{#
#include "SDL_local.cats"
%}

//  SDL functions
fun SDL_PrintStackTrace () : void = "mac#%"

fun SDL_PathFullName ( dst: string, path: string ) : void = "mac#%"
fun SDL_PathFileName ( dst: string, path: string ) : void = "mac#%"
fun SDL_PathFileExtension ( dst: string, path: string ) : void = "mac#%"
fun SDL_PathFileLocation ( dst: string, path: string ) : void = "mac#%"
fun SDL_PathRelative ( dst: string, path: string ) : void = "mac#%"
fun SDL_PathForwardSlashes ( path: string ) : void = "mac#%"
fun SDL_PathJoin ( dst: string, fst: string, snd: string ) : void = "mac#%"
fun SDL_PathIsFile ( path: string ) : bool = "mac#%"
fun SDL_PathIsDirectory ( path: string ) : bool = "mac#%"
fun SDL_PathParentDirectory ( dst: string, path: string ) : void = "mac#%"

fun SDL_GetWorkingDir () : string = "mac#%"
fun SDL_SetWorkingDir ( dir: string ) : int = "mac#%"

fun SDL_GL_FrameBufferErrorString ( error: GLenum ) : string = "mac#%"
fun SDL_GL_ErrorString ( error: GLenum ) : string = "mac#%"

fun SDL_GL_PrintInfo () : void = "mac#%"
fun SDL_GL_PrintExtensions () : void = "mac#%"
fun SDL_GL_LoadExtensions () : void = "mac#%"
fun SDL_GL_ExtensionPresent ( name: string ) : bool = "sta#%"
fun SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "sta#%"
