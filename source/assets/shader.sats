(*
###  shader.sats  ###

defines a GLSL shader program
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"

vtypedef shader = $extype"GLuint"
vtypedef shader_print = $extype"GLuint"

fun vs_load_file ( filename: string ) : (*shader*) ptr = "sta#%"
fun fs_load_file ( filename: string ) : (*shader*) ptr = "sta#%"
fun gs_load_file ( filename: string ) : (*shader*) ptr = "sta#%"
fun tcs_load_file ( filename: string ) : (*shader*) ptr = "sta#%"
fun tes_load_file ( filename: string ) : (*shader*) ptr = "sta#%"

fun shader_delete ( s: (*shader*) ptr ) : void = "sta#%"
fun shader_print_log ( s: (*shader*) ptr ) : void = "sta#%"
fun shader_handle ( s: (*shader*) ptr ) : $extype"GLuint" = "sta#%"

fun shader_program_new () : (*shader_program*) ptr = "sta#%"
fun shader_program_delete ( p: (*shader_program*) ptr ) : void = "sta#%"

fun shader_program_has_shader ( p: (*shader_program*) ptr, s: (*shader*) ptr ) : bool = "sta#%"
fun shader_program_attach_shader ( p: (*shader_program*) ptr, s: (*shader*) ptr ) : void = "sta#%"
fun shader_program_link ( p: (*shader_program*) ptr ) : void = "sta#%"

fun shader_program_print_info ( p: (*shader_program*) ptr ) : void = "sta#%"
fun shader_program_print_log ( p: (*shader_program*) ptr ) : void = "sta#%"

fun shader_program_handle ( p: (*shader_program*) ptr ) : $extype"GLuint" = "sta#%"
fun shader_program_get_attribute ( p: (*shader_program*) ptr, name: string ) : $extype"GLuint" = "sta#%"

fun shader_program_enable ( p: (*shader_program*) ptr ) : void = "sta#%"
fun shader_program_disable ( p: (*shader_program*) ptr ) : void = "sta#%"

fun shader_program_set_int ( p: (*shader_program*) ptr, name: string, value: int ) : void = "sta#%"
fun shader_program_set_float ( p: (*shader_program*) ptr, name: string, value: float ) : void = "sta#%"
fun shader_program_set_vec2 ( p: (*shader_program*) ptr, name: string, value: vec2 ) : void = "sta#%"
fun shader_program_set_vec3 ( p: (*shader_program*) ptr, name: string, value: vec3 ) : void = "sta#%"
fun shader_program_set_vec4 ( p: (*shader_program*) ptr, name: string, value: vec4 ) : void = "sta#%"
fun shader_program_set_mat3 ( p: (*shader_program*) ptr, name: string, value: mat3 ) : void = "sta#%"
fun shader_program_set_mat4 ( p: (*shader_program*) ptr, name: string, value: mat4 ) : void = "sta#%"
fun shader_program_set_float_array ( p: (*shader_program*) ptr, name: string, values: (*float*) ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec2_array ( p: (*shader_program*) ptr, name: string, values: (*vec2*) ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec3_array ( p: (*shader_program*) ptr, name: string, values: (*vec3*) ptr, count: int ) : void = "sta#%"
fun shader_program_set_vec4_array ( p: (*shader_program*) ptr, name: string, values: (*vec4*) ptr, count: int ) : void = "sta#%"
fun shader_program_set_mat4_array ( p: (*shader_program*) ptr, name: string, values: (*mat4*) ptr, count: int ) : void = "sta#%"
fun shader_program_set_texture ( p: (*shader_program*) ptr, name: string, index: int, t: asset_hndl ) : void = "sta#%"
fun shader_program_set_texture_id ( p: (*shader_program*) ptr, name: string, index: int, t: asset_hndl ) : void = "sta#%"

fun shader_program_enable_attribute ( p: (*shader_program*) ptr, name: string, count: int, stride: int, pntr: ptr ) : void = "sta#%"
fun shader_program_enable_attribute_instance ( p: (*shader_program*) ptr, name: string, count: int, stride: int, pntr: ptr ) : void = "sta#%"
fun shader_program_disable_attribute ( p: (*shader_program*) ptr, name: string ) : void = "sta#%"

fun shader_program_enable_attribute_instance_matrix ( p: (*shader_program*) ptr, name: string, pntr: ptr ) : void = "sta#%"
fun shader_program_disable_attribute_matrix ( p: (*shader_program*) ptr, name: string ) : void = "sta#%"
