(*
###  particles.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./entities/particles.sats"

staload "./g_net.sats"

staload "./data/randf.sats"

staload "./assets/effect.sats"

////
implement particles_new (  ) =
{
}

implement particles_delete ( p ) =
{
}

implement particles_set_effect ( p, e ) =
{
}

implement add_vertex ( data, index, position, normal, tangent, binormal, uvs, color ) =
{
}

implement particles_update_effect ( p, timestep ) =
{
}

implement particles_update ( p, timestep, cam ) =
{
}