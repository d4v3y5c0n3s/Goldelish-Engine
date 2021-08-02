(*
###  texture.sats  ###

defines textures
*)

staload "./../g_engine.sats"
staload "./../assets/image.sats"

staload "./../SDL2/SDL_local.sats"

vtypedef texture = @{ handle=GLuint, type=GLuint }

fun texture_new () : (*texture*) ptr
fun texture_new_handle ( h: GLuint ) : (*texture*) ptr
fun texture_delete ( t: (*texture*) ptr ) : void

fun texture_handle ( t: (*texture*) ptr ) : GLuint
fun texture_type ( t: (*texture*) ptr ) : GLuint

fun texture_set_image ( t: (*texture*) ptr, i: (*image*) ptr ) : void
fun texture_get_image ( t: (*texture*) ptr ) : (*image*) ptr

fun texture_generate_mipmaps ( t: (*texture*) ptr ) : void
fun texture_set_filtering_nearest ( t: (*texture*) ptr ) : void
fun texture_set_filtering_linear ( t: (*texture*) ptr ) : void
fun texture_set_filtering_anisotropic ( t: (*texture*) ptr ) : void

fun bmp_load_file ( filename: string ) : (*texture*) ptr
fun tga_load_file ( filename: string ) : (*texture*) ptr
fun dds_load_file ( filename: string ) : (*texture*) ptr
fun lut_load_file ( filename: string ) : (*texture*) ptr
fun acv_load_file ( filename: string ) : (*texture*) ptr

fun texture_write_to_file ( t: (*texture*) ptr, filename: string ) : void
fun texture3d_write_to_file ( t: (*texture*) ptr, filename: string ) : void
