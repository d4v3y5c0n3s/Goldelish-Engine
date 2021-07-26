(*
###  music.sats  ###

defines music files
*)

staload "./../g_engine.sats"
staload "./../SDL2/SDL_local.sats"

typedef music = @{
	handle=Mix_Music
}

fun mp3_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun ogg_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun music_delete ( m: (*music*) ptr ) : void = "sta#%"
