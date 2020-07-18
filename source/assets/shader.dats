(*
###  shader.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/shader.sats"
staload "./assets/texture.sats"

////
implement load_shader_file ( filename, type ) =
(
)

implement vs_load_file ( filename ) =
(
)

implement fs_load_file ( filename ) =
(
)

implement gs_load_file ( filename ) =
(
)

implement tcs_load_file ( filename ) =
(
)

implement tes_load_file ( filename ) =
(
)

implement shader_program_new (  ) =
(
)

implement shader_program_handle ( p ) =
(
)

implement shader_handle ( s ) =
(
)

implement shader_program_attach_shader ( program, shader ) =
(
)

implement shader_program_link ( program ) =
(
)

implement shader_program_has_shader ( p, s ) =
(
)

implement shader_program_print_info ( p ) =
(
)

implement shader_program_pring_log ( program ) =
(
)

implement shader_print_log ( shader ) =
(
)

implement shader_program_delete ( program ) =
(
)

implement shader_delete ( shader ) =
(
)

implement shader_program_get_attribute ( p, name ) =
(
)

implement shader_program_enable ( p ) =
(
)

implement shader_program_disable ( p ) =
(
)

implement shader_program_set_int ( p, name, val ) =
(
)

implement shader_program_set_float ( p, name, val ) =
(
)

implement shader_program_set_vec2 ( p, name, val ) =
(
)

implement shader_program_set_vec3 ( p, name, val ) =
(
)

implement shader_program_set_vec4 ( p, name, val ) =
(
)

implement shader_program_set_mat3 ( p, name, val ) =
(
)

implement shader_program_set_mat4 ( p, name, val ) =
(
)

implement shader_program_set_texture ( p, name, index, t ) =
(
)

implement shader_program_set_texture_id ( p, name, index, t ) =
(
)

implement shader_program_set_float_array ( p, name, vals, count ) =
(
)

implement shader_program_set_vec2_array ( p, name, vals, count ) =
(
)

implement shader_program_set_vec3_array ( p, name, vals, count ) =
(
)

implement shader_program_set_vec4_array ( p, name, vals, count ) =
(
)

implement shader_program_set_mat4_array ( p, name, vals, count ) =
(
)

implement shader_program_enable_attribute ( p, name, count, stride, ptr ) =
(
)

implement shader_program_enable_attribute_instance ( p, name, count, stride, ptr ) =
(
)

implement shader_program_enable_attribute_instance_matrix ( p, name, ptr ) =
(
)

implement shader_program_disable_attribute ( p, name ) =
(
)

implement shader_program_disable_attribute_matrix ( p, name ) =
(
)