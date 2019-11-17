# the makefile, attempt #2

include $(PATSHOME)/share/atsmake-pre.mk

CFLAGS0 = $(CFLAGS)
LDFLAGS0 = $(LDFLAGS)

CFLAGS0 += -I ./include -std=gnu99 -Wall -Werror -Who-unused -03 -g
LDFLAGS0 += -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g

MYCCRULE=MYCCRULE

MALLOCFLAG=-DATS_MEMALLOC_LIBC

#  todo:
#
#  figure out how to reimplement SRC and OBJ
SRC = $(wildcard src/*.c) $(wildcard src/*/*.c)
OBJ = $(addprefix obj/,$(notdir $(SRC:.c=.o)))

#  figure out how to create $(DYNAMIC) and $(STATIC)
PLATFORM = $(shell uname)
ifeq ($($findstring Linux, $(PLATFORM)), Linux)
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
	DYNAMIC = corange.dll
	STATIC = libcorange.a
	LDFLAGS0 += -lmingw32 -lopengl32 -lSDL2main -lSDL2 -lSDL2_mixer -lSDL2_net -shared -g
endif

#  figure out how to compile .dats to .o  ##  figure out how to compile all .dats in 'source' to 'object'
#   - solution: simply create rules for compiling ats to c, then c to o
all: $(DYNAMIC) $(STATIC)
$(DYNAMIC): $(OBJ)
	$(CC) $(OBJ) $(PATSLIB) $(LDFLAGS) -o $@
$(STATIC): $(OBJ)
	$(AR) rcs $@ $(OBJ)
obj/%.o: source/%.c | obj
	$(CC) $< -c $(CFLAGS0) $(PATSLIB) -o $@
obj/%.o: source/*/%.c | obj
	$(CC) $< -c $(CFLAGS0) $(PATSLIB) -o $@
obj:
	mkdir obj

# - compiles ats to c -
source/%.dats: source/%.dats | source
	$(PATSOPT) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
source/*/%.dats:
	$(PATSOPT) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
# - after this, when compiling the c, remember to use 'PATSLIB' so that it can compile -

#all:
#	goldelish
#goldelish: goldelish.dats
#	$(PATSCC2) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
#regress: goldelish
#	./$<
#cleanall:
#	$(RMF) goldelish

testall:
	all
testall:
	regress
testall:
	cleanall

include $(PATSHOME)/share/atsmake-post.mk

cleanats:
	$(RMF) *_?ats.c
