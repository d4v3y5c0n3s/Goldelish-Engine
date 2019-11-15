#
#	This is a Makefile for compiling the engine (uses GNU Make for compilation.)
#

# includes a Makefile that sets up commonly used rules/variables for using ATS (which is included in your ATS installation)
#include $(PATSHOME)/share/atsmake-pre.mk

CC=gcc
AR=ar

#  where source files are and where to compile them to
#SRC =
#OBJ =

ifdef \
PATSHOME
	PATSHOMEQ="$(PATSHOME)"
else
ifdef ATSHOME
	PATSHOMEQ="$(ATSHOME)"
else
	PATSHOMEQ="/usr/local/lib/ats2-postiats"
endif
endif

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib

#  compilation flags
CFLAGS += -I ./include -std=gnu99 -Wall -Werror -Wno-unused -03 -g
LFLAGS += -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g

#  platforms
PLATFORM = $(shell uname)
ifeq ($($findstring Linux, $(PLATFORM)), Linux)
	DYNAMIC = libgoldelish.so
	STATIC = libgoldelish.a
	CFLAGS += -fPIC
	LFLAGS += -lGL
endif

ifeq ($(findstring Darwin, $(PLATFORM)), Darwin)
	DYNAMIC = libgoldelish.so
	STATIC = libgoldelish.a
	CFLAGS +=  -fPIC
	LFLAGS += -framework OpenGL
endif

ifeq ($(findstring MINGW, $(PLATFORM)), MINGW)
	DYNAMIC = corange.dll
	STATIC = libcorange.a
	LFLAGS += -lmingw32 -lopengl32 -lSDL2main -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g
endif

#  patterns for make
all:	$(DYNAMIC)	$(STATIC)

$(DYNAMIC): $(OBJ)
	$(PATSCC)	$(OBJ)	$(LFLAGS)	-o	$@

$(STATIC): $(OBJ)
	$(AR)	rcs	$@	$(OBJ)

obj/%.o: src/%.dats | obj
	$(PATSCC)	$<	-c	$(CFLAGS)	-o	$@

obj/%.o: src/*/%.dats | obj
	$(PATSCC)	$<	-c	$(CFLAGS)	-o	$@

obj:
	mkdir	obj

clean:
	rm $(OBJ)	$(STATIC)	$(DYNAMIC)

#  for cleaning ATS
cleanats::	;	$(RMF)	*_?ats.c

# installation for different platforms
install_unix:
	cp	$(STATIC)	/usr/local/lib/$(STATIC)

install_win32:
	cp	$(STATIC)	C:/MinGW/lib/$(STATIC)

install_win64:
	cp	$(STATIC)	C:/MinGW64/x86_64-w64-mingw32/lib/$(STATIC)
	cp	$(DYNAMIC)	C:/MinGW64/x86_64-w64-mingw32/bin/$(DYNAMIC)

# same as previous include, except for the end of the Makefile
#include $(PATSHOME)/share/atsmake-post.mk
