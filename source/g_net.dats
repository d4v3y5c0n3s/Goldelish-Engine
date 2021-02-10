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
    sock: !TCPsocket, data: Strptr1, maxlen: int
) : int = let
    var c = '\0'
    
    fn finalize_ret ( i: int ) : int =
        if i > 0 then let
            //data[i] = '\0';
        in
            i
        end else 0
    
    fun loop {} .<>. ( i: int, status: int ) : int = let
        val status = SDLNet_TCP_Recv(sock, c, 1)
    in
        if status = ~1 then ~1
        else if i = maxlen-1 then ~1
        else if status = 0 then finalize_ret(i)
        else
    end
in
    loop()
end

end////
implement net_http_get ( out, max, fmt ) =
(
)

implement net_http_upload ( filename, fmt ) =
(
)

end
