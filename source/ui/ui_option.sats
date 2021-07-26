(*
###  ui_option.sats  ###

same as button, but created in groups where only one may be selected
*)

staload "./../g_engine.sats"
staload "./ui_button.sats"

typedef ui_option = @{
	label=(*ui_button*) ptr, num_options=int, options=(*ui_button ptr*) ptr, active=bool, selected=int(*, onselect=ui_option ptr -> void(*function pointer*)*)
}

fun ui_option_new () : (*ui_option*) ptr = "sta#%"
fun ui_option_delete ( o: (*ui_option*) ptr ) : void = "sta#%"

fun ui_option_set_active ( o: (*ui_option*) ptr, active: bool ) : void = "sta#%"
fun ui_option_move ( o: (*ui_option*) ptr, position: vec2 ) : void = "sta#%"
fun ui_option_set_options ( o: (*ui_option*) ptr, label: string, num: int, values: string(*this is an array of strings*) ) : void = "sta#%"
fun ui_option_get_selected ( o: (*ui_option*) ptr ) : int = "sta#%"
fun ui_option_set_selected ( o: (*ui_option*) ptr, selected: int ) : void = "sta#%"
fun ui_option_set_onselect ( o: (*ui_option*) ptr(*, onselect: (*ui_option*) ptr -> void(*func pointer*)*) ) : void = "sta#%"

fun ui_option_deactivate ( o: (*ui_option*) ptr ) : void = "sta#%"
fun ui_option_activate ( o: (*ui_option*) ptr ) : void = "sta#%"

fun ui_option_event ( o: (*ui_option*) ptr, e: $extype"SDL_Event" ) : void = "sta#%"
fun ui_option_update ( o: (*ui_option*) ptr ) : void = "sta#%"
fun ui_option_render ( o: (*ui_option*) ptr ) : void = "sta#%"
