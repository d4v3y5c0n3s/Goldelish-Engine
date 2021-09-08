(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
###  goldelish.dats  ###
*)

#include "share/atspre_staload.hats"

staload "./goldelish.sats"
staload "./g_graphics.sats"
staload "./g_joystick.sats"
staload "./g_engine.sats"
staload "./g_entity.sats"

implement goldelish_init () = let
  var graphics = graphics_init()
in
  case+ graphics of
  | ~Some_vt(g) => let
    var joysticks = joystick_init()
  in
    case+ joysticks of
    | ~Some_vt(j) => Some_vt(@{
      ENT=entity_table_init(),
      GRPH=g,
      JOY=j,
      FR=( @{ fstartt=0ul, facct=0.0, fcntr=0, frate=0.0 } )
    }:goldelish_components)
    | ~None_vt() => begin graphics_finish(g); None_vt() end
  end
  | ~None_vt() => None_vt()
end

implement goldelish_finish ( g_c ) = begin
  entity_table_finish(g_c.ENT);
  graphics_finish(g_c.GRPH);
  joystick_finish(g_c.JOY)
end
