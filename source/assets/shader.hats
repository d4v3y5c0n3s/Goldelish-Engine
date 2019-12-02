(*
###

defines a GLSL shader program
*)

#include "g_engine.hats"
#include "g_asset.hats"

typedef shader = GLuint
typedef shader_print = GLuint

fun vs_load_file ( filename: char ptr ) : shader ptr = "sta#%"
fun fs_load_file ( filename: char ptr ) : shader ptr = "sta#%"
fun gs_load_file ( filename: char ptr ) : shader ptr = "sta#%"
fun tcs_load_file ( filename: char ptr ) : shader ptr = "sta#%"
fun tes_load_file ( filename: char ptr ) : shader ptr = "sta#%"

fun shader_delete ( s: shader ptr ) : void = "sta#%"
fun shader_print_log ( s: shader ptr ) : void = "sta#%"
fun shader_handle ( s: shader ptr ) : GLuint = "sta#%"

fun shader_program_new () : shader_program ptr = "sta#%"
fun shader_program_delete ( p: shader_program ptr ) : void = "sta#%"

fun shader_program_has_shader ( p: shader_program ptr, s: shader ptr ) : bool = "sta#%"
fun shader_program_attach_shader ( p: shader_program ptr, s: shader ptr ) : void = "sta#%"
fun shader_program_link ( p: shader_program ptr ) : void = "sta#%"

fun shader_program_print_info ( p: shader_program ptr ) : void = "sta#%"
fun shader_program_print_log ( p: shader_program ptr ) : void = "sta#%"

fun shader_program_handle ( p: shader_program ptr ) : GLuint = "sta#%"
fun shader_program_get_attribute ( p: shader_program ptr, name: char ptr ) : GLuint = "sta#%"

fun shader_program_enable ( p: shader_program ptr ) : void = "sta#%"
fun shader_program_disable ( p: shader_program ptr ) : void = "sta#%"

fun shader_program_set_int ( p: shader_program ptr, name: char ptr, val: int ) : void = "sta#%"
fun shader_program_set_float ( p: shader_program ptr, name: char ptr, val: float ) : void = "sta#%"
fun shader_program_set_vec2 ( p: shader_program ptr, name: char ptr, val: vec2 ) : void = "sta#%"
fun shader_program_set_vec3 ( p: shader_program ptr, name: char ptr, val: vec3 ) : void = "sta#%"
fun shader_program_set_vec4 ( p: shader_program ptr, name: char ptr, val: vec4 ) : void = "sta#%"
fun shader_program_set_mat3 ( p: shader_program ptr, name: char ptr, val: mat3 ) : void = "sta#%"
fun shader_program_set_mat4 ( p: shader_program ptr, name: char ptr, val: mat4 ) : void = "sta#%"
fun shader_program_set_float_array ( p: shader_program ptr, name: char ptr, vals: float ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec2_array ( p: shader_program ptr, name: char ptr, vals: vec2 ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec3_array ( p: shader_program ptr, name: char ptr, vals: vec3 ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec4_array ( p: shader_program ptr, name: char ptr, vals: vec4 ptr, count: int ) : void = "sta#%"
fun shader_program_set_mat4_array ( p: shader_program ptr, name: char ptr, vals: mat4 ptr, count: int ) : void = "sta#%"
fun shader_program_set_texture ( p: shader_program ptr, name: char ptr, index: int, t: asset_hndl ) : void = "sta#%"
fun shader_program_set_texture_id ( p: shader_program ptr, name: char ptr, index: int, t: asset_hndl ) : void = "sta#%"

fun shader_program_enable_attribute ( p: shader_program ptr, name: char ptr, count: int, stride: int, pntr: ptr ) : void = "sta#%"
fun shader_program_enable_attribute_instance ( p: shader_program ptr, name: char ptr, count: int, stride: int, pntr: ptr ) : void = "sta#%"
fun shader_program_disable_attribute ( p: shader_program ptr, name: char ptr ) : void = "sta#%"

fun shader_program_enable_attribute_instance_matrix ( p: shader_program ptr, name: char ptr, pntr: ptr ) : void = "sta#%"
fun shader_program_disable_attribute_matrix ( p: shader_program ptr, name: char ptr ) : void = "sta#%"
