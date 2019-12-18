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

//  this function has been modified to return a string in order to be pure
implement
SDL_PathFileName ( dst: string, path: string ) =
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

let
	val file = path + results.0 + 1;  val len = results.1 - i - 1;
in
	val results = reverse_iterate ( path.size(), 0, path )//  stores both index and ext_loc in a tuple
end

//  the following code mutates return_str
let
	return_str[len] = "\0"
in
	var return_str = file
end
)

implement