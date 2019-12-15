/*
###  SDL_local.h  ###

//holds the C functions for the OpenGL extensions
*/

//  C includes
#include "SDL2/SDL.h"
#include "SDL2/SDL_opengl.h"
#include "SDL2/SDL_thread.h"

#ifdef MAX_PATH
       //do nothing
#elif PATH_MAX
      #define MAX_PATH PATH_MAX
#else
	#define MAX_PATH 256
#endif

#ifndef GLchar
       #define GLchar char
#endif
#ifndef GLsizeptr
	#define GLsizeptr
#endif

typedef GLuint ( APIENTRY * GLCREATESHADERFN )( GLuint type );
typedef GLuint ( APIENTRY * GLCREATEPROGRAMFN )( void );
typedef void ( APIENTRY * GLSHADERSOURCEFN )( GLuint shader, GLsizei count, const GLchar** string, const GLint* length );
typedef void ( APIENTRY * GLCOMPILESHADERFN )( GLuint shader );
typedef void ( APIENTRY * GLGETSHADERINFOLOGFN )( GLuint shader, GLsizei bufsize, GLsizei* length, GLchar* infolog );
typedef void ( APIENTRY * GLATTACHSHADERFN )( GLuint program, GLuint shader );
typedef void ( APIENTRY * GLLINKPROGRAMFN )( GLuint program );
typedef void ( APIENTRY * GLGETPROGRAMINFOLOGFN )( GLuint program, GLsizei bufsize, GLsizei* length, GLchar* infolog );
typedef GLboolean ( APIENTRY * GLISPROGRAMFN )( GLuint program );
typedef GLboolean ( APIENTRY * GLISSHADERFN )( GLuint shader );
typedef void ( APIENTRY * GLGETATTACHEDSHADERSFN )( GLuint program, GLsizei maxCount, GLsizei* count, GLuint* shaders );
typedef GLuint ( APIENTRY * GLGETUNIFORMLOCATIONFN )( GLuint program, const GLchar* name );
typedef void ( APIENTRY * GLACTIVETEXTUREFN )( GLenum texture );
typedef void ( APIENTRY * GLUNIFORM1FFN )( GLint location, GLfloat x );
typedef void ( APIENTRY * GLUNIFORM1IFN )( GLint location, GLint x );
typedef void ( APIENTRY * GLDELETESHADERFN )( GLuint shader );
typedef void ( APIENTRY * GLDELETEPROGRAMFN )( GLuint program );
typedef void ( APIENTRY * GLUSEPROGRAMFN )( GLuint program );
typedef void ( APIENTRY * GLVERTEXATTRIBPOINTERFN )( GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr );
typedef void ( APIENTRY * GLVERTEXATTRIBDIVISORFN )( GLuint indx, GLuint divisor );
typedef void ( APIENTRY * GLENABLEVERTEXATTRIBARRAYFN )( GLuint index );
typedef void ( APIENTRY * GLDISABLEVERTEXATTRIBARRAYFN )( GLuint index );
typedef void ( APIENTRY * GLUNIFORM2FFN )( GLint location, GLfloat x, GLfloat y );
typedef void ( APIENTRY * GLUNIFORM3FFN )( GLint location, GLfloat x, GLfloat y, GLfloat z );
typedef void ( APIENTRY * GLUNIFORM4FFN )( GLint location, GLfloat x, GLfloat y, GLfloat z, GLfloat w );
typedef void ( APIENTRY * GLUNIFORMMATRIX3FVFN )( GLint location, GLsizei count, GLboolean transpose, const GLfloat* value );
typedef void ( APIENTRY * GLUNIFORMMATRIX4FVFN )( GLint location, GLsizei count, GLboolean transpose, const GLfloat* value );
typedef void ( APIENTRY * GLUNIFORM1FVFN )( GLint location, GLsizei count, const GLfloat* value );
typedef void ( APIENTRY * GLUNIFORM2FVFN )( GLint location, GLsizei count, const GLfloat* value );
typedef void ( APIENTRY * GLUNIFORM3FVFN )( GLint location, GLsizei count, const GLfloat* value );
typedef void ( APIENTRY * GLUNIFORM4FVFN )( GLint location, GLsizei count, const GLfloat* value );
typedef void ( APIENTRY * GLGETSHADERIVFN )( GLuint shader, GLenum pname, GLint* params );
typedef void ( APIENTRY * GLGETPROGRAMIVFN )( GLuint program, GLenum pname, GLint* params );
typedef void ( APIENTRY * GLPROGRAMPARAMETERIFN )( GLuint program, GLenum pname, GLint value );
typedef void ( APIENTRY * GLBINDATTRIBLOCATIONFN )( GLuint program, GLuint index, const GLchar* name );
typedef void ( APIENTRY * GLGENFRAMEBUFFERSFN )( GLsizei n, GLuint* ids );
typedef void ( APIENTRY * GLBINDFRAMEBUFFERFN )( GLenum target, GLuint framebuffer );
typedef void ( APIENTRY * GLBLITFRAMEBUFFERFN )( GLint srcX0, GLint srcY0, GLint srcX1, GLint src Y1, GLint dstX0, GLint dstY0, GLint dstX1, GLint Y1, GLbitfield mask, GLenum filter );
typedef void (APIENTRY * GLFRAMEBUFFERTEXTUREFN )( GLenum target, GLenum attachment, GLuint texture, GLint level );
typedef void ( APIENTRY * GLFRAMEBUFFERTEXTURE2DFN )( GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level );
typedef void ( APIENTRY * GLDELETEFRAMEBUFFERSFN )( GLsizei n, GLuint* framebuffers );
typedef GLenum ( APIENTRY * GLCHECKFRAMEBUFFERSTATUSFN )( GLenum target );
typedef void ( APIENTRY * GLGENBUFFERSFN )( GLsizei n, GLuint* buffers );
typedef void ( APIENTRY * GLGENRENDERBUFFERSFN )( GLsizei n, GLuint* buffers );
typedef void ( APIENTRY * GLDELETEBUFFERSFN )( GLsizei n, const GLuint* buffers );
typedef void ( APIENTRY * GLDELETERENDERBUFFERSFN )( GLsizei n, const GLuint* buffers );
typedef void ( APIENTRY * GLBINDBUFFERFN )( GLenum target, GLuint buffer );
typedef void ( APIENTRY * GLBINDRENDERBUFFERFN )( GLenum target, GLuint buffer );
typedef void ( APIENTRY * GLBUFFERDATAFN )( GLenum target, GLsizeiptr size, const GLvoid* data, GLenum usage );
typedef void ( APIENTRY * GLGETBUFFERSUBDATAFN )( GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid* data );
typedef void ( APIENTRY * GLFRAMEBUFFERRENDERBUFFERFN )( GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer );
typedef GLint ( APIENTRY * GLGETATTRIBLOCATIONFN )( GLuint program, const GLchar* name );
typedef void ( APIENTRY * GLRENDERBUFFERSTORAGEFN )( GLenum target, GLenum format, GLsizei width, GLsizei height );
typedef void ( APIENTRY * GLRENDERBUFFERSTORAGEMULTISAMPLEFN )( GLenum target, GLuint samples, GLenum format, GLsizei width, GLsizei height );
typedef void ( APIENTRY * GLDRAWBUFFERSFN )( GLsizei n, const GLenum* buffers );
typedef void ( APIENTRY * GLGENERATEMIPMAPFN )( GLenum target );
typedef void ( APIENTRY * GLCOMPRESSEDTEXIMAGE2DFN )( GLenum target, GLint level, GLenum format, GLsizei width, GLsizei height, GLint border, GLsizei imagesize, const GLvoid* data );
typedef void ( APIENTRY * GLTEXIMAGE3DFN )( GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid* data);
typedef void ( APIENTRY * GLDRAWELEMENTSINSTANCEDFN )( GLenum mode, GLsizei count, GLenum type, const void* indicies, GLsizei primcount );
typedef void ( APIENTRY * GLPATCHPARAMETERIFN )( GLenum pname, GLint value );
typedef void ( APIENTRY * GLPATCHPARAMETERFVFN )( GLenum pname, const GLfloat* values );

typedef void ( APIENTRY * GLBROKENEXTENSIONFN )( );

#if !defined(__unix__) && !defined(__APPLE__)
    extern GLACTIVETEXTUREFN glActiveTexture;
    extern GLCOMPRESSEDTEXIMAGE2DFN glCompressedTexImage2D;
    extern GLTEXIMAGE3DFN glTexImage3D;
#endif
extern GLCREATESHADERFN glCreateShader;
extern GLCREATEPROGRAMFN glCreateProgram;
extern GLSHADERSOURCEFN glShaderSource;
extern GLCOMPILESHADERFN glCompileShader;
extern GLGETSHADERINFOLOGFN glGetShaderInfoLog;
extern GLATTACHSHADERFN glAttachShader;
extern GLLINKPROGRAMFN glLinkProgram;
extern GLGETPROGRAMINFOLOGFN glGetProgramInfoLog;
extern GLISPROGRAMFN glIsProgram;
extern GLISSHADERFN glIsShader;
extern GLGETATTACHEDSHADERSFN glGetAttachedShaders;
extern GLGETUNIFORMLOCATIONFN glGetUniformLocation;
extern GLUNIFORM1FFN glUniform1f;
extern GLUNIFORM1IFN glUniform1i;
extern GLDELETESHADERFN glDeleteShader;
extern GLDELETEPROGRAMFN glDeleteProgram;
extern GLUSEPROGRAMFN glUseProgram;
extern GLVERTEXATTRIBPOINTERFN glVertexAttribPointer;
extern GLVERTEXATTRIBDIVISORFN glVertexAttribDivisor;
extern GLENABLEVERTEXATTRIBARRAYFN glEnableVertexAttribArray;
extern GLDISABLEVERTEXATTRIBARRAYFN glDisableVertexAttribArray;
extern GLUNIFORM2FFN glUniform2f;
extern GLUNIFORM3FFN glUniform3f;
extern GLUNIFORM4FFN glUniform4f;
extern GLUNIFORMMATRIX3FVFN glUniformMatrix3fv;
extern GLUNIFORMMATRIX4FVFN glUniformMatrix4fv;
extern GLUNIFORM1FVFN glUniform1fv;
extern GLUNIFORM2FVFN glUniform2fv;
extern GLUNIFORM3FVFN glUniform3fv;//  incorrectly used "GLUNIFORM2FVFN" func in Corange
extern GLUNIFORM4FVFN glUniform4fv;//  incorrectly used "GLUNIFORM2FVFN" func in Corange
extern GLGETSHADERIVFN glGetShaderiv;
extern GLGETPROGRAMIVFN glGetProgramiv;
extern GLPROGRAMPARAMETERIFN glProgramParameteri;
extern GLBINDATTRIBLOCATIONFN glBindAttribLocation;
extern GLGENFRAMEBUFFERSFN glGenFramebuffers;
extern GLBINDFRAMEBUFFERFN glBindFramebuffer;
extern GLBLITFRAMEBUFFERFN glBlitFramebuffer;
extern GLFRAMEBUFFERTEXTUREFN glFramebufferTexture;
extern GLFRAMEBUFFERTEXTURE2DFN glFramebufferTexture2D;
extern GLDELETEFRAMEBUFFERSFN glDeleteFramebuffers;
extern GLCHECKFRAMEBUFFERSTATUSFN glCheckFramebufferStatus;
extern GLGENBUFFERSFN glGenBuffers;
extern GLGENRENDERBUFFERSFN glGenRenderbuffers;
extern GLDELETEBUFFERSFN glDeleteBuffers;
extern GLDELETERENDERBUFFERSFN glDeleteRenderbuffers;
extern GLBINDBUFFERFN glBindBuffer;
extern GLBINDRENDERBUFFERFN glBindRenderbuffer;
extern GLBUFFERDATAFN glBufferData;
extern GLGETBUFFERSUBDATAFN glGetBufferSubData;
extern GLFRAMEBUFFERRENDERBUFFERFN glFramebufferRenderbuffer;
extern GLGETATTRIBLOCATIONFN glGetAttribLocation;
extern GLRENDERBUFFERSTORAGEFN glRenderbufferStorage;
extern GLRENDERBUFFERSTORAGEMULTISAMPLEFN glRenderbufferStorageMultisample;
extern GLDRAWBUFFERSFN glDrawBuffers;
extern GLGENERATEMIPMAPFN glGenerateMipmap;
extern GLDRAWELEMENTSINSTANCEDFN glDrawElementsInstanced;
extern GLPATCHPARAMETERIFN glPatchParameteri;
extern GLPATCHPARAMETERFVFN glPatchParameterfv;

extern GLBROKENEXTENSIONFN glBrokenExtension;
N
