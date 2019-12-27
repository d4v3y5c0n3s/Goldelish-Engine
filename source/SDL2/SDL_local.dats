(*
###  SDL_local.dats  ###

the full function definitions for SDL & the initial values for the OpenGL extensions
*)

//  include statements go here
staload "SDL_local.sats"
$%{
#include "SDL_rwops.h"
%}

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

$%{
#include <unistd.h>
%}

implement
SDL_PathFileName ( dst, path ) = let
		 string_copy_string( dst, file, len ); dst[len] := "\0"
in
fun string_copy_size ( to: string, from: string, length: size_t ) : void =
(
//  ---  WIP  ---
%{#
strncpy (to, from, length)
%}
)

fun reverse_iterate ( index: int, ext_loc: int, path_name: string ) : ( int, int ) = (
    if path_name[index] == '/' then (index, ext_loc)
    if path_name[index] == '\\' then (index, ext_loc)
    if path_name[index] == '.' then (
       reverse_iterate ( index - 1, index, path_name )
       ) else (
       	 reverse_iterate ( index - 1, ext_loc, path_name )
	 )
)
val results = reverse_iterate ( path.size(), 0, path )
val file = path + results.0 + 1
val len = results.1 - i - 1;
end

implement
SDL_PathFileExtension ( dst, path ) = let
		      string_copy (dst, f_ext)
in
fun string_copy ( destination: string, file_ext: string ) : void = (
//  WIP  //
%{#
strcpy ( destination, file_ext )
%}
)

fun reverse_iterate ( i: int, ext_len ) : ( int, int ) = (
    if path[i] != '.' then reverse_iterate (i-1, ext_len+1)
    if path[i] == '.' then ( i, ext_len )
    else ( reverse_iterate (i-1, ext_len) )
)
val results = reverse_iterate ( path.size(), 0 )
val prev = path.size() - results.1 + 1
val f_ext = path + prev
end

implement
SDL_PathFileLocation ( dst, path ) = let
in
end

implement
SDL_PathParentDirectory ( dst, path ) = let
in
end

implement
SDL_PathRelative ( dst, path ) = let
in
end

implement
SDL_PathForwardSlashes ( path ) = let
in
end

implement
SDL_PathJoin ( dst, fst, snd ) = let
in
end

implement
SDL_PathIsFile ( path ) = let
in
end

implement
SDL_PathIsDirectory ( path: string ) = let
in
end

//  static char curr_dir[MAX_PATH];

implement
SDL_GetWorkingDir () = let
in
end

implement
SDL_SetWorkingDir ( dir ) = let
in
end

implement
SDL_GL_PrintInfo () = let
in
end

implement
SDL_GL_PrintExtensions () = let
in
end

val gl_error_string_invalid_enum = "Invalid Enum"
val gl_error_string_invalid_value = "Invalid Value"
val gl_error_string_invalid_operation = "Invalid Operation"
val gl_error_string_out_of_memory = "Out of Memory"
val gl_error_string_invalid_framebuffer_operation = "Invalid Framebuffer Operation"
val gl_error_string_stack_overflow = "Stack Overflow"
val gl_error_string_stack_underflow = "Stack Underflow"
val gl_error_string_table_too_large = "Table Too Large"
val gl_error_string_no_error = "No Error"

fun SDL_GL_ErrorString ( error: GLenum ) : char ptr = (
case+ error of
     | GL_INVALID_ENUM => gl_error_string_invalid_enum
     | GL_INVALID_VALUE => gl_error_string_invalid_value
     | GL_INVALID_OPERATION => gl_error_string_invalid_operation
     | GL_OUT_OF_MEMORY => gl_error_string_out_of_memory
     | GL_INVALID_FRAMEBUFFER_OPERATION => gl_error_string_invalid_framebuffer_operation
     | GL_STACK_OVERFLOW => gl_error_string_stack_overflow
     | GL_STACK_UNDERFLOW => gl_error_string_stack_underflow
     | GL_TABLE_TOO_LARGE => gl_error_string_table_too_large
     | _ => gl_error_string_no_error
)

val gl_error_string_framebuffer_complete = "Framebuffer Complete"
val gl_error_string_framebuffer_undefined = "Framebuffer Undefined"
val gl_error_string_framebuffer_incomplete_attach = "Framebuffer Incomplete Attachment"
val gl_error_string_framebuffer_incomplete_missing_attach = "Framebuffer No Attachments"
val gl_error_string_framebuffer_incomplete_draw = "Framebuffer Incomplete Draw"
val gl_error_string_framebuffer_incomplete_read = "Framebuffer Incomplete Read"
val gl_error_string_framebuffer_unsupported = "Framebuffer Unsupported"
val gl_error_string_framebuffer_incomplete_multisample = "Framebuffer Badly Configured Multisamples"
val gl_error_string_framebuffer_incomplete_layer_targets = "Framebuffer Badly Configured Layer Targets"

fun SDL_GL_FrameBufferErrorString ( error: GLenum ) : char ptr = (
case error of
| GL_FRAMEBUFFER_COMPLETE => gl_error_string_framebuffer_complete
| GL_FRAMEBUFFER_UNDEFINED => gl_error_string_framebuffer_undefined
| GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => gl_error_string_framebuffer_incomplete_attach
| GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => gl_error_string_framebuffer_incomplete_missing_attach
| GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER => gl_error_string_framebuffer_incomplete_draw
| GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER => gl_error_string_framebuffer_incomplete_read
| GL_FRAMEBUFFER_UNSUPPORTED => gl_error_string_framebuffer_unsupported
| GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE => gl_error_string_framebuffer_incomplete_multisample
| GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS => gl_error_string_framebuffer_incomplete_layer_targets
| _ => gl_error_string_no_error
)

fun SDL_GL_ExtensionPresent ( name: char ptr ) : bool = (
val extensions = %{#
(const char*)glGetString(GL_EXTENSIONS);
%}
if then (

)else (

)
)

fun SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool =