(*
###  randf.sats  ###

allows the creation of random floats
*)

staload "./../g_engine.sats"

fun randf () : float = "sta#%"
fun randf_seed ( s: float ) : float = "sta#%"

fun randf_n () : float = "sta#%"
fun randf_nseed ( s: float ) : float = "sta#%"

fun randf_scale ( s: float ) : float = "sta#%"

fun randf_nscale ( s: float ) : float = "sta#%"

fun randf_range ( s: float, e: float ) : float = "sta#%"

fun randf_circle ( radius: float ) : vec2 = "sta#%"
