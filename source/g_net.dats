(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
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
        var sockout =
            string_make_stream_vt(
            stream_vt_append( streamize_string_char("GET "),
            stream_vt_append( streamize_string_char(host_buffer_str_copy),
            stream_vt_append( streamize_string_char(" HTTP/1.1\r\n"),
            stream_vt_append( streamize_string_char("Host: "),
            stream_vt_append( streamize_string_char(host_buffer_str_copy),
            streamize_string_char("\r\n\r\n"))))))
        )
        val sockout_len = ssize_to_int(strptr_length(sockout))
        val result = SDLNet_TCP_Send(sock, sockout, sockout_len)
        val () = strptr_free(sockout)
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
            sck: !TCPsocket1,
            header: bool
        ) : Strptr1 = let
            val (b, str) = SDLNet_TCP_RecvLine(sck, 1023)
        in
            if b && fail_cnt > 0 then let
                val s2 = string_make_stream_vt(
                stream_vt_append(
                    streamize_string_char(strptr2string(s)),
                    streamize_string_char(strptr2string(str))
                )
                )
            in
                if header then
                    if strptr2string(s2) = "\r\n" then loop($UNSAFE.castvwtp0{Strptr1}(""), fail_cnt-1, sck, false)
                    else loop($UNSAFE.castvwtp0{Strptr1}(""), fail_cnt-1, sck, header)
                else let
                in
                    loop(s2, fail_cnt-1, sck, header)
                end
            end else ( strptr_free(str); s )
        end
        val () = out := loop($UNSAFE.castvwtp0{Strptr1}(""), MAX_FAIL_CNT, sock, true)
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

implmnt net_http_upload ( nr, inpt, host_b, path_b ) = let
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
        var sockbody =
            string_make_stream_vt(
            stream_vt_append( streamize_string_char("--GoldelishUploadBoundary--\r\n"),
            stream_vt_append( streamize_string_char("content-disposition: form-data; name=\"goldelishupload\";"),
            stream_vt_append( streamize_string_char("Content-Type: text/plain\r\n"),
            stream_vt_append( streamize_string_char("\r\n"),
            stream_vt_append( streamize_string_char(strptr2string(strptr1_copy(inpt))),
            stream_vt_append( streamize_string_char("\r\n"),
            stream_vt_append( streamize_string_char("--GoldelishUploadBoundary--\r\n"),
            streamize_string_char("\r\n"))))))))
            )
        var sockheaders =
            string_make_stream_vt(
            stream_vt_append( streamize_string_char("POST "),
            stream_vt_append( streamize_string_char(strptr2string(strptr1_copy(nr.path_buffer))),
            stream_vt_append( streamize_string_char(" HTTP/1.1\r\n"),
            stream_vt_append( streamize_string_char("Host: "),
            stream_vt_append( streamize_string_char(strptr2string(strptr1_copy(nr.host_buffer))),
            stream_vt_append( streamize_string_char("\r\n"),
            stream_vt_append( streamize_string_char("Content-Length: "),
            stream_vt_append( streamize_string_char(strptr2string(g0int2string_int(ssize_to_int(strptr_length(inpt))))),
            stream_vt_append( streamize_string_char("\r\n"),
            stream_vt_append( streamize_string_char("Content-Type: multipart/form-data; boundary=CorangeUploadBoundary\r\n"),
            streamize_string_char("\r\n")))))))))))
            )
        fun loop (
            fail_cnt: int,
            sck: !TCPsocket1
        ) : void = let
            val (b, str) = SDLNet_TCP_RecvLine(sck, 1023)
            val () = strptr_free(str)
        in
            if b && fail_cnt > 0 then loop(fail_cnt-1, sck)
            else ()
        end
        val sockheaders_len = ssize_to_int(strptr_length(sockheaders))
        val sockbody_len = ssize_to_int(strptr_length(sockbody))
	in
        if SDLNet_TCP_Send(sock, sockheaders, sockheaders_len) < sockheaders_len then let
            prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
            val () = strptr_free(sockheaders)
            val () = strptr_free(sockbody)
        in
            HTTP_ERR_DATA()
        end
        else if SDLNet_TCP_Send(sock, sockbody, sockbody_len) < sockbody_len then let
            prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
            val () = strptr_free(sockheaders)
            val () = strptr_free(sockbody)
        in
            HTTP_ERR_DATA()
        end
        else let
            val () = loop(MAX_FAIL_CNT, sock)
            prval () = _consume_sock(sock) where { extern praxi _consume_sock {l:addr} ( TCPsocket_base(l) ) : void }
            val () = strptr_free(sockheaders)
            val () = strptr_free(sockbody)
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

end
