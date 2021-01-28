(*
###  g_graphics.dats  ###


*)

#include "share/atspre_staload.hats"

staload "./g_graphics.sats"
staload "./g_asset.sats"
staload "./g_engine.sats"
staload "./assets/image.sats"
staload "./SDL2/SDL_local.sats"

local

extern castfn uint32_to_int ( uint32 ) : int
extern castfn uint32_to_uint ( uint32 ) : uint

assume graphics_viewport = @{
    screen=SDL_Window_ptr1,
    context=SDL_GLContext1,
    window_flags=int,
    window_multisamples=int,
    window_multisamplesbuffs=int,
    window_antialiasing=int
}

in

implmnt graphics_init (  ) =
    if SDL_InitSubSystem(SDL_INIT_VIDEO) = ~1 then None_vt()
    else let
        val win_flags = SDL_WINDOW_OPENGL
        val win_multisamples = 4
        val win_multisamplesbuffs = 1
        val win_antialiasing = 1
        val scrn = SDL_CreateWindow("Goldelish", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 800, 600, win_flags)
    in
    if ptrcast(scrn) > 0 then let
        val gl_attr = SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1)
        val cntxt = SDL_GL_CreateContext(scrn)
    in
    if ptrcast(cntxt) > 0 then let
        val swapintrvl = SDL_GL_SetSwapInterval(1)
        val () = SDL_GL_LoadExtensions()
        val () = glViewport(int_to_GLint(0), int_to_GLint(0), int_to_GLsizei(800), int_to_GLsizei(600))
        val () = SDL_GL_PrintInfo()
        val () = SDL_GL_PrintExtensions()
        var ret = @{
            screen=scrn,
            context=cntxt,
            window_flags=uint32_to_int(win_flags),
            window_multisamples=win_multisamples,
            window_multisamplesbuffs=win_multisamplesbuffs,
            window_antialiasing=win_antialiasing
        }:graphics_viewport
        val () = graphics_viewport_set_icon(ret, P("coreassets/ui/goldelish.bmp"))
    in
        Some_vt( ret )
    end else let
        prval () = _consume_null(cntxt) where { extern praxi _consume_null{l:addr}( SDL_GLContext_base(l) ) : void }
        val () = SDL_DestroyWindow(scrn)
    in None_vt() end
    end else let
        prval () = _consume_null(scrn) where { extern praxi _consume_null{l:addr}( SDL_Window_ptr_base(l) ) : void }
    in
        None_vt()
    end
    end

implmnt graphics_context_new ( gvp ) = let
    val i = SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1)
in
    SDL_GL_CreateContext(gvp.screen)
end

implmnt graphics_context_delete ( context ) = SDL_GL_DeleteContext(context)

implmnt graphics_context_current ( gvp, context ) = let val i = SDL_GL_MakeCurrent(gvp.screen, context) in () end

implmnt graphics_set_antialiasing ( gvp, quality ) = gvp.window_antialiasing := quality

implmnt graphics_get_antialiasing ( gvp ) = gvp.window_antialiasing

implmnt graphics_finish ( gvp ) = let
    val () = SDL_GL_DeleteContext(gvp.context)
    val () = SDL_DestroyWindow(gvp.screen)
in () end

implmnt graphics_set_multisamples ( gvp, multisamples ) = let
    val () = gvp.window_multisamples := multisamples
in
    if multisamples > 0 then gvp.window_multisamplesbuffs := 1
    else gvp.window_multisamplesbuffs := 0
end

implmnt graphics_get_multisamples ( gvp ) = gvp.window_multisamples

implmnt graphics_set_vsync ( vsync ) = let val i = SDL_GL_SetSwapInterval(bool2int(vsync))
in () end

implmnt graphics_set_fullscreen ( gvp, fullscreen ) =
    if fullscreen then gvp.window_flags := g0uint2int_uint_int(g0uint_lor_uint(g0int2uint_int_uint(gvp.window_flags), uint32_to_uint(SDL_WINDOW_FULLSCREEN_DESKTOP)))
    else gvp.window_flags := g0uint2int_uint_int(g0uint_lnot_uint(g0uint_land_uint(g0int2uint_int_uint(gvp.window_flags), uint32_to_uint(SDL_WINDOW_FULLSCREEN_DESKTOP))))

implmnt graphics_get_fullscreen ( gvp ) =
    if g0uint_land_uint(g0int2uint_int_uint(gvp.window_flags), uint32_to_uint(SDL_WINDOW_FULLSCREEN_DESKTOP)) != g0int2uint_int_uint(0) then true
    else false

implmnt graphics_viewport_set_size ( gvp, w, h ) = {
    val () = SDL_SetWindowSize(gvp.screen, w, h)
    val () = glViewport(int_to_GLint(0), int_to_GLint(0), int_to_GLsizei(w), int_to_GLsizei(h))
}

implmnt graphics_viewport_height ( gvp ) = let
    var w: int = 0
    var h: int = 0
in
    SDL_GetWindowSize(gvp.screen, w, h);
    h
end

implmnt graphics_viewport_width ( gvp ) = let
    var w: int = 0
    var h: int = 0
in
    SDL_GetWindowSize(gvp.screen, w, h);
    w
end

implmnt graphics_viewport_ratio ( gvp ) = let
    var w: int = 0
    var h: int = 0
in
    SDL_GetWindowSize(gvp.screen, w, h);
    g0int2float(h) / g0int2float(w)
end

implmnt graphics_viewport_set_title ( gvp, title ) = SDL_SetWindowTitle(gvp.screen, title)

implmnt graphics_viewport_set_icon ( gvp, icon ) = let
    var window_icon = SDL_LoadBMP(fpath_string(icon))
    val () = fpath_delete(icon)
in
    if ptrcast(window_icon) > 0 then let
        val () = SDL_SetWindowIcon(gvp.screen, window_icon)
    in
        SDL_FreeSurface(window_icon)
    end else SDL_FreeSurface(window_icon)
end

implmnt graphics_viewport_title ( gvp ) = SDL_GetWindowTitle(gvp.screen)

implmnt graphics_viewport_screenshot (  ) = {
(*
    val image_data =
    val () = glReadPixels()
    val i = image_new()
    val () = image_flip_vertical(i)
    val () = image_bgr_to_rgb(i)
    val () =
    val () = timestamp()
    val () = strcat()
    val () = strcat()
    val () = strcat()
    val () = image_write_to_file(i, )
    val () = image_delete(i)
*)
}

implmnt graphics_set_cursor_hidden ( hidden ) =
    if hidden then { val i = SDL_ShowCursor(SDL_DISABLE) }
    else { val i = SDL_ShowCursor(SDL_ENABLE) }

implmnt graphics_get_cursor_hidden (  ) =
    if SDL_ShowCursor(SDL_QUERY) = SDL_ENABLE then false
    else true

implmnt graphics_swap ( gvp ) = SDL_GL_SwapWindow(gvp.screen)

end
