ifdef PATSHOME
  ATSHOMEQ=$(PATSHOME)
else
ifdef ATSHOME
  ATSHOMEQ=$(ATSHOME)
else
  ATSHOMEQ="/usr/local/lib/ats2-postiats"
endif
endif

ATSCC=$(ATSHOMEQ)/bin/patscc
ATSOPT=$(ATSHOMEQ)/bin/patsopt

SATS_FILES= \
 source/g_asset.sats \
 source/g_audio.sats \
 source/g_engine.sats \
 source/g_entity.sats \
 source/g_graphics.sats \
 source/g_joystick.sats \
 source/g_physics.sats \
 source/goldelish.sats \
 source/data/dict.sats \
 source/rendering/renderer.sats \
 source/rendering/sky.sats \
 source/SDL2/SDL_local.sats \
 # source/ui/ui_browser.sats
 # source/ui/ui_button.sats
 # source/ui/ui_dialog.sats
 # source/ui/ui_listbox.sats
 # source/ui/ui_option.sats
 # source/ui/ui_rectangle.sats
 # source/ui/ui_slider.sats
 # source/ui/ui_spinner.sats
 # source/ui/ui_style.sats
 # source/ui/ui_text.sats
 # source/ui/ui_textbox.sats
 # source/ui/ui_toast.sats
 # source/g_ui.sats
 # source/assets/animation.sats
 # source/assets/cmesh.sats
 # source/assets/config.sats
 # source/assets/effect.sats
 # source/assets/font.sats
 # source/assets/image.sats
 # source/assets/lang.sats
 # source/assets/material.sats
 # source/assets/music.sats
 # source/assets/renderable.sats
 # source/assets/shader.sats
 # source/assets/skeleton.sats
 # source/assets/sound.sats
 # source/assets/terrain.sats
 # source/assets/texture.sats
 # source/entities/animated_object.sats
 # source/entities/camera.sats
 # source/entities/instance_object.sats
 # source/entities/landscape.sats
 # source/entities/light.sats
 # source/entities/particles.sats
 # source/entities/physics_object.sats
 # source/entities/static_object.sats
 # source/g_net.sats
 # source/data/int_hashtable.sats
 # source/data/int_list.sats
 # source/data/list.sats
 # source/data/randf.sats
 # source/data/spline.sats
 # source/data/vertex_hashtable.sats
 # source/data/vertex_list.sats
DATS_FILES= \
 source/g_asset.dats \
 source/g_audio.dats \
 source/g_engine.dats \
 source/g_entity.dats \
 source/g_graphics.dats \
 source/g_joystick.dats \
 source/g_physics.dats \
 source/goldelish.dats \
 source/data/dict.dats \
 source/rendering/renderer.dats \
 source/SDL2/SDL_local.dats \
 # source/rendering/sky.dats
 # source/ui/ui_browser.dats
 # source/ui/ui_button.dats
 # source/ui/ui_dialog.dats
 # source/ui/ui_listbox.dats
 # source/ui/ui_option.dats
 # source/ui/ui_rectangle.dats
 # source/ui/ui_slider.dats
 # source/ui/ui_spinner.dats
 # source/ui/ui_style.dats
 # source/ui/ui_text.dats
 # source/ui/ui_textbox.dats
 # source/ui/ui_toast.dats
 # source/g_ui.dats
 # source/assets/animation.dats
 # source/assets/cmesh.dats
 # source/assets/config.dats
 # source/assets/effect.dats
 # source/assets/font.dats
 # source/assets/image.dats
 # source/assets/lang.dats
 # source/assets/material.dats
 # source/assets/music.dats
 # source/assets/renderable.dats
 # source/assets/shader.dats
 # source/assets/skeleton.dats
 # source/assets/sound.dats
 # source/assets/terrain.dats
 # source/assets/texture.dats
 # source/entities/animated_object.dats
 # source/entities/camera.dats
 # source/entities/instance_object.dats
 # source/entities/landscape.dats
 # source/entities/light.dats
 # source/entities/particles.dats
 # source/entities/physics_object.dats
 # source/entities/static_object.dats
 # source/g_net.dats
 # source/data/int_list.dats
 # source/data/list.dats
 # source/data/randf.dats
 # source/data/spline.dats
 # source/data/vertex_hashtable.dats
 # source/data/vertex_list.dats
CATS_FILES= \
 source/SDL2/SDL_local.cats \

all: typecheck install test

test: install
	cd test && $(MAKE)

typecheck:
	$(ATSCC) -tcats $(SATS_FILES)
	$(ATSCC) -tcats $(DATS_FILES)

install: typecheck
	mkdir $(ATSHOMEQ)/Goldelish-Install
	cp $(SATS_FILES) $(ATSHOMEQ)/Goldelish-Install
	cp $(DATS_FILES) $(ATSHOMEQ)/Goldelish-Install
	cp source/goldelish.hats $(ATSHOMEQ)/Goldelish-Install
