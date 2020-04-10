(*
###  music.sats  ###

defines music files
*)

#include "./../g_engine.sats"

typedef Mix_Music = $extype"Mix_Music"
typedef music = @{
	handle=Mix_Music
}

fun mp3_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun ogg_load_file ( filename: string ) : (*music*) ptr = "sta#%"
fun music_delete ( m: (*music*) ptr ) : void = "sta#%"
