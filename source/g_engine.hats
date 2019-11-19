(*
###  g_engine.hats  ###

This file has code for general things & math operations in the engine.
*)

(*
	NOTICE:
	The pointer handling below is incorrect (char ptr) because I haven't reached that point in the Introduction to ATS book.  Once I have, I will revise this and other files so that the engine will run properly.
*)

(*  standard lib includes  *)
//  ATS includes the C standard libraries ready-to-use
staload STDLIB = "libats/libc/SATS/stdlib.sats"//  stdlib.h
staload _(*STDLIB*) = "libats/libc/DATS/stdlib.dats"
staload STDIO = "libats/libc/SATS/stdio.sats"//  stdio.h
staload _(*STDIO*) = "libats/libc/DATS/stdio.dats"
//  stdbool.h (bools are already in ATS)
staload STRINGS = "libats/libc/SATS/strings.sats"//  string.h
staload _(*STRINGS*) = "libats/libc/DATS/strings.dats"
staload DIRENT = "libats/libc/SATS/direct.sats"//  dirent.h
staload _(*DIRENT*) = "libats/libc/DATS/direct.dats"
//  assert.h (I don't think this is needed in ATS)
staload MATH = "libats/libc/SATS/math.sats"//  math.h
staload _(*MATH*) = "libats/libc/DATS/math.dats"
staload TIME = "libats/libc/SATS/time.sats"//  time.h
staload _(*TIME*) = "libats/libc/DATS/time.dats"
staload SIGNAL = "libats/libc/SATS/signal.sats"//  signal.h
staload FLOAT = "libats/libc/SATS/float.sats"//  float.h
staload _(*FLOAT*) = "libats/libc/DATS/float.dats"

(*  SDL includes  *)
//  Here are staloads for SDL from the SDL folder (currently writing the .sats & .cats files for this
staload SDL2 = "SDL2/SDL.sats"//
staload SDL2_OPENGL = "SDL2/SDL_OPENGL.sats"//
staload SDL2_RWOPS = "SDL2/SDL_RWOPS.sats"//
staload SDL2_MIXER = "SDL2/SDL_MIXER.sats"//
staload SDL2_NET = "SDL2/SDL_NET.sats"//
staload SDL2_LOCAL = "SDL2/SDL_LOCAL.sats"//

#ifndef MAX_PATH
#define MAX_PATH 512
#endif
#define ERROR_BUFFER_SIZE	2048 * 4
#define DEBUG_BUFFER_SIZE	2048 * 4
#define WARNING_BUFFER_SIZE	2048 * 4

(*  ###  file system path  ###  *)
typedef fpath = @{path=char ptr[MAX_PATH]}// this is a record type (P.S. this may not work, apparently C arrays are in ATS, but there wasn't much info on this)

fun P ( path: char ptr ) : fpath = "sta#P"

fun fpath_full (path: fpath) : fpath = "sta#fpath_full"
fun fpath_file (path: fpath) : fpath = "sta#fpath_file"
fun fpath_file_location (path: fpath) : fpath = "sta#fpath_file_location"
fun fpath_file_extension (path: fpath) : fpath = "sta#fpath_file_extension"

(*  --  NOTICE: This may need to be rethought for ATS  --
(*  ###  errors & debugging  ###  *)
fun at_error(f: void -> void, c: char ptr): void = "sta#at_error"
fun at_warning(f: void -> void, c: char ptr): void = "sta#at_warning"
fun at_debug(f: void -> void, c: char ptr): void = "sta#at_debug"

fun error_(c: char ptr): void = "sta#error_"
fun warning_(c: char ptr): void = "sta#warning_"
fun debug_(c: char ptr): void = "sta#debug_"

fun error_buf(size: int): char = "sta#error_buf"//ERROR_BUFFER_SIZE
fun error_str(): char = "sta#error_str"//ERROR_BUFFER_SIZE

fun warning_buf(): char = "sta#warning_buf"//WARNING_BUFFER_SIZE
fun warning_str(): char = "sta#warning_str"//WARNING_BUFFER_SIZE

fun debug_buf(): char = "sta#debug_buf"//DEBUG_BUFFER_SIZE
fun debug)str(): char = "sta#debug_str"//DEBUG_BUFFER_SIZE

#define error()

#define warning()

#define debug()

#define alloc_check()
*)

(*  ###  framerate  ###  *)

(*  ###  types  ###  *)

(*  ###  floating point math  ###  *)

(*  ###  vector math  ###  *)

(*  ###  matrix math  ###  *)

(*  ###  geometry  ###  *)
