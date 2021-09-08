(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  texture.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./assets/texture.sats"

staload "./data/spline.sats"

////
implement texture_new (  ) =
(
)

implement texture_delete ( t ) =
(
)

implement texture_handle ( t ) =
(
)

implement texture_type ( t ) =
(
)

implement texture_set_image ( t, i ) =
(
)

implement tga_load_file ( filename ) =
(
)

implement bmp_load_file ( filename ) =
(
)

implement texture_get_image ( t ) =
(
)

implement texture_generate_mipmaps ( t ) =
(
)

implement texture_set_filtering_nearest ( t ) =
(
)

implement texture_set_filtering_linear ( t ) =
(
)

implement texture_set_filtering_anisotropic ( t ) =
(
)

implement texture_write_to_file ( t, filename ) =
(
)

implement lut_load_file ( filename ) =
(
)

implement texture3d_write_to_file ( t, filename ) =
(
)

//  DDS file stuff

//  little-endian, of course
#define DDS_MAGIC 0x20534444

//  DDS_header.dwFlags
#define DDSD_CAPS 0x00000001
#define DDSD_HEIGHT 0x00000002
#define DDSD_WIDTH 0x00000004
#define DDSD_PITCH 0x00000008
#define DDSD_PIXELFORMAT 0x00001000
#define DDSD_MIPMAPCOUNT 0x00020000
#define DDSD_LINEARSIZE 0x00080000
#define DDSD_DEPTH 0x00800000

//  DDS_header.sPixelFormat.dwFlags
#define DDPF_ALPHAPIXELS 0x00000001
#define DDPF_FOURCC 0x00000004
#define DDPF_INDEXED 0x00000020
#define DDPF_RGB 0x00000040

//  DDS_header.sCaps.dwCaps1
#define DDSCAPS_COMPLEX 0x00000008
#define DDSCAPS_TEXTURE 0x00001000
#define DDSCAPS_MIPMAP 0x00400000

//  DDS_header.sCaps.dwCaps2
#define DDSCAPS2_CUBEMAP 0x00000200
#define DDSCAPS2_CUBEMAP_POSITIVEX 0x00000400
#define DDSCAPS2_CUBEMAP_NEGATIVEX 0x00000800
#define DDSCAPS2_CUBEMAP_POSITIVEY 0x00001000
#define DDSCAPS2_CUBEMAP_NEGATIVEY 0x00002000
#define DDSCAPS2_CUBEMAP_POSITIVEZ 0x00004000
#define DDSCAPS2_CUBEMAP_NEGATIVEZ 0x00008000
#define DDSCAPS2_VOLUME 0x00200000

#define D3DFMT_DXT1 0x31545844//  DXT1 compression texture format
#define D3DFMT_DXT2 0x32545844//  DXT2 compression texture format
#define D3DFMT_DXT3 0x33545844//  DXT3 compression texture format
#define D3DFMT_DXT4 0x34545844//  DXT4 compression texture format
#define D3DFMT_DXT5 0x35545844//  DXT5 compression texture format

fun{pf:t@ype} PF_IS_DXT1 ()

fun{pf:t@ype} PF_IS_DXT3 ()

fun{pf:t@ype} PF_IS_DXT5 ()

fun{pf:t@ype} PF_IS_BGRA8 ()

fun{pf:t@ype} PF_IS_BGR8 ()

fun{pf:t@ype} PF_IS_BGR5A1 ()

fun{pf:t@ype} PF_IS_BGR565 ()

fun{pf:t@ype} PF_IS_INDEX8 ()

typedef DDS_header = '{
	dwMagic=uint, dwSize=uint, dwFlags=uint, dwHeight=uint, dwWidth=uint, dwPitchOrLinearSize=uint, dwDepth=uint, dwMipMapCount=uint, dwReserved1=uint,(*[11]*)

	(*  DDPIXELFORMAT  *)
	sPixelFormat='{
	dwSize=uint, dwFlags=uint, dwFourCC=uint, dwRGBBitCount=uint, dwRBitMask=uint, dwGBitMask=uint, dwBBitMask=uint, dwAlphaBitMask=uint
	},

	(*  DDCAPS2  *)
	sCaps='{
	dwCaps1=uint, dwCaps2=uint, dwDDSX=uint, dwReserved=uint
	},

	dwReserved2=uint
}

typedef DdsLoadInfo = '{
	compressed=bool, swap=bool, palette=bool, div_size=int, block_bytes=int, internal_format=GLenum, external_format=GLenum, type=GLenum
}

implement is_power_of_two ( x ) =
{
}

implement dds_load_file ( filename ) =
{
}

implement acv_load_file ( filename ) =
{
}
