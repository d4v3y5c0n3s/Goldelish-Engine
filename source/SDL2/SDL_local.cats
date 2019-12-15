//(*
//###  SDL_local.cats  ###
//
//  defines the SDL functions for later use by "SDL_local.sats" in addition to the extension constants
//*)

//  SDL functions
#define goldelish_SDL_PrintStackTrace SDL_PrintStackTrace

#define goldelish_SDL_PathFullName SDL_PathFullName
#define goldelish_SDL_PathFileName SDL_PathFileName
#define goldelish_SDL_PathFileExtension SDL_PathFileExtension
#define goldelish_SDL_PathFileLocation SDL_PathFileLocation
#define goldelish_SDL_PathRelative SDL_PathRelative
#define goldelish_SDL_PathForwardSlashes SDL_PathForwardSlashes
#define goldelish_SDL_PathJoin SDL_PathJoin
#define goldelish_SDL_PathIsFile SDL_PathIsFile
#define goldelish_SDL_PathIsDirectory SDL_PathIsDirectory
#define goldelish_SDL_PathParentDirectory SDL_PathParentDirectory

#define goldelish_SDL_GetWorkingDir SDL_GetWorkingDir
#define goldelish_SDL_SetWorkingDir SDL_SetWorkingDir

#define goldelish_SDL_GL_FrameBufferErrorString SDL_GL_FrameBufferErrorString
#define goldelish_SDL_GL_ErrorString SDL_GL_ErrorString

#define goldelish_SDL_GL_PrintInfo SDL_GL_PrintInfo
#define goldelish_SDL_GL_PrintExtensions SDL_GL_PrintExtensions
#define goldelish_SDL_GL_LoadExtensions SDL_GL_LoadExtensions
#define goldelish_SDL_GL_ExtensionPresent SDL_GL_ExtensionPresent
#define goldelish_SDL_GL_ExtensionFunctionLoaded SDL_GL_ExtensionFunctionLoaded

//  extension constants
#define GL_TABLE_TOO_LARGE 0x8031
#define GL_INVALID_FRAMEBUFFER_OPERATION 0x0506

#define GL_SHADING_LANGUAGE_VERSION 0x8B8C

#define GL_VERTEX_SHADER 0x8B31
#define GL_FRAGMENT_SHADER 0x8B30
#define GL_GEOMETRY_SHADER 0x8DD9
#define GL_COMPILE_STATUS 0x8B81
#define GL_LINK_STATUS 0x8B82

#undef GL_GEOMETRY_VERTICES_OUT
#undef GL_GEOMETRY_INPUT_TYPE
#undef GL_GEOMETRY_OUTPUT_TYPE
#define GL_GEOMETRY_VERTICES_OUT 0x8DDA
#define GL_GEOMETRY_INPUT_TYPE 0x8DDB
#define GL_GEOMETRY_OUTPUT_TYPE 0x8DDC
#define GL_MAX_GEOMETRY_OUTPUT_VERTICES 0x8DE0
#define GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS 0x8DE1

#define GL_FRAMEBUFFER 0x8D40
#define GL_RENDERBUFFER 0x8D41
#define GL_READ_FRAMEBUFFER 0x8CA8
#define GL_DRAW_FRAMEBUFFER 0x8CA9
#define GL_ARRAY_BUFFER 0x8892
#define GL_ELEMENT_ARRAY_BUFFER 0x8893

#define GL_FRAMEBUFFER_COMPLETE 0x8CD5
#define GL_FRAMEBUFFER_UNDEFINED 0x8219
#define GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT 0x8CD6
#define GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT 0x8CD7
#define GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER 0x8CDB
#define GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER 0x8CDC
#define GL_FRAMEBUFFER_UNSUPPORTED 0x8CDD
#define GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE 0x8D56
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS 0x8DA8

#define GL_STATIC_DRAW 0x88E4
#define GL_DYNAMIC_COPY 0x88EA

#define GL_MAX_COLOR_ATTACHMENTS 0x8CDF
#define GL_COLOR_ATTACHMENT0 0x8CE0
#define GL_COLOR_ATTACHMENT1 0x8CE1
#define GL_COLOR_ATTACHMENT2 0x8CE2
#define GL_COLOR_ATTACHMENT3 0x8CE3
#define GL_COLOR_ATTACHMENT4 0x8CE4
#define GL_COLOR_ATTACHMENT5 0x8CE5
#define GL_COLOR_ATTACHMENT6 0x8CE6
#define GL_COLOR_ATTACHMENT7 0x8CE7
#define GL_COLOR_ATTACHMENT8 0x8CE8
#define GL_COLOR_ATTACHMENT9 0x8CE9
#define GL_COLOR_ATTACHMENT10 0x8CEA
#define GL_COLOR_ATTACHMENT11 0x8CEB
#define GL_COLOR_ATTACHMENT12 0x8CEC
#define GL_COLOR_ATTACHMENT13 0x8CED
#define GL_COLOR_ATTACHMENT14 0x8CEE
#define GL_COLOR_ATTACHMENT15 0x8CEF
#define GL_DEPTH_ATTACHMENT 0x8D00
#define GL_STENCIL_ATTACHMENT 0x8D20

#define GL_RGBA32F 0x8814
#define GL_RGBA16F 0x881A
#define GL_BGRA 0x80E1
#define GL_BGR 0x80E0
#define GL_COMPRESSED_RGBA_S3TC_DXT1 0x83F1
#define GL_COMPRESSED_RGBA_S3TC_DXT3 0x83F2
#define GL_COMPRESSED_RGBA_S3TC_DXT5 0x83F3

#define GL_UNSIGNED_SHORT_1_5_5_5_REV 0x8366
#define GL_UNSIGNED_SHORT_5_6_5 0x8363
#define GL_DEPTH_COMPONENT24 0x81A6

#define GL_CLAMP_TO_EDGE 0x812F
#define GL_TEXTURE_WRAP_R 0x8072
#define GL_MIRRORED_REPEAT 0x8370
#define GL_TEXTURE_DEPTH 0x8071
#define GL_TEXTURE_MAX_ANISOTROPY 0x84FE
#define GL_MAX_TEXTURE_MAX_ANISOTROPY 0x84FF
#define GL_GENERATE_MIPMAP 0x8191
#define GL_TEXTURE_MAX_LEVEL 0x813D

#define GL_TEXTURE0 0x84C0
#define GL_TEXTURE_3D 0x806F
#define GL_TEXTURE_CUBE_MAP_SEAMLESS 0x884F

#define GL_MULTISAMPLE 0x809D

#define GL_TESS_CONTROL_SHADER 0x8E88
#define GL_TESS_EVALUATION_SHADER 0x8E87
#define GL_PATCH_VERTICES 0x8E72
