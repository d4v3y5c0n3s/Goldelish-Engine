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

implement SDL_PathFileName ( dst: char ptr, path: char ptr ) = (

	  exception END_OF_NAME of ()

	  fun loop ( index: int, path: string ) :
)