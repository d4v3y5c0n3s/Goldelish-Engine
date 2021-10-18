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

SOURCE_SATS= \
 source/g_asset.sats \
 source/g_audio.sats \
 source/g_engine.sats \
 source/g_entity.sats \
 source/g_graphics.sats \
 source/g_joystick.sats \
 source/g_physics.sats \
 source/goldelish.sats \
 # source/g_ui.sats
 # source/g_net.sats

SDL2_SATS= \
 source/SDL2/SDL_local.sats \

ASSETS_SATS= \
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

DATA_SATS= \
 source/data/dict.sats \
 # source/data/int_hashtable.sats
 # source/data/int_list.sats
 # source/data/list.sats
 # source/data/randf.sats
 # source/data/spline.sats
 # source/data/vertex_hashtable.sats
 # source/data/vertex_list.sats

ENTITIES_SATS= \
 # source/entities/animated_object.sats
 # source/entities/camera.sats
 # source/entities/instance_object.sats
 # source/entities/landscape.sats
 # source/entities/light.sats
 # source/entities/particles.sats
 # source/entities/physics_object.sats
 # source/entities/static_object.sats

RENDERING_SATS= \
 source/rendering/renderer.sats \
 source/rendering/sky.sats \

UI_SATS= \
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

SATS_FILES= \
 $(SOURCE_SATS) \
 $(SDL2_SATS) \
 $(ASSETS_SATS) \
 $(DATA_SATS) \
 $(ENTITIES_SATS) \
 $(RENDERING_SATS) \
 $(UI_SATS) \

SOURCE_DATS= \
 source/g_asset.dats \
 source/g_audio.dats \
 source/g_engine.dats \
 source/g_entity.dats \
 source/g_graphics.dats \
 source/g_joystick.dats \
 source/g_physics.dats \
 source/goldelish.dats \
 # source/g_ui.dats
 # source/g_net.dats

SDL2_DATS= \
 source/SDL2/SDL_local.dats \

ASSETS_DATS= \
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

DATA_DATS= \
 source/data/dict.dats \
 # source/data/int_list.dats
 # source/data/list.dats
 # source/data/randf.dats
 # source/data/spline.dats
 # source/data/vertex_hashtable.dats
 # source/data/vertex_list.dats

ENTITIES_DATS= \
 # source/entities/animated_object.dats
 # source/entities/camera.dats
 # source/entities/instance_object.dats
 # source/entities/landscape.dats
 # source/entities/light.dats
 # source/entities/particles.dats
 # source/entities/physics_object.dats
 # source/entities/static_object.dats

RENDERING_DATS= \
 source/rendering/renderer.dats \
 # source/rendering/sky.dats

UI_DATS= \
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

DATS_FILES= \
 $(SOURCE_DATS) \
 $(SDL2_DATS) \
 $(ASSETS_DATS) \
 $(DATA_DATS) \
 $(ENTITIES_DATS) \
 $(RENDERING_DATS) \
 $(UI_DATS) \

SDL2_CATS= \
 source/SDL2/SDL_local.cats \

CATS_FILES= \
 $(SDL2_CATS) \

all: typecheck install test

test: install
	cd test && $(MAKE)

typecheck:
	$(ATSCC) -tcats $(SATS_FILES)
	$(ATSCC) -tcats $(DATS_FILES)

INSTALL_LOCATION=$(ATSHOMEQ)/Goldelish-Install

install: typecheck
	mkdir $(INSTALL_LOCATION)
	mkdir $(INSTALL_LOCATION)/assets
	mkdir $(INSTALL_LOCATION)/data
	mkdir $(INSTALL_LOCATION)/entities
	mkdir $(INSTALL_LOCATION)/rendering
	mkdir $(INSTALL_LOCATION)/ui
	mkdir $(INSTALL_LOCATION)/SDL2
	cp $(SOURCE_SATS) $(INSTALL_LOCATION)
	cp $(DATA_SATS) $(INSTALL_LOCATION)/data
	cp $(RENDERING_SATS) $(INSTALL_LOCATION)/rendering
	cp $(SDL2_SATS) $(INSTALL_LOCATION)/SDL2
	cp $(SOURCE_DATS) $(INSTALL_LOCATION)
	cp $(DATA_DATS) $(INSTALL_LOCATION)/data
	cp $(RENDERING_DATS) $(INSTALL_LOCATION)/rendering
	cp $(SDL2_DATS) $(INSTALL_LOCATION)/SDL2
	cp $(SDL2_CATS) $(INSTALL_LOCATION)/SDL2
	cp source/goldelish.hats $(INSTALL_LOCATION)
#	cp $(ASSETS_SATS) $(INSTALL_LOCATION)/assets
#	cp $(ASSETS_DATS) $(INSTALL_LOCATION)/assets
#	cp $(ENTITIES_SATS) $(INSTALL_LOCATION)/entities
#	cp $(ENTITIES_DATS) $(INSTALL_LOCATION)/entities
#	cp $(UI_SATS) $(INSTALL_LOCATION)/ui
#	cp $(UI_DATS) $(INSTALL_LOCATION)/ui

clean:
	rm -r $(INSTALL_LOCATION)
