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

(*  ###  file system path  ###  *)

(*  ###  errors & debugging  ###  *)

(*  ###  framerate  ###  *)

(*  ###  types  ###  *)

(*  ###  floating point math  ###  *)

(*  ###  vector math  ###  *)

(*  ###  matrix math  ###  *)

(*  ###  geometry  ###  *)
