(*
###  texture.hats  ###

defines textures
*)

#include "g_engine.hats"
#include "assets/image.hats"

typedef texture = @{ handle=GLuint, type=GLuint }

fun texture_new () : texture ptr = "sta#%"
fun texture_new_handle ( h: GLuint ) : texture ptr = "sta#%"
fun texture_delete ( t: texture ptr ) : void = "sta#%"

fun texture_handle ( t: texture ptr ) : GLuint = "sta#%"
fun texture_type ( t: texture ptr ) : GLuint = "sta#%"

fun texture_set_image ( t: texture ptr, i: image ptr ) : void = "sta#%"
fun texture_get_image ( t: texture ptr ) : image ptr = "sta#%"

fun texture_generate_mipmaps ( t: texture ptr ) : void = "sta#%"
fun texture_set_filtering_nearest ( t: texture ptr ) : void = "sta#%"
fun texture_set_filtering_linear ( t: texture ptr ) : void = "sta#%"
fun texture_set_filtering_anisotropic ( t: texture ptr ) : void = "sta#%"

fun bmp_load_file ( filename: char ptr ) : texture ptr = "sta#%"
fun tga_load_file ( filename: char ptr ) : texture ptr = "sta#%"
fun dds_load_file ( filename: char ptr ) : texture ptr = "sta#%"
fun lut_load_file ( filename: char ptr ) : texture ptr = "sta#%"
fun acv_load_file ( filename: char ptr ) : texture ptr = "sta#%"

fun texture_write_to_file ( t: texture ptr, filename: char ptr ) : void = "sta#%"
fun texture3d_write_to_file ( t: texture ptr, filename: char ptr ) : void = "sta#%"
