include $(PATSHOME)/share/atsmake-pre.mk

AR=ar

CFLAGS0 = $(CFLAGS)
LDFLAGS0 = $(LDFLAGS)

CFLAGS0 += -I ./include -std=gnu99 -O3 -g
LDFLAGS0 += -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g

SOURCES_SATS += $(wildcard source/*.sats) $(wildcard source/*/*.sats)  #the static files in the project
SOURCES_DATS += $(wildcard source/*.dats) $(wildcard source/*/*.dats)  #the dynamic files in the project

SOURCES_DATS_OBJ += $(addprefix obj/,$(notdir $(SOURCES_DATS:.dats=_dats.o)))

SOURCES_OBJ = $(SOURCES_DATS_OBJ)

PLATFORM = $(shell uname)
ifeq ($(findstring Linux, $(PLATFORM)), Linux)
	DYNAMIC = libgoldelish.so
	STATIC = libgoldelish.a
	CFLAGS0 += -fPIC
	LDFLAGS0 += -lGL
endif
ifeq ($(findstring CYGWIN, $(PLATFORM)), CYGWIN)
	DYNAMIC = libgoldelish.so
	STATIC = libgoldelish.a
	CFLAGS0 += -fPIC
	LDFLAGS0 += -lGL
endif
ifeq ($(findstring Darwin, $(PLATFORM)), Darwin)
	DYNAMIC = libgoldelish.so
	STATIC = libgoldelish.a
	CFLAGS0 +=  -fPIC
	LDFLAGS0 += -framework OpenGL
endif
ifeq ($(findstring MINGW, $(PLATFORM)), MINGW)
	DYNAMIC = goldelish.dll
	STATIC = libgoldelish.a
	LDFLAGS0 += -lmingw32 -lopengl32 -lSDL2main -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g
endif

INCLUDE += $(LDFLAGS0)

display_sources:
	@echo "SOURCES_SATS:"
	@echo $(SOURCES_SATS)
	@echo "SOURCES_DATS:"
	@echo $(SOURCES_DATS)

display_platform:
	@echo "the platform you are using is:"
	@echo $(PLATFORM)

all:: $(DYNAMIC) $(STATIC)
$(DYNAMIC): $(SOURCES_OBJ)
	@echo "reached the dynamic block"
	$(CC) $(SOURCES_OBJ) $(LDFLAGS0) -o $@
$(STATIC): $(SOURCES_OBJ)
	$(AR) rcs $@ $(SOURCES_OBJ)
#obj/%_sats.o: source/%.sats | obj
#	$(PATSCC) --debug $(INCLUDE) $(INCLUDE_ATS) $(CFLAGS0) -o $@ -c $<
#obj/%_sats.o: source/*/%.sats | obj
#	$(PATSCC) --debug $(INCLUDE) $(INCLUDE_ATS) $(CFLAGS0) -o $@ -c $<
obj/%_dats.o: source/%.dats | obj
	$(PATSCC) --debug --gline $(INCLUDE) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS0) -o $@ -c $<
obj/%_dats.o: source/*/%.dats | obj
	$(PATSCC) --debug --gline $(INCLUDE) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS0) -o $@ -c $<
obj:
	mkdir obj

clean:
	rm $(SOURCES_OBJ) $(STATIC) $(DYNAMIC) $(wildcard *.c); $(shell rm -r obj)

install_unix: $(STATIC)
	cp $(STATIC) /usr/local/lib/$(STATIC)

install_win32: $(STATIC)
	cp $(STATIC) C:/MinGW/lib/$(STATIC)

install_win64: $(STATIC) $(DYNAMIC)
	cp $(STATIC) C:/MinGW64/x86_64-w64-mingw32/lib/$(STATIC)
	cp $(DYNAMIC) C:/MinGW64/x86_64-w64-mingw32/bin/$(DYNAMIC)

include $(PATSHOME)/share/atsmake-post.mk
