(*
###  g_joystick.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_joystick.sats"
staload "./SDL2/SDL_local.sats"

#define MAX_STICKS 8

local

assume joysticks = [l:addr] arrayptr(SDL_Joystick_ptr0, l, MAX_STICKS)

in

implmnt joystick_init () = let
    val error = SDL_InitSubSystem(SDL_INIT_JOYSTICK)
in
    if error = ~1 then None_vt()
    else let
        val num_sticks = SDL_NumJoysticks()
        val [j:addr] joy_arr = arrayptr_make_uninitized<SDL_Joystick_ptr0>(size_of_int(MAX_STICKS))
        
        fun init_arr {i:int | i >= 0 && i <= MAX_STICKS} ( p: ptr, i: int i ) : void =
        if i < MAX_STICKS then let
            val stick_i = SDL_JoystickOpen(i)
            val () = $UNSAFE.ptr0_set<SDL_Joystick_ptr0>(p, stick_i)
        in
            init_arr(ptr0_succ<SDL_Joystick_ptr0>(p), i+1)
        end else ()
        
        val () = init_arr(ptrcast(joy_arr), 0)
    in
        Some_vt(
            ($UNSAFE.castvwtp0{arrayptr(SDL_Joystick_ptr0, j, MAX_STICKS)}(joy_arr)):joysticks
        )
    end
end

implmnt joystick_finish ( jstks ) = let
    fun loop {i:int | i >= 0 && i <= MAX_STICKS}
    ( i: int i, p: ptr(*!arrayptr(SDL_Joystick_ptr0, MAX_STICKS)*) ) : void =
    if i < MAX_STICKS then let
        val p_i = $UNSAFE.ptr0_get<SDL_Joystick_ptr0>(p)
        val () = SDL_JoystickClose(p_i)
    in
        loop(i+1, ptr0_succ<SDL_Joystick_ptr0>(p))
    end else ()
in
    loop(0, ptrcast(jstks));
    arrayptr_freelin(
        $UNSAFE.castvwtp0{arrayptr(SDL_Joystick_ptr0, MAX_STICKS)}(jstks),
        size_of_int(MAX_STICKS)
    )
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
