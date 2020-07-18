(*
###  light.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./entities/light.sats"

#define DEFAULT_LIGHT_NEAR_CLIP 0.1
#define DEFAULT_LIGHT_FAR_CLIP 8192.0
#define DEFAULT_FOV 0.785398163

////
implement light_new (  ) =
{
}

implement light_new_position ( position ) =
{
}

implement light_new_type ( position, type ) =
{
}

implement light_set_type ( l, type ) =
{
}

implement light_delete ( l ) =
{
}

implement light_direction ( l ) =
{
}

implement light_view_matrix ( l ) =
{
}

implement light_proj_matrix ( l ) =
{
}