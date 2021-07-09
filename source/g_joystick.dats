(*
###  g_joystick.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_joystick.sats"
staload "./SDL2/SDL_local.sats"

#define MAX_STICKS 8

local

assume joysticks = arrayptr(SDL_Joystick_ptr0, MAX_STICKS)

extern castfn size2int ( size_t ) : int

in

implmnt joystick_init () = let
  val error = SDL_InitSubSystem(SDL_INIT_JOYSTICK)
in
  if error = ~1 then None_vt()
  else let
    val num_sticks = SDL_NumJoysticks()
    val joy_arr = arrayptr_make_uninitized<SDL_Joystick_ptr0>(size_of_int(MAX_STICKS))
    implmnt array_initize$init<SDL_Joystick_ptr0> (i, x) = x := SDL_JoystickOpen(size2int(i))
    val () = arrayptr_initize<SDL_Joystick_ptr0>(joy_arr, size_of_int(MAX_STICKS))
  in
    Some_vt( (joy_arr):joysticks )
  end
end

implmnt joystick_finish ( jstks ) = let
  implmnt array_uninitize$clear<SDL_Joystick_ptr0>(i, x) = SDL_JoystickClose(x)
in
  arrayptr_freelin(jstks, size_of_int(MAX_STICKS))
end

implmnt joystick_count ( jstks ) = SDL_NumJoysticks()

implmnt joystick_get ( jstks, i ) =
    if i >= MAX_STICKS then None_vt()
    else let
        val p = $UNSAFE.ptr0_get_at_int<SDL_Joystick_ptr0>(ptrcast(jstks), i)
    in
        if ptrcast(p) > 0 then Some_vt(p)
        else let
            prval () = _consume_null(p) where {
                extern praxi _consume_null ( SDL_Joystick_ptr0 ) : void
            }
        in
            None_vt()
        end
    end

end
