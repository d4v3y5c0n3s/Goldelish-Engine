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
extern castfn int_to_uint16 ( int ) : uint16
extern castfn ssize_to_int ( ssize_t ) : int

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

fn SDLNet_TCP_RecvLine
(
    sock: !TCPsocket1, maxlen: int
) : (bool, Strptr1) = let

	fun loop ( sock: !TCPsocket1, i: int, s: stream_vt(charNZ) ) : (bool, stream_vt(charNZ)) =
		let
			var c: charNZ = ' '
			val status = SDLNet_TCP_Recv(sock, c, 1)
		in
			if status = ~1 || i = maxlen-1 then let
				val () = stream_vt_free(s) in (true, stream_vt_make_nil())
			end else if c = '\n' then (true, s)
			else if status != 0 then loop(sock, i+1, stream_vt_append(s, stream_vt_make_sing(c)))
			else (false, s)
		end
    
    val (b, strm) = loop(sock, 0, stream_vt_make_nil())
in
    (b, string_make_stream_vt(strm))
end

#define MAX_FAIL_CNT 100

implmnt net_http_get ( nr, out, max, host_b, path_b ) = let
    val () = strptr_free(nr.host_buffer)
    val () = strptr_free(nr.path_buffer)
    val () = nr.host_buffer := host_b
    val () = nr.path_buffer := path_b
	var ip: IPaddress
	val reshost = SDLNet_ResolveHost(ip, strptr2string(strptr1_copy(nr.host_buffer)), int_to_uint16(80))
in
	if reshost = ~1 then ( println!(SDLNet_GetError()); HTTP_ERR_HOST() )
	else let
        val sock = SDLNet_TCP_Open(ip)
	in
	if ptrcast(sock) > 0 then let
        val host_buffer_str_copy = strptr2string(strptr1_copy(nr.host_buffer))
        var sockout: Strptr1 = $UNSAFE.castvwtp0{Strptr1}(
            string_make_stream_vt(
            stream_vt_append( streamize_string_char("GET "),
            stream_vt_append( streamize_string_char(host_buffer_str_copy),
            stream_vt_append( streamize_string_char(" HTTP/1.1\r\n"),
            stream_vt_append( streamize_string_char("Host: "),
            stream_vt_append( streamize_string_char(host_buffer_str_copy),
            streamize_string_char("\r\n\r\n")
            )
            )
            )
            )
            )
            )
        )
        val sockout_len = ssize_to_int(strptr_length(sockout))
        val result = SDLNet_TCP_Send(sock, sockout, sockout_len)
	in
	if result < sockout_len then let
        prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
	in
        println!(SDLNet_GetError()); HTTP_ERR_DATA()
    end
	else let
        val () = strptr_free(out)
        fun loop (
            s: Strptr1,
            fail_cnt: int,
            sck: !TCPsocket1
        ) : Strptr1 = let
            val (b, str) = SDLNet_TCP_RecvLine(sck, 1023)
            val s2 = string_make_stream_vt(
            stream_vt_append(
                streamize_string_char(strptr2string(s)),
                streamize_string_char(strptr2string(str))
            )
            )
        in
            if b && fail_cnt > 0 then loop(s2, fail_cnt-1, sck)
            else s2
        end
        val () = out := loop($UNSAFE.castvwtp0{Strptr1}(""), MAX_FAIL_CNT, sock)
        prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
	in
        HTTP_ERR_NONE()
	end
	end else let
        prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
	in
        println!(SDLNet_GetError()); HTTP_ERR_SOCKET()
	end
	end
end
end////
implmnt net_http_upload ( nr, filename, host_b, path_b ) = let
    val () = strptr_free(nr.host_buffer)
    val () = strptr_free(nr.path_buffer)
    val () = nr.host_buffer := host_b
    val () = nr.path_buffer := path_b
	var ip: IPaddress
	val reshost = SDLNet_ResolveHost(ip, strptr2string(strptr1_copy(nr.host_buffer)), int_to_uint16(80))
in
    if reshost = ~1 then ( println!(SDLNet_GetError()); HTTP_ERR_HOST() )
	else let
        val sock = SDLNet_TCP_Open(ip)
	in
	if ptrcast(sock) > 0 then let
        var file = SDL_RWFromFile(filename, "r")
	in
	if ptrcast(file) > 0 then let
        // ###
	in
	end
	else let
        prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
	in
        HTTP_ERR_NOFILE()
	end
	end
	else let
        prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
	in
        println!(SDLNet_GetError()); HTTP_ERR_SOCKET()
	end
	end
end
(*
	// using SDL_RWseek() to get file size, create string sized to store file,
	//use SDL_RWread() to read file to string, use SDL_RWclose() to close file

	// alloc strings sockbody & sockheaders
	// snprintf() strint data to sockbody & sockheaders

	// create int result = 0

	// result = SDLNet_TCP_Send() for sockheaders
	// if result < strlen(sockheaders), HTTP_ERR_DATA()

	// result = SDLNet_TCP_Send() for sockbody
	// if result < strlen(sockbody), HTTP_ERR_DATA()

	// alloc string line
	// call SDLNet_TCP_RecvLine() to set line until -1 returned

	// HTTP_ERR_NONE()
*)

end
