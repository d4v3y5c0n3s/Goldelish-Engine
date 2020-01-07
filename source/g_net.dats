(*
###  g_net.dats  ###


*)

staload "g_net.sats"

var is_server = false

implement net_init (  ) =
(
)

implement net_finish (  ) =
(
)

implement net_set_server ( server ) =
(
)

implement net_is_server (  ) =
(
)

implement net_is_client (  ) =
(
)

implement SDLNet_TCP_RecvLine ( sock, data, maxlen ) =
(
)

var url_buffer: char//  [512]
var host_buffer: char//  [512]
var path_buffer: char//  [512]

implement net_http_get ( out, max, fmt ) =
(
)

implement net_http_upload ( filename, fmt ) =
(
)