(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  SDL_local.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./SDL_local.sats"

implmnt SDLNet_TCP_RecvLine (sock, maxlen) = let

	fun loop ( sock: !TCPsocket1, i: int, s: stream_vt(charNZ) ) : (bool, stream_vt(charNZ)) =
		let
			var c: charNZ = ' '
			val status = SDLNet_TCP_Recv(sock, c, 1)
		in
			if status = ~1 || i = maxlen-1 then let
				val () = stream_vt_free(s) in (true, stream_vt_make_nil())
			end else if c = '\n' then (true, s)
			else if status != 0 then loop(sock, i+1, stream_vt_append(s, stream_vt_make_sing(c)))
			else (false, s)
		end
    
    val (b, strm) = loop(sock, 0, stream_vt_make_nil())
in
    (b, string_make_stream_vt(strm))
end

implmnt SDL_RWreadline ( file, buffersize ) = let

  fun loop ( f: SDL_RWops, i: int, s: stream_vt(charNZ) ) : (bool, stream_vt(charNZ)) = let
    var c: charNZ = ' '
    val status = SDL_RWread(f, c, 1, 1)
  in
    if status = ~1 || i = buffersize-1 then let
      val () = stream_vt_free(s) in (true, stream_vt_make_nil())
    end else if c = '\n' then (true, s)
    else if status != 0 then loop(f, i+1, stream_vt_append(s, stream_vt_make_sing(c)))
    else (false, s)
  end
  
  val (b, strm) = loop(file, 0, stream_vt_make_nil())
in
  (b, string_make_stream_vt(strm))
end

////
#ifdef _WIN32
#include <windows.h>
#include <winbase.h>
#endif

#if defined(__unix__) || defined(__APPLE__)
#include <execinfo.h>
#endif

#ifdef _WIN32
implement SDL_PathFullName ( dstpf | dst, path ) =
	  GetFullPathName ( path, MAX_PATH, dst, () )
#elif defined(__unix__) ||  defined(__APPLE__)
implement SDL_PathFullName ( dstpf | dst, path ) =
	  val ret: string = realpath ( path, dst )
#endif

$%{
#include <unistd.h>
%}

implement
SDL_GL_PrintInfo () =
(
val vendor: char ptr = (char ptr)glGetString(GL_VENDOR)
val renderer: char ptr = (char ptr)glGetString(GL_RENDERER)
val version: char ptr = (char ptr)glGetString(GL_VERSION)
val shader_version: char ptr = (char ptr)glGetString(GL_SHADING_LANGUAGE_VERSION)

printf ("OpenGL Info\n")
printf ("Vendor: %s\n", vendor)
printf ("Renderer: %s\n", renderer)
printf ("Version: %s\n", version)
printf ("Shader Version: %s\n", shader_version)
)

implement
SDL_GL_PrintExtensions () =
(
val extensions: char ptr = (char ptr)glGetString(GL_EXTENSIONS)
printf ("OpenGL Extensions: %s\n", extensions)
)

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
if %{# strstr(extensions, name) %} then ( true )
else ( false )
)

fun SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool =
(
if function == null then ( false )
else ( true )
)

#if !defined(__unix__) && !defined(__APPLE__)
    var GLACTIVETEXTUREFN: glActiveTexture = null
    var GLCOMPRESSEDTEXIMAGE2DFN: glCompressedTexImage2D = null
    var GLTEXIMAGE3DFN: glTexImage3D = null
#endif
var GLCREATESHADERFN: glCreateShader = null
var GLCREATEPROGRAMFN: glCreateProgram = null
var GLSHADERSOURCEFN: glShaderSource = null
var GLCOMPILESHADERFN: glCompileShader = null
var GLGETSHADERINFOLOGFN: glGetShaderInfoLog = null
var GLATTACHSHADERFN: glAttachShader = null
var GLLINKPROGRAMFN: glLinkProgram = null
var GLGETPROGRAMINFOLOGFN: glGetProgramInfoLog = null
var GLISPROGRAMFN: glIsProgram = null
var GLISSHADERFN: glIsShader = null
var GLGETATTACHEDSHADERSFN: glGetAttachedShaders = null
var GLGETUNIFORMLOCATIONFN: glGetUniformLocation = null
var GLUNIFORM1FFN: glUniform1f = null
var GLUNIFORM1IFN: glUniform1i = null
var GLDELETESHADERFN: glDeleteShader = null
var GLDELETEPROGRAMFN: glDeleteProgram = null
var GLUSEPROGRAMFN: glUseProgram = null
var GLVERTEXATTRIBPOINTERFN: glVertexAttribPointer = null
var GLVERTEXATTRIBDIVISORFN: glVertexAttribDivisor = null
var GLENABLEVERTEXATTRIBARRAYFN: glEnableVertexAttribArray = null
var GLDISABLEVERTEXATTRIBARRAYFN: glDisableVertexAttribArray = null
var GLUNIFORM2FFN: glUniform2f = null
var GLUNIFORM3FFN: glUniform3f = null
var GLUNIFORM4FFN: glUniform4f = null
var GLUNIFORMMATRIX3FVFN: glUniformMatrix3fv = null
var GLUNIFORMMATRIX4FVFN: glUniformMatrix4fv = null
var GLUNIFORM1FVFN: glUniform1fv = null
var GLUNIFORM2FVFN: glUniform2fv = null
var GLUNIFORM3FVFN: glUniform3fv = null
var GLUNIFORM4FVFN: glUniform4fv = null
var GLGETSHADERIVFN: glGetShaderiv = null
var GLGETPROGRAMIVFN: glGetProgramiv = null
var GLPROGRAMPARAMETERIFN: glProgramParameteri = null
var GLBINDATTRIBLOCATIONFN: glBindAttribLocation = null
var GLGENFRAMEBUFFERSFN: glGenFramebuffers = null
var GLBINDFRAMEBUFFERFN: glBindFramebuffer = null
var GLBLITFRAMEBUFFERFN: glBlitFramebuffer = null
var GLFRAMEBUFFERTEXTUREFN: glFramebufferTexture = null
var GLFRAMEBUFFERTEXTURE2DFN: glFramebufferTexture2D = null
var GLDELETEFRAMEBUFFERSFN: glDeleteFramebuffers = null
var GLCHECKFRAMEBUFFERSTATUSFN: glCheckFramebufferStatus = null
var GLGENBUFFERSFN: glGenBuffers = null
var GLGENRENDERBUFFERSFN: glGenRenderbuffers = null
var GLDELETEBUFFERSFN: glDeleteBuffers = null
var GLDELETERENDERBUFFERSFN: glDeleteRenderbuffers = null
var GLBINDBUFFERFN: glBindBuffer = null
var GLBINDRENDERBUFFERFN: glBindRenderbuffer = null
var GLBUFFERDATAFN: glBufferData = null
var GLGETBUFFERSUBDATAFN: glGetBufferSubData = null
var GLFRAMEBUFFERRENDERBUFFERFN: glFramebufferRenderbuffer = null
var GLGETATTRIBLOCATIONFN: glGetAttribLocation = null
var GLRENDERBUFFERSTORAGEFN: glRenderbufferStorage = null
var GLRENDERBUFFERSTORAGEMULTISAMPLEFN: glRenderbufferStorageMultisample = null
var GLDRAWBUFFERSFN: glDrawBuffers = null
var GLGENERATEMIPMAPFN: glGenerateMipmap = null
var GLDRAWELEMENTSINSTANCEDFN: glDrawElementsInstanced = null
var GLPATCHPARAMETERIFN: glPatchParameteri = null
var GLPATCHPARAMETERFVFN: glPatchParameterfv = null

var GLBROKENEXTENSIONFN: glBrokenExtension = null

fun SDL_GL_LoadExtension {a:t@ype}{b:t@ype} ( t: a, n: b ) : void =
(
var name = ( t )SDL_GL_GetProcAddress( n )
if name == null then (
   fprintf (stderr, "Failed to load function '%s', looking for function '%s'...\n", n, n"EXT")
   name = ( t )SDL_GL_GetProcAddress( n"EXT" )
)
if name == null then (
   fprintf ( stderr, "Failed to load function '%s', looking for function '%s'...\n", n"EXT", n"ARB" )
   name = ( t )SDL_GL_GetProcAddress( n"ARB" )
)
if name == null then fprintf ( stderr, "Completely failed to load OpenGL extension function '%s'.  Use of this function will crash\n", n )
)

fun SDL_GL_LoadExtensions () : void =
(
//  shaders
SDL_GL_LoadExtension ( GLCREATEPROGRAMFN, glCreateProgram )
SDL_GL_LoadExtension ( GLLINKPROGRAMFN, glLinkProgram )
SDL_GL_LoadExtension ( GLDELETEPROGRAMFN, glDeleteProgram )
SDL_GL_LoadExtension ( GLGETPROGRAMINFOLOGFN, glGetProgramInfoLog )
SDL_GL_LoadExtension ( GLUSEPROGRAMFN, glUseProgram )
SDL_GL_LoadExtension ( GLGETPROGRAMIVFN, glGetProgramiv )
SDL_GL_LoadExtension ( GLPROGRAMPARAMETERIFN, glProgramParameteri )

SDL_GL_LoadExtension ( GLCREATESHADERFN, glCreateShader )
SDL_GL_LoadExtension ( GLSHADERSOURCEFN, glShaderSource )
SDL_GL_LoadExtension ( GLCOMPILESHADERFN, glCompileShader )
SDL_GL_LoadExtension ( GLGETSHADERINFOLOGFN, glGetShaderInfoLog )
SDL_GL_LoadExtension ( GLATTACHSHADERFN, glAttachShader )
SDL_GL_LoadExtension ( GLDELETESHADERFN, glDeleteShader )
SDL_GL_LoadExtension ( GLGETSHADERIVFN, glGetShaderiv )
SDL_GL_LoadExtension ( GLISPROGRAMFN, glIsProgram )
SDL_GL_LoadExtension ( GLISSHADERFN, glIsShader )
SDL_GL_LoadExtension ( GLGETATTACHEDSHADERSFN, glGetAttachedShaders )

SDL_GL_LoadExtension ( GLGETUNIFORMLOCATIONFN, glGetUniformLocation )
SDL_GL_LoadExtension ( GLUNIFORM1FFN, glUniform1f )
SDL_GL_LoadExtension ( GLUNIFORM1IFN, glUniform1i )
SDL_GL_LoadExtension ( GLUNIFORM2FFN, glUniform2f )
SDL_GL_LoadExtension ( GLUNIFORM3FFN, glUniform3f )
SDL_GL_LoadExtension ( GLUNIFORM4FFN, glUniform4f )
SDL_GL_LoadExtension ( GLUNIFORM1FVFN, glUniform1fv )
SDL_GL_LoadExtension ( GLUNIFORM2FVFN, glUniform2fv )
SDL_GL_LoadExtension ( GLUNIFORM3FVFN, glUniform3fv )
SDL_GL_LoadExtension ( GLUNIFORM4FVFN, glUniform4fv )
SDL_GL_LoadExtension ( GLUNIFORMMATRIX3FVFN, glUniformMatrix3fv )
SDL_GL_LoadExtension ( GLUNIFORMMATRIX4FVFN, glUniformMatrix4fv )

//  attributes
SDL_GL_LoadExtension ( GLGETATTRIBLOCATIONFN, glGetAttribLocation )
SDL_GL_LoadExtension ( GLVERTEXATTRIBPOINTERFN, glVertexAttribPointer )
SDL_GL_LoadExtension ( GLVERTEXATTRIBDIVISORFN, glVertexAttribDivisor )
SDL_GL_LoadExtension ( GLENABLEVERTEXATTRIBARRAYFN, glEnableVertexAttribArray )
SDL_GL_LoadExtension ( GLDISABLEVERTEXATTRIBARRAYFN, glDisableVertexAttribArray )
SDL_GL_LoadExtension ( GLBINDATTRIBLOCATIONFN, glBindAttribLocation )

//  textures
SDL_GL_LoadExtension ( GLGENERATEMIPMAPFN, glGenerateMipmap )
#if !defined(__unix__) && !defined(__APPLE__)
SDL_GL_LoadExtension ( GLACTIVETEXTUREFN, glActiveTexture )
SDL_GL_LoadExtension ( GLCOMPRESSEDTEXIMAGE2DFN, glCompressedTexImage2D )
SDL_GL_LoadExtension ( GLTEXIMAGE3DFN, glTexImage3D )
#endif

//  buffers
SDL_GL_LoadExtension ( GLGENBUFFERSFN, glGenBuffers )
SDL_GL_LoadExtension ( GLBINDBUFFERFN, glBindBuffer )
SDL_GL_LoadExtension ( GLBUFFERDATAFN, glBufferData )
SDL_GL_LoadExtension ( GLGETBUFFERSUBDATAFN, glGetBufferSubData )
SDL_GL_LoadExtension ( GLDELETEBUFFERSFN, glDeleteBuffers )
SDL_GL_LoadExtension ( GLDRAWBUFFERSFN, glDrawBuffers )

SDL_GL_LoadExtension ( GLGENRENDERBUFFERSFN, glGenRenderbuffers )
SDL_GL_LoadExtension ( GLBINDRENDERBUFFERFN, glBindRenderbuffer )
SDL_GL_LoadExtension ( GLRENDERBUFFERSTORAGEFN, glRenderbufferStorage )
SDL_GL_LoadExtension ( GLRENDERBUFFERSTORAGEMULTISAMPLEFN, glRenderbufferStorageMultisample )
SDL_GL_LoadExtension ( GLDELETERENDERBUFFERSFN, glDeleteRenderbuffers )

SDL_GL_LoadExtension ( GLGENFRAMEBUFFERSFN, glGenFramebuffers )
SDL_GL_LoadExtension ( GLBINDFRAMEBUFFERFN, glBindFramebuffer )
SDL_GL_LoadExtension ( GLBLITFRAMEBUFFERFN, glBlitFramebuffer )
SDL_GL_LoadExtension ( GLFRAMEBUFFERTEXTUREFN, glFramebufferTexture )
SDL_GL_LoadExtension ( GLFRAMEBUFFERTEXTURE2DFN, glFramebufferTexture2D )
SDL_GL_LoadExtension ( GLDELETEFRAMEBUFFERSFN, glDeleteFramebuffers )
SDL_GL_LoadExtension ( GLCHECKFRAMEBUFFERSTATUSFN, glCheckFramebufferStatus )
SDL_GL_LoadExtension ( GLFRAMEBUFFERRENDERBUFFERFN, glFramebufferRenderbuffer )

//  tessellation
SDL_GL_LoadExtension ( GLPATCHPARAMETERIFN, glPatchParameteri )
SDL_GL_LoadExtension ( GLPATCHPARAMETERFVFN, glPatchParameterfv )

//  misc
SDL_GL_LoadExtension ( GLDRAWELEMENTSINSTANCEDFN, glDrawElementsInstanced )

//  test for missing extension
//SDL_GL_LoadExtension ( GLBROKENEXTENSIONFN, glBrokenExtension )
)

#ifdef __unix__
fun SDL_PrintStackTrace () : void = ()

#elif __APPLE__
#define UNW_LOCAL_ONLY
%{#
#include <libunwind.h>
%}
fun SDL_PrintStackTrace () : void =
(
var cursor: unw_cursor_t = (); var uc: unw_context_t = ()
var n = 0

unw_context( &uc )
unw_init_local ( &cursor, &uc )

fun while_loop () : void =
(
if not unw_step( &cursor ) > 0 then (
val ip, sp, off : unw_word_t = ()
unw_get_reg ( &cursor, UNW_REG_IP, &ip )
unw_get_reg ( &cursor, UNW_REF_SP, &sp )

val symbol(*[256]*) = {"<unknown>"}
unw_get_proc_name ( &cursor, symbol, sizeof(symbol), &off )

printf ( "#%-2d 0x%016" PRIxPTR " sp=0x%016" PRIxPTR " %s + 0x%" PRIxPTR "\n", n + 1, (uintptr_t)ip, (uintptr_t)sp, symbol, (uintptr_t)off )

while_loop ()
)
else ( () )
)
)

#elif _WIN32

%{#
#include "DbgHelp.h"
%}

fun SDL_PrintStackTrace () : void = ()

#endif
