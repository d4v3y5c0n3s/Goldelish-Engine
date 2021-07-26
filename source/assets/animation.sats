(*
###  animation.sats  ###

defines an animation as an array of frames & times
*)

staload "./skeleton.sats"

typedef animation = @{ frame_count=int, frame_time=float, frames=(*frame ptr*) ptr }

fun animation_new () : (*animation*) ptr = "sta#%"
fun animation_delete ( a: (*animation*) ptr ) : void = "sta#%"
fun animation_duration ( a: (*animation*) ptr ) : float = "sta#%"

fun animation_add_frame ( a: (*animation*) ptr, base: (*frame*) ptr ) : (*frame*) ptr = "sta#%"
fun animation_frame ( a: (*animation*) ptr, i: int ) : (*frame*) ptr = "sta#%"
fun animation_sample ( a: (*animation*) ptr, time: float ) : (*frame*) ptr = "sta#%"
fun animation_sample_to ( a: (*animation*) ptr, time: float, out: (*frame*) ptr ) : void = "sta#%"

fun ani_load_file ( filename: string ) : (*animation*) ptr = "sta#%"
