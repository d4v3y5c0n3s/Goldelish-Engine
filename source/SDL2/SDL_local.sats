(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  SDL_local.sats  ###

more complete SDL function definitions
*)

#define ATS_EXTERN_PREFIX "sdl_"

%{#
#include "source/SDL2/SDL_local.cats"
%}
#include "share/HATS/atslib_staload_libats_libc.hats"

typedef GLsizei (s:int) = size_t(s)
typedef GLsizei = [s:int] GLsizei(s)
typedef GLint (i:int) = int(i)
typedef GLint = [i:int] GLint(i)
typedef GLuint (u:int) = uint(u)
typedef GLenum (e:int) = uint(e)
typedef GLboolean (b:bool) = bool(b)
typedef GLfloat = float
abst0ype GLbitfield = $extype"GLbitfield"
typedef GLsizeiptr (a:vt@ype) = sizeof_t(a)
vtypedef GLintptr (a:vt@ype, l:addr, n:int, i:int) = [i <= n; i >= 0] (array_v(a,l,n) | int(i))
vtypedef GLcharstr (s:int) = strnptr(s)
absvt0ype GL_Shader = [s:int] GLuint(s)
absvt0ype GL_Framebuffer = [f:int] GLuint(f)
absvt0ype GL_Renderbuffer = [r:int] GLuint(r)
absvt0ype GL_Texture = [t:int] GLuint(t)
abst0ype GL_Program (p:int) = GLuint(p)
dataprop GL_UnifVar (u:int) = | EXISTS(u) | NONE(~1)
datasort AttrbT= | ATTR | VERT
absvt0ype GL_Attrb_base ( t: AttrbT, a: int) = GLint(a)
vtypedef GL_Attrb (t: AttrbT, a: int) = [a>=0] GL_Attrb_base(t,a)
vtypedef GL_VertAttrb = [a:nat] GL_Attrb(VERT(),a)
absvt0ype  GL_Buffer = [b:int] GLuint(b)

//  opengl enums
#define GL_TEXTURE0 0x84C0
#define GL_MAX_TEXTURE_UNITS 0x84E2
//
#define GL_TEXTURE_2D 0x0DE1
#define GL_PROXY_TEXTURE_2D 0x8064
#define GL_TEXTURE_1D_ARRAY 0x8C18
#define GL_PROXY_TEXTURE_1D_ARRAY 0x8C19
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X 0x8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X 0x8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y 0x8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y 0x8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z 0x8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z 0x851A
#define GL_PROXY_TEXTURE_CUBE_MAP 0x851B
//
#define GL_FRAMEBUFFER_COMPLETE 0x8CD5
#define GL_FRAMEBUFFER_UNDEFINED 0x8219
#define GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT 0x8CD6
#define GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT 0x8CD7
#define GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER 0x8CDB
#define GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER 0x8CDC
#define GL_FRAMEBUFFER_UNSUPPORTED 0x8CDD
#define GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE 0x8D56
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS 0x8DA8
//
#define GL_INVALID_ENUM 0x0500
#define GL_INVALID_VALUE 0x0501
#define GL_INVALID_OPERATION 0x0502
#define GL_STACK_OVERFLOW 0x0503
#define GL_STACK_UNDERFLOW 0x0504
#define GL_OUT_OF_MEMORY 0x0505
#define GL_INVALID_FRAMEBUFFER_OPERATION 0x0506
#define GL_TABLE_TOO_LARGE 0x8031
//
#define GL_RENDERBUFFER 0x8D41
#define GL_MAX_RENDERBUFFER_SIZE 0x84E8
//
#define GL_DEPTH_COMPONENT24 0x81A6

fn SDL_PrintStackTrace () : void = "mac#%"

fn SDL_GL_FrameBufferErrorString {e:int | e == GL_FRAMEBUFFER_COMPLETE
|| e == GL_FRAMEBUFFER_UNDEFINED || e == GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
|| e == GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT || e == GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER
|| e == GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER || e == GL_FRAMEBUFFER_UNSUPPORTED
|| e == GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE || e == GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS}
( error: GLenum(e) ) : string = "mac#%"
fn SDL_GL_ErrorString {e:int | e >= GL_INVALID_ENUM || e <= GL_INVALID_FRAMEBUFFER_OPERATION
|| e == GL_TABLE_TOO_LARGE}
( error: GLenum(e) ) : string = "mac#%"

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

absvtype TCPsocket_base (l:addr) = ptr(l)
vtypedef TCPsocket0 = [l:addr] TCPsocket_base(l)
vtypedef TCPsocket1 = [l:addr | l > null] TCPsocket_base(l)

typedef IPaddress = $extype_struct "IPaddress" of {
    host=uint32,
    port=uint16
}

castfn uint32_to_GLsizei {s:nat} ( uint32(s) ) : GLsizei(s)
castfn int32_to_GLint {i:int} ( int32(i) ) : GLint(i)

castfn int_to_GLsizei {s:nat} ( int(s) ) : GLsizei(s)
castfn int_to_GLint {i:int} ( int(i) ) : GLint(i)

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

fn SDL_LoadBMP ( !Strptr1 ) : SDL_Surface_ptr0 = "mac#%"
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

// interface for OpenGL

fn glViewport ( GLint, GLint, GLsizei, GLsizei ) : void = "mac#%"

fn glActiveTexture {e:int | e >= GL_TEXTURE0; e < GL_MAX_TEXTURE_UNITS}
( texture: GLenum(e) ) : void = "mac#"
sortdef target = {t:int | t == GL_TEXTURE_2D
  || t == GL_PROXY_TEXTURE_2D
  || t == GL_PROXY_TEXTURE_1D_ARRAY
  || t >= GL_TEXTURE_CUBE_MAP_POSITIVE_X && t <= GL_PROXY_TEXTURE_CUBE_MAP }
sortdef internalformat = {i:int | i==i}
typedef imsize (bs, w, bw, h, bh) = GLsizei(bs * (w/bw) * (h/bh))
fn glCompressedTexImage2D {t:target; i:internalformat}
{bs,w,bw,h,bh:int; sz:int | sz==(bs * (w/bw) * (h/bh))}
( target: GLenum(t), level: GLint, internalformat: GLenum(i), width: GLsizei(w),
height: GLsizei(h), border: GLint(0), imagesize: GLsizei(sz), data: !arrayptr(char?, sz) >> arrayptr(char, sz) ) : void = "mac#"
(*
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
*)
fn glGenFramebuffers {n:nat} ( n: GLsizei(n), ids: !arrayptr(GL_Framebuffer?, n) >> arrayptr(GL_Framebuffer, n) ) : void = "mac#"
fn glGenFramebuffers ( n: GLsizei(1), id: &GL_Framebuffer? >> GL_Framebuffer ) : void = "mac#"
(*
fn glBindFramebuffer ( target: GLenum, framebuffer: GLuint ) : void = "mac#"
fn glBlitFramebuffer ( srcx0: GLint, srcy0: GLint, srcx1: GLint, srcy1: GLint, dstx0: GLint, dsty0: GLint, dstx1: GLint, dsty1: GLint, mask: GLbitfield, filter: GLenum ) : void = "mac#"
fn glFramebufferTexture ( target: GLenum, attachment: GLenum, texture: GLuint, level: GLint ) : void = "mac#"
fn glFramebufferTexture2D ( target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint ) : void = "mac#"
fn glDeleteFramebuffers {n:nat} ( n: GLsizei, framebuffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glCheckFramebufferStatus ( target: GLenum ) : GLenum = "mac#"
fn glGenBuffers {n:nat} ( n: GLsizei, buffers: arrayptr(GLuint, n) ) : void = "mac#"
*)
fn glGenRenderbuffers {n:nat} ( n: GLsizei(n), renderbuffers: !arrayptr(GL_Renderbuffer?, n) >> arrayptr(GL_Renderbuffer, n) ) : void = "mac#"
fn glGenRenderbuffers ( n: GLsizei(1), renderbuffers: &GL_Renderbuffer? >> GL_Renderbuffer ) : void = "mac#"
(*
fn glDeleteBuffers {n:nat} ( n: GLsizei, buffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glDeleteRenderbuffers {n:nat} ( n: GLsizei, renderbuffers: arrayptr(GLuint, n) ) : void = "mac#"
fn glBindBuffer ( target: GLenum, buffer: GLuint ) : void = "mac#"
*)
fn glBindRenderbuffer ( target: GLenum(GL_RENDERBUFFER), renderbuffer: GL_Renderbuffer ) : void = "mac#"
(*
fn glBufferData ( target: GLenum, size: GLsizeiptr, data: image_data, usage: GLenum ) : void = "mac#"
fn glGetBufferSubData ( target: GLenum, offset: GLintptr, size: GLsizeiptr, data: image_data ) : void = "mac#"
fn glFramebufferRenderbuffer ( target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint ) : void = "mac#"
fn glGetAttribLocation ( program: GLuint, name: glchar_str ) : GLint = "mac#"
*)
sortdef rbif = {r:int | r==GL_DEPTH_COMPONENT24}
fn glRenderbufferStorage {w,h:int; i:rbif | w <= GL_MAX_RENDERBUFFER_SIZE; h <= GL_MAX_RENDERBUFFER_SIZE}
( target: GLenum(GL_RENDERBUFFER), internalformat: GLenum(i), width: GLsizei(w), height: GLsizei(h) ) : void = "mac#"
(*
fn glRenderbufferStorageMultisample ( target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei ) : void = "mac#"
fn glDrawBuffers {n:nat} ( n: GLsizei, bufs: arrayptr(GLenum, n) ) : void = "mac#"
fn glGenerateMipmap ( target: GLenum ) : void = "mac#"
fn glDrawElementsInstanced ( mode: GLenum, count: GLsizei, type: GLenum, indices: image_data, instancecount: GLsizei ) : void = "mac#"
fn glPatchParameteri ( pname: GLenum, value: GLint ) : void = "mac#"
fn glPatchParameterfv {c:nat} ( pname: GLenum, values: arrayptr(GLfloat, c) ) : void = "mac#"

fn glBrokenExtension () : void = "mac#"
*)
