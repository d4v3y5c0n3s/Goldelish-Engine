(*
###  SDL_local.dats  ###

the full function definitions for SDL & the initial values for the OpenGL extensions
*)

//  include statements go here
#include "SDL_local.sats"
#include "SDL_rwops.h"

//  standard lib includes
staload STDLIB = "libats/libc/SATS/stdlib.sats"//  stdlib.h
staload _(*STDLIB*) = "libats/libc/DATS/stdlib.dats"
staload STDIO = "libats/libc/SATS/stdio.sats"//  stdio.h
staload _(*STDIO*) = "libats/libc/DATS/stdio.dats"
staload DIRENT = "libats/libc/SATS/direct.sats"//  dirent.h
staload _(*DIRENT*) = "libats/libc/DATS/direct.dats"
staload UNISTD = "libats/libc/SATS/unistd.sats"
staload _(*UNISTD*) = "libats/libc/DATS/unistd.dats"

#ifdef _WIN32
#include <windows.h>
#include <winbase.h>
#endif

#if defined(__unix__) || defined(__APPLE__)
#include <execinfo.h>
#endif

#ifdef _WIN32
implement SDL_PathFullName ( dst, path ) =
	  GetFullPathName ( path, MAX_PATH, dst, () )
#elif defined(__unix__) ||  defined(__APPLE__)
implement SDL_PathFullName ( dst, path ) =
	  val ret: char ptr = realpath ( path, dst )
#endif

%{
#include <unistd.h>
%}

abst@ype file_dest = int


implement
SDL_PathFileName ( dst: string ptr, path: string ) =
(
fun reverse_iterate ( index: int, ext_loc: int, path_name: string ) : ( int, int ) = (
    if path_name[index] == '/' then (index, ext_loc)
    if path_name[index] == '\\' then (index, ext_loc)
    if path_name[index] == '.' then (
       reverse_iterate ( index - 1, index, path_name )
    ) else (
      reverse_iterate ( index - 1, ext_loc, path_name )
    )
)

//
let
	//; dst[len] := "\0"
in
	val results = reverse_iterate ( path.size(), 0, path )//  stores both index and ext_loc in a tuple
	val file = path + results.0 + 1
	val len = results.1 - i - 1;
end
)

implement
SDL_PathFileExtension ( dst: string ptr, path: string ) =

implement
SDL_PathFileLocation ( dst: string ptr, path: string ) =

implement
SDL_PathParentDirectory ( dst: string ptr, path: string ) =

implement
SDL_PathRelative ( dst: string ptr, path: string ) =

implement
SDL_PathForwardSlashes ( path: string ) =

implement
SDL_PathJoin ( dst: string ptr, fst: string ptr, snd: string ptr ) =

implement
SDL_PathIsFile ( path: string ) =

implement
SDL_PathIsDirectory ( path: string ) =

//  static char curr_dir[MAX_PATH];

implement
SDL_GetWorkingDir () =

implement
SDL_SetWorkingDir ( dir: string ptr ) =

implement
SDL_GL_PriintInfo () =

implement
SDL_GL_PrintExtensions () =