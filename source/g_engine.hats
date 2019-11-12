(*
###  g_engine.hats  ###

This file has code for general things & math operations in the engine.
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
staload
#include "libats/libc/"//  assert.h
#include "libats/libc/"//  math.h
#include "libats/libc/"//  time.h
#include "libats/libc/"//  signal.h
#include "libats/libc/"//  float.h

(*  SDL includes  *)

(*  ###  file system path  ###  *)

(*  ###  errors & debugging  ###  *)

(*  ###  framerate  ###  *)

(*  ###  types  ###  *)

(*  ###  floating point math  ###  *)

(*  ###  vector math  ###  *)

(*  ###  matrix math  ###  *)

(*  ###  geometry  ###  *)
