(*
###  g_audio.dats  ###


*)

staload "g_audio.sats"

val audio_rate: int = 22050
val audio_format: Uint16 = AUDIO_S16
val audio_channels: int = 2
val audio_buffers: int = 4096
var volume: float = 1.0

implement audio_init () =
(
)

implement audio_finish () =
(
)

implement audio_sound_play ( s, loops ) =
(
)

implement audio_sound_pause ( channel ) =
(
)

implement audio_sound_resume ( channel ) =
(
)

implement audio_sound_stop ( channel ) =
(
)

val fade_time: int = 5000

implement audio_music_play ( m ) =
(
)

implement audio_music_pause () =
(
)

implement audio_music_resume () =
(
)

implement audio_music_stop () =
(
)

implement audio_set_volume ( volume ) =
(
)

implement audio_music_get_volume () =
(
)