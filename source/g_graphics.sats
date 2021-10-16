(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  g_graphics.sats  ###

a basic layer for the graphics system
*)

staload "./g_engine.sats"
staload "./SDL2/SDL_local.sats"

absvt@ype graphics_viewport

fn graphics_init () : Option_vt(graphics_viewport)
fn graphics_finish ( graphics_viewport ) : void

fn graphics_set_vsync ( vsync: bool ) : void
fn graphics_set_multisamples ( gvp: &graphics_viewport, samples: int ) : void
fn graphics_set_fullscreen ( gvp: &graphics_viewport, fullscreen: bool ) : void
fn graphics_set_antialiasing ( gvp: &graphics_viewport, quality: int ) : void

fn graphics_context_new ( !graphics_viewport ) : SDL_GLContext0
fn graphics_context_delete ( context: SDL_GLContext0 ) : void
fn graphics_context_current ( gvp: !graphics_viewport, context: !SDL_GLContext1 ) : void

fn graphics_get_multisamples ( gvp: !graphics_viewport ) : int
fn graphics_get_fullscreen ( gvp: !graphics_viewport ) : bool
fn graphics_get_antialiasing ( gvp: !graphics_viewport ) : int

fn graphics_viewport_set_title ( gvp: !graphics_viewport, title: string ) : void
fn graphics_viewport_set_icon ( gvp: !graphics_viewport, icon: fpath ) : void
fn graphics_viewport_set_position ( x: int, y: int ) : void
fn graphics_viewport_set_size ( gvp: !graphics_viewport, w: Nat, h: Nat ) : void
fn graphics_viewport_screenshot () : void

fn graphics_viewport_title ( !graphics_viewport ) : string
fn graphics_viewport_height ( !graphics_viewport ) : int
fn graphics_viewport_width ( !graphics_viewport ) : int
fn graphics_viewport_ratio ( !graphics_viewport ) : float

fn graphics_set_cursor_hidden ( hidden: bool ) : void
fn graphics_get_cursor_hidden () : bool

fn graphics_swap ( gvp: !graphics_viewport ) : void
