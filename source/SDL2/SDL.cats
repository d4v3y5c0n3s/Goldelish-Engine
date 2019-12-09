(*
###  SDL.cats  ###

the file that handles the direct interface from C to ATS
*)

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
typedef void ( APIENTRY * GL