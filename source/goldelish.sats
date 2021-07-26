(*
###  goldelish.sats  ###

This code is the main header file for the engine.
*)

staload "./g_entity.sats"
staload "./g_graphics.sats"
staload "./g_joystick.sats"

vtypedef goldelish_components = @{
  ENT=entity_table,
  GRPH=graphics_viewport,
  JOY=joysticks,
  FR=( @{ fstartt=ulint, facct=double, fcntr=int, frate=double } )
}

fn goldelish_init () : Option_vt(goldelish_components)
fn goldelish_finish ( goldelish_components ) : void
