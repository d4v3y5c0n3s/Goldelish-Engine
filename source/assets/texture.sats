(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  texture.sats  ###

defines textures
*)

staload "./../g_engine.sats"
staload "./../assets/image.sats"

staload "./../SDL2/SDL_local.sats"

vtypedef texture = [t:int] @{ handle=GL_Texture, type=GLenum(t) }

fn texture_new () : (*texture*) ptr
fn texture_new_handle ( h: GL_Texture ) : (*texture*) ptr
fn texture_delete ( t: (*texture*) ptr ) : void

fn texture_handle ( t: (*texture*) ptr ) : GL_Texture
fn texture_type ( t: (*texture*) ptr ) : [t:int] GLenum(t)

fn texture_set_image ( t: (*texture*) ptr, i: (*image*) ptr ) : void
fn texture_get_image ( t: (*texture*) ptr ) : (*image*) ptr

fn texture_generate_mipmaps ( t: (*texture*) ptr ) : void
fn texture_set_filtering_nearest ( t: (*texture*) ptr ) : void
fn texture_set_filtering_linear ( t: (*texture*) ptr ) : void
fn texture_set_filtering_anisotropic ( t: (*texture*) ptr ) : void

fn bmp_load_file ( filename: string ) : (*texture*) ptr
fn tga_load_file ( filename: string ) : (*texture*) ptr
fn dds_load_file ( filename: string ) : (*texture*) ptr
fn lut_load_file ( filename: string ) : (*texture*) ptr
fn acv_load_file ( filename: string ) : (*texture*) ptr

fn texture_write_to_file ( t: (*texture*) ptr, filename: string ) : void
fn texture3d_write_to_file ( t: (*texture*) ptr, filename: string ) : void
