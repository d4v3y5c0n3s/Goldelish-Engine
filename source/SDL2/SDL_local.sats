(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

#define ATS_EXTERN_PREFIX "sdl_"

%{#
#include "source/SDL2/SDL_local.cats"
%}
#include "share/HATS/atslib_staload_libats_libc.hats"

fn SDL_PrintStackTrace () : void = "mac#%"

fn SDL_GL_FrameBufferErrorString ( error: $extype"GLenum" ) : string = "mac#%"
fn SDL_GL_ErrorString ( error: $extype"GLenum" ) : string = "mac#%"

fn SDL_GL_PrintInfo () : void = "mac#%"
fn SDL_GL_PrintExtensions () : void = "mac#%"
fn SDL_GL_LoadExtensions () : void = "mac#%"
fn SDL_GL_ExtensionPresent ( name: string ) : bool = "mac#%"
fn SDL_GL_ExtensionFunctionLoaded ( function: ptr ) : bool = "mac#%"

absvtype SDL_Window_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Window_ptr0 = [l:addr] SDL_Window_ptr_base(l)
vtypedef SDL_Window_ptr1 = [l:addr | l > null] SDL_Window_ptr_base(l)

absvtype SDL_Surface_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Surface_ptr0 = [l:addr] SDL_Surface_ptr_base(l)
vtypedef SDL_Surface_ptr1 = [l:addr | l > null] SDL_Surface_ptr_base(l)

absvtype SDL_Joystick_ptr_base (l:addr) = ptr(l)
vtypedef SDL_Joystick_ptr0 = [l:addr] SDL_Joystick_ptr_base(l)
vtypedef SDL_Joystick_ptr1 = [l:addr | l > null] SDL_Joystick_ptr_base(l)

absvtype SDL_GLContext_base (l:addr) = ptr(l)
vtypedef SDL_GLContext0 = [l:addr] SDL_GLContext_base(l)
vtypedef SDL_GLContext1 = [l:addr | l > null] SDL_GLContext_base(l)
abst@ype SDL_GLattr = $extype"SDL_GLattr"

typedef Mix_Music = ptr
typedef Mix_Chunk = $extype"Mix_Chunk"

typedef SDL_RWops = ptr

absvtype TCPsocket_base (l:addr) = ptr(l)
vtypedef TCPsocket0 = [l:addr] TCPsocket_base(l)
vtypedef TCPsocket1 = [l:addr | l > null] TCPsocket_base(l)

typedef IPaddress = $extype_struct "IPaddress" of {
    host=uint32,
    port=uint16
}

abst0ype GLsizei = $extype"GLsizei"
abst0ype GLint = $extype"GLint"
abst0ype GLuint = $extype"GLuint"
abst0ype GLenum = $extype"GLenum"
abst0ype GLboolean = $extype"GLboolean"
abst0ype GLfloat = $extype"GLfloat"
abst0ype GLbitfield = $extype"GLbitfield"
abst0ype GLsizeiptr = $extype"GLsizeiptr"
abst0ype GLintptr = $extype"GLintptr"
absvtype image_data = ptr
absvtype glchar_str = ptr

castfn uint32_to_GLsizei ( uint32 ) : GLsizei
castfn int32_to_GLint ( int32 ) : GLint

castfn int_to_GLsizei ( int ) : GLsizei
castfn int_to_GLint ( int ) : GLint

castfn sdl_wptr_to_ptr {l:addr} ( !SDL_Window_ptr_base(l) ) : ptr l
castfn sdl_glcptr_to_ptr {l:addr} ( !SDL_GLContext_base(l) ) : ptr l
castfn sdl_srptr_to_ptr {l:addr} ( !SDL_Surface_ptr_base(l) ) : ptr l
castfn sdl_jyptr_to_ptr {l:addr} ( !SDL_Joystick_ptr_base(l) ) : ptr l
castfn sdl_tcpptr_to_ptr {l:addr} ( !TCPsocket_base(l) ) : ptr l

overload ptrcast with sdl_wptr_to_ptr
overload ptrcast with sdl_glcptr_to_ptr
overload ptrcast with sdl_srptr_to_ptr
overload ptrcast with sdl_jyptr_to_ptr
overload ptrcast with sdl_tcpptr_to_ptr

//  use macdef to handle the SDL constants
macdef SDL_WINDOW_OPENGL = $extval(uint32, "SDL_WINDOW_OPENGL")
macdef AUDIO_S16 = $extval(uint16, "AUDIO_S16")
macdef MIX_MAX_VOLUME = $extval(int, "MIX_MAX_VOLUME")
macdef SDL_INIT_AUDIO = $extval(uint32, "SDL_INIT_AUDIO")
macdef SDL_INIT_VIDEO = $extval(uint32, "SDL_INIT_VIDEO")
macdef SDL_INIT_JOYSTICK = $extval(uint32, "SDL_INIT_JOYSTICK")
macdef SDL_WINDOWPOS_UNDEFINED = $extval(int, "SDL_WINDOWPOS_UNDEFINED")
macdef SDL_GL_SHARE_WITH_CURRENT_CONTEXT = $extval(SDL_GLattr, "SDL_GL_SHARE_WITH_CURRENT_CONTEXT")
macdef SDL_WINDOW_FULLSCREEN_DESKTOP = $extval(uint32, "SDL_WINDOW_FULLSCREEN_DESKTOP")
macdef SDL_DISABLE = $extval(int, "SDL_DISABLE")
macdef SDL_ENABLE = $extval(int, "SDL_ENABLE")
macdef SDL_QUERY = $extval(int, "SDL_QUERY")

fn Mix_OpenAudio ( frequency: int, format: uint16, channels: int, chunksize: int ) : int = "mac#%"
fn Mix_QuerySpec (frequency: &int, format: &uint16, channels: &int ) : int = "mac#%"
fn Mix_CloseAudio () : void = "mac#%"
fn Mix_PlayChannel ( channel: int, chunk: &Mix_Chunk, loops: int ) : int = "mac#%"
fn Mix_Pause ( channel: int ) : void = "mac#%"
fn Mix_Resume ( channel: int ) : void = "mac#%"
fn Mix_HaltChannel ( channel: int ) : void = "mac#%"
fn Mix_FadeInMusic ( music: Mix_Music, loops: int, ms: int ) : int = "mac#%"
fn Mix_GetError(): string = "mac#%"
fn Mix_PauseMusic(): void = "mac#%"
fn Mix_ResumeMusic(): void = "mac#%"
fn Mix_FadeOutMusic( ms: int ): int = "mac#%"
fn Mix_VolumeMusic( volume: int ): int = "mac#%"

fn SDL_GL_SetAttribute ( SDL_GLattr, int ) : int = "mac#%"
fn SDL_GL_CreateContext ( !SDL_Window_ptr1 ) : SDL_GLContext0 = "mac#%"
fn SDL_GL_SetSwapInterval ( int ) : int = "mac#%"
fn SDL_GL_DeleteContext ( SDL_GLContext0 ) : void = "mac#%"
fn SDL_GL_MakeCurrent ( !SDL_Window_ptr1, !SDL_GLContext1 ) : int = "mac#%"
fn SDL_GL_SwapWindow ( !SDL_Window_ptr1 ) : void = "mac#%"


fn SDLNet_TCP_Recv ( !TCPsocket1, &charNZ, int ) : int = "mac#%"
fn SDLNet_ResolveHost ( &IPaddress? >> IPaddress, string, uint16 ) : int = "mac#%"
fn SDLNet_GetError () : string = "mac#%"
fn SDLNet_TCP_Open ( &IPaddress ) : TCPsocket0
fn SDLNet_TCP_Send ( !TCPsocket1, !Strptr1, int ) : int = "mac#%"

fn SDL_LoadBMP ( string ) : SDL_Surface_ptr0 = "mac#%"
fn SDL_SetWindowIcon ( !SDL_Window_ptr1, !SDL_Surface_ptr1 ) : void = "mac#%"
fn SDL_FreeSurface ( SDL_Surface_ptr0 ) : void = "mac#%"
fn SDL_GetWindowTitle ( !SDL_Window_ptr1 ) : string = "mac#%"

fn SDL_NumJoysticks () : int = "mac#%"
fn SDL_JoystickOpen ( int ) : SDL_Joystick_ptr0 = "mac#%"
fn SDL_JoystickClose ( SDL_Joystick_ptr0 ) : void = "mac#%"

fn SDLNet_Init () : int = "mac#%"
fn SDLNet_Quit () : void = "mac#%"

fn SDL_InitSubSystem ( uint32 ) : int = "mac#%"
fn SDL_CreateWindow ( string, int, int, int, int, uint32 ) : SDL_Window_ptr0 = "mac#%"
fn SDL_DestroyWindow ( SDL_Window_ptr0 ) : void = "mac#%"
fn SDL_SetWindowSize ( !SDL_Window_ptr1, int, int ) : void = "mac#%"
fn SDL_GetWindowSize ( !SDL_Window_ptr1, &int >> _, &int >> _ ) : void = "mac#%"
fn SDL_SetWindowTitle ( !SDL_Window_ptr1, string ) : void = "mac#%"

fn SDL_GetTicks() : ulint = "mac#%"
fn SDL_Delay ( ms:uint32 ) : void = "mac#%"
fn SDL_ShowCursor ( int ) : int = "mac#%"

fn SDL_RWFromFile ( file: string, mode: string ) : SDL_RWops = "mac#%"
fn SDL_RWread ( SDL_RWops, &charNZ, int, int ) : size_t = "mac#%"
fn SDL_RWreadline {bfr:nat} ( file: SDL_RWops, buffersize: int bfr ) : (bool, Strptr1)

fn SDLNet_TCP_RecvLine (sock: !TCPsocket1, maxlen: int): (bool, Strptr1)

// interface for OpenGL
fn glViewport ( GLint, GLint, GLsizei, GLsizei ) : void = "mac#%"


fn glActiveTexture ( texture: GLenum ) : void = "mac#"
fn glCompressedTexImage2D ( target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, border: GLint, imagesize: GLsizei, data: !image_data ) : void = "mac#"
fn glTexImage3D ( target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, format: GLenum, etype: GLenum, data: !image_data ) : void = "mac#"
fn glCreateShader ( shadertype: GLenum ) : GLuint = "mac#"
fn glCreateProgram () : void = "mac#"
fn glShaderSource {s:nat} ( shader: GLuint, count: GLsizei, strings: arrayptr(glchar_str, s), length: &GLint ) : void = "mac#"
fn glCompileShader ( shader: GLuint ) : void = "mac#"
fn glGetShaderInfoLog ( shader: GLuint, maxlength: GLsizei, length: GLsizei, infolog: glchar_str ) : void = "mac#"
fn glAttachShader ( program: GLuint, shader: GLuint ) : void = "mac#"
fn glLinkProgram ( program: GLuint ) : void = "mac#"
fn glGetProgramInfoLog ( program: GLuint, maxlength: GLsizei, length: &GLsizei, infolog: glchar_str ) : void = "mac#"
fn glIsProgram ( program: GLuint ) : GLboolean = "mac#"
fn glIsShader ( shader: GLuint ) : GLboolean = "mac#"
fn glGetAttachedShaders {c:nat} ( program: GLuint, maxcount: GLsizei, count: &GLsizei, shaders: arrayptr(GLuint, c) ) : void = "mac#"
fn glGetUniformLocation ( program: GLuint, name: glchar_str ) : GLint = "mac#"
fn glUniform1f ( location: GLint, v0: GLfloat ) : void = "mac#"
fn glUniform1i ( location: GLint, v0: GLint ) : void = "mac#"
fn glDeleteShader ( shader: GLuint ) : void = "mac#"
fn glDeleteProgram ( program: GLuint ) : void = "mac#"
fn glUseProgram ( program: GLuint ) : void = "mac#"
fn glVertexAttribPointer ( index: GLuint, size: GLint, type: GLenum, normalized: GLboolean, stride: GLsizei, pointer: ptr ) : void = "mac#"
fn glVertexAttribDivisor ( index: GLuint, divisor: GLuint ) : void = "mac#"
fn glEnableVertexAttribArray ( index: GLuint ) : void = "mac#"
fn glDisableVertexAttribArray ( index: GLuint ) : void = "mac#"
fn glUniform2f ( location: GLint, v0: GLfloat, v1: GLfloat ) : void = "mac#"
fn glUniform3f ( location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat ) : void = "mac#"
fn glUniform4f ( location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat, v3: GLfloat ) : void = "mac#"
fn glUniformMatrix3fv ( location: GLint, count: GLsizei, transpose: GLboolean, value: &GLfloat ) : void = "mac#"
fn glUniformMatrix4fv ( location: GLint, count: GLsizei, transpose: GLboolean, value: &GLfloat ) : void = "mac#"
fn glUniform1fv ( location: GLint, count: GLsizei, value: &GLfloat ) : void = "mac#"
fn glUniform2fv ( location: GLint, count: GLsizei, value: &GLfloat ) : void = "mac#"
fn glUniform3fv ( location: GLint, count: GLsizei, value: &GLfloat ) : void = "mac#"
fn glUniform4fv ( location: GLint, count: GLsizei, value: &GLfloat ) : void = "mac#"
fn glGetShaderiv ( shader: GLuint, pname: GLenum, params: &GLint ) : void = "mac#"
fn glGetProgramiv ( program: GLuint, pname: GLenum, params: &GLint ) : void = "mac#"
fn glProgramParameteri ( program: GLuint, pname: GLenum, value: GLint ) : void = "mac#"
fn glBindAttribLocation ( program: GLuint, index: GLuint, name: !glchar_str ) : void = "mac#"
fn glGenFramebuffers {n:nat} ( n: GLsizei, ids: arrayptr(GLuint, n) ) : void = "mac#"
fn glBindFramebuffer ( target: GLenum, framebuffer: GLuint ) : void = "mac#"
fn glBlitFramebuffer ( srcx0: GLint, srcy0: GLint, srcx1: GLint, srcy1: GLint, dstx0: GLint, dsty0: GLint, dstx1: GLint, dsty1: GLint, mask: GLbitfield, filter: GLenum ) : void = "mac#"
fn glFramebufferTexture ( target: GLenum, attachment: GLenum, texture: GLuint, level: GLint ) : void = "mac#"
fn glFramebufferTexture2D ( target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint ) : void = "mac#"
fn glDeleteFramebuffers {n:nat} ( n: GLsizei, framebuffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glCheckFramebufferStatus ( target: GLenum ) : GLenum = "mac#"
fn glGenBuffers {n:nat} ( n: GLsizei, buffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glGenRenderbuffers {n:nat} ( n: GLsizei, renderbuffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glDeleteBuffers {n:nat} ( n: GLsizei, buffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glDeleteRenderbuffers {n:nat} ( n: GLsizei, renderbuffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glBindBuffer ( target: GLenum, buffer: GLuint ) : void = "mac#"
fn glBindRenderbuffer ( target: GLenum, renderbuffer: GLuint ) : void = "mac#"
fn glBufferData ( target: GLenum, size: GLsizeiptr, data: image_data, usage: GLenum ) : void = "mac#"
fn glGetBufferSubData ( target: GLenum, offset: GLintptr, size: GLsizeiptr, data: image_data ) : void = "mac#"
fn glFramebufferRenderbuffer ( target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint ) : void = "mac#"
fn glGetAttribLocation ( program: GLuint, name: glchar_str ) : GLint = "mac#"
fn glRenderbufferStorage ( target: GLenum, internalformat: GLenum, width: GLsizei, height: GLsizei ) : void = "mac#"
fn glRenderbufferStorageMultisample ( target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei ) : void = "mac#"
fn glDrawBuffers {n:nat} ( n: GLsizei, bufs: arrayptr(GLenum, n) ) : void = "mac#"
fn glGenerateMipmap ( target: GLenum ) : void = "mac#"
fn glDrawElementsInstanced ( mode: GLenum, count: GLsizei, type: GLenum, indices: image_data, instancecount: GLsizei ) : void = "mac#"
fn glPatchParameteri ( pname: GLenum, value: GLint ) : void = "mac#"
fn glPatchParameterfv {c:nat} ( pname: GLenum, values: arrayptr(GLfloat, c) ) : void = "mac#"

fn glBrokenExtension () : void = "mac#"
