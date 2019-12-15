(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

//  SDL functions
fun SDL_PrintStackTrace () : void = "mac#%"

fun SDL_PathFullName ( dst: char ptr, path: char ptr ) : void = "mac#%"
fun SDL_PathFileName ( dst: char ptr, path: char ptr ) : void = "mac#%"
fun SDL_PathFileExtension ( dst: char ptr, path: char ptr ) : void = "mac#%"
fun SDL_PathFileLocation ( dst: char ptr, path: char ptr ) : void = "mac#%"
fun SDL_PathRelative ( dst: char ptr, path: char ptr ) : void = "mac#%"
fun SDL_PathForwardSlashes ( path: char ptr ) : void = "mac#%"
fun SDL_PathJoin ( dst: char ptr, fst: char ptr, snd: char ptr ) : void = "mac#%"
fun SDL_PathIsFile ( path: char ptr ) : bool = "mac#%"
fun SDL_PathIsDirectory ( path: char ptr ) : bool = "mac#%"
fun SDL_PathParentDirectory ( dst: char ptr, path: char ptr ) : void = "mac#%"

fun SDL_GetWorkingDir () : char ptr = "mac#%"
fun SDL_SetWorkingDir ( dir: char ptr ) : int = "mac#%"

fun SDL_GL_FrameBufferErrorString ( error: GLenum ) : char ptr = "mac#%"
fun SDL_GL_ErrorString ( error: GLenum ) : char ptr = "mac#%"

fun SDL_GL_PrintInfo () : void = "mac#%"
fun SDL_GL_PrintExtensions () : void = "mac#%"
fun SDL_GL_LoadExtensions () : void = "mac#%"
fun SDL_GL_ExtensionPresent ( name: char ptr ) : bool = "sta#%"
fun SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "sta#%"
