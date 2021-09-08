(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  sky.sats  ###

allows the creation of a dynamic sky
*)

staload "./../g_engine.sats"
staload "./../g_asset.sats"
staload "./../assets/image.sats"
staload "./../assets/texture.sats"
staload "./../assets/renderable.sats"

(*
these need to be defined in the .dats file

val TIME_SUNRISE = 0.00
and TIME_MORNING = 0.10
and TIME_MIDAY = 0.25
and TIME_EVENING = 0.40
and TIME_SUNSET = 0.50
and TIME_MIDNIGHT = 0.75
*)

vtypedef sky = @{
	time=float,
        seed=usint,
	cloud_mesh=asset_hndl(renderable),//(*[14]*)// had to have the "//" otherwise this would fail to compile (potentially a bug, should probably mention it to the ATS community)
        cloud_tex=asset_hndl(texture),//(*[14]*)
        cloud_opacity=float,//(*[14]*)
	sun_sprite=asset_hndl(image),
        sun_tex=asset_hndl(texture),
	moon_sprite=asset_hndl(image),
        moon_tex=asset_hndl(texture),
	stars_sprite=asset_hndl(image),
        stars_tex=asset_hndl(texture),
	is_day=bool,
        wind=vec3,
	world_sun=mat4,
        world_moon=mat4,
        world_stars=mat4,
	moon_power=float,
        moon_direction=vec3,
        moon_diffuse=vec3,
        moon_ambient=vec3,
        moon_specular=vec3,
	sun_power=float,
        sun_direction=vec3,
        sun_diffuse=vec3,
        sun_ambient=vec3,
        sun_specular=vec3,
	sky_power=float,
        sky_direction=vec3,
        sky_diffuse=vec3,
        sky_ambient=vec3,
        sky_specular=vec3,
	ground_power=float,
        ground_direction=vec3,
        ground_diffuse=vec3,
        ground_ambient=vec3,
        ground_specular=vec3
}

fun sky_new () : (*sky*) ptr
fun sky_delete ( s: (*sky*) ptr ) : void
fun sky_update ( s: (*sky*) ptr, t: float, seed: usint ) : void
