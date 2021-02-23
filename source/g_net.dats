(*
###  g_net.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_net.sats"
staload "./SDL2/SDL_local.sats"

local

assume net_running = @{
    is_server=bool,
    url_buffer=Strptr1,
    host_buffer=Strptr1,
    path_buffer=Strptr1
}

extern castfn c2cnz ( c: char ) : charNZ

in

implement net_init (  ) =
    if SDLNet_Init() < 0 then None_vt()
    else Some_vt( @{
        is_server=false,
        url_buffer=$UNSAFE.castvwtp0{Strptr1}(""),
        host_buffer=$UNSAFE.castvwtp0{Strptr1}(""),
        path_buffer=$UNSAFE.castvwtp0{Strptr1}("")
    }:net_running )

implement net_finish ( nr ) = {
    val () = strptr_free(nr.url_buffer)
    val () = strptr_free(nr.host_buffer)
    val () = strptr_free(nr.path_buffer)
    val () = SDLNet_Quit()
}

implement net_set_server ( nr, server ) = nr.is_server := server

implement net_is_server ( nr ) = nr.is_server

implement net_is_client ( nr ) = ~nr.is_server

// if status is ~1 or i == maxlen-1, return ~1 (either something failed or received too much data)
// if c == '\n', then we've reached the end of the line, return the resulting stream_vt
// if status is != 0 (continue the loop)
//otherwise,
//  if i is > 0, then terminate the string & return i
//  else, return 0 (no string to make)
fn SDLNet_TCP_RecvLine
(
    sock: !TCPsocket1, maxlen: int
) : Strptr1 = let

	fun loop ( sock: !TCPsocket1, i: int, s: stream_vt(charNZ) ) : stream_vt(charNZ) =
		let
			var c: charNZ = ' '
			val status = SDLNet_TCP_Recv(sock, c, 1)
		in
			if status = ~1 || i = maxlen-1 then let
				val () = stream_vt_free(s) in stream_vt_make_nil()
			end else if c = '\n' then s
			else if status != 0 then loop(sock, i+1, stream_vt_append(s, stream_vt_make_sing(c)))
			else s
		end
in
	string_make_stream_vt(loop(sock, 0, stream_vt_make_nil()))
end

end////
implement net_http_get ( out, max, fmt ) =
(
)

implement net_http_upload ( filename, fmt ) =
(
)

end
