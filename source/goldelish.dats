(*
###  goldelish.dats  ###
*)

#include "share/atspre_staload.hats"

staload "./goldelish.sats"
staload "./g_graphics.sats"
staload "./g_joystick.sats"
staload "./g_engine.sats"
staload "./g_entity.sats"

extern castfn int_to_ulint ( int ) : ulint

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
      FR=( @{ fstartt=int_to_ulint(0), facct=0.0, fcntr=0, frate=0.0 } )
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