(*
###  animation.sats  ###

defines an animation as an array of frames & times
*)

staload "./skeleton.sats"

typedef animation = @{ frame_count=int, frame_time=float, frames=(*frame ptr*) ptr }

fun animation_new () : (*animation*) ptr
fun animation_delete ( a: (*animation*) ptr ) : void
fun animation_duration ( a: (*animation*) ptr ) : float

fun animation_add_frame ( a: (*animation*) ptr, base: (*frame*) ptr ) : (*frame*) ptr
fun animation_frame ( a: (*animation*) ptr, i: int ) : (*frame*) ptr
fun animation_sample ( a: (*animation*) ptr, time: float ) : (*frame*) ptr
fun animation_sample_to ( a: (*animation*) ptr, time: float, out: (*frame*) ptr ) : void

fun ani_load_file ( filename: string ) : (*animation*) ptr
