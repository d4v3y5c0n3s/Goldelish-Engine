# the makefile
#  NOTE: The Makefile doesn't seem to be compiling .dats files, try connecting it to "all"

CC=gcc
AR=ar
PATSHOMEQ=$(PATSHOME)

CFLAGS0 = $(CFLAGS)
LDFLAGS0 = $(LDFLAGS)

CFLAGS0 += -I ./include -std=gnu99 -Wall -Werror -Who-unused -03 -g
LDFLAGS0 += -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g

MYCCRULE=MYCCRULE

MALLOCFLAG=-DATS_MEMALLOC_LIBC

SRC = $(wildcard src/*.c) $(wildcard src/*/*.c)
OBJ = $(addprefix obj/,$(notdir $(SRC:.c=.o)))

#  ATS compilers
PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib/libatslib.a

PLATFORM = $(shell uname)
ifeq ($(findstring Linux, $(PLATFORM)), Linux)
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

# - simply create rules for compiling ats to c, then .c to .o -
# - when compiling the c, remember to use 'PATSLIB' so that it can compile -
all: $(DYNAMIC) $(STATIC)
$(DYNAMIC): $(OBJ)
	$(CC) $(OBJ) $(PATSLIB) $(LDFLAGS0) -o $@
$(STATIC): $(OBJ)
	$(AR) rcs $@ $(OBJ)
obj/%.o: source/%.c | obj
	$(CC) $< -c $(CFLAGS0) -o $@
obj/%.o: source/*/%.c | obj
	$(CC) $< -c $(CFLAGS0) -o $@
obj:
	mkdir obj

source/%.dats.c: source/%.dats | source
	$(PATSOPT) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
source/*/%.dats.c: source/*/%.dats | source
	$(PATSOPT) $(CFLAGS0) -o $@ $< $(LDFLAGS0)

testall:: all
testall:: regress
testall:: cleanall

cleanats:
	$(RMF) *_?ats.c

clean:
	rm $(OBJ) $(STATIC) $(DYNAMIC)

install_unix: $(STATIC)
	cp $(STATIC) /usr/local/lib/$(STATIC)

install_win32: $(STATIC)
	cp $(STATIC) C:/MinGW/lib/$(STATIC)

install_win64: $(STATIC) $(DYNAMIC)
	cp $(STATIC) C:/MinGW64/x86_64-w64-mingw32/lib/$(STATIC)
	cp $(DYNAMIC) C:/MinGW64/x86_64-w64-mingw32/bin/$(DYNAMIC)
