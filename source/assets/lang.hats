(*
###  lang.hats  ###

defines languages for the game to use
*)

#include "data/dict.hats"
#include "gasset.hats"

typedef lang =  @{ map=dict ptr }

fun lang_load_file ( filename: char ptr ) : lang ptr = "sta#%"
fun lang_delete ( t: lang ptr ) : void = "sta#%"
fun lang_get ( t: lang ptr, id: char ptr ) : char ptr = "sta#%"

fun set_language ( t: asset_hndl ) : void = "sta#%"
fun S ( id: char ptr ) : char ptr = "sta#%"
