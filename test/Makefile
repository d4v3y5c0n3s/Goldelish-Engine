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

ATSCCFLAGS=-O2 -flto

CFLAGS0 += $(shell pkg-config SDL2_mixer --cflags)
CFLAGS0 += $(shell pkg-config SDL2_net --cflags)

LDFLAGS0 = $(LDFLAGS)
LDFLAGS0 += $(shell pkg-config sdl2 --libs)
LDFLAGS0 += $(shell pkg-config SDL2_mixer --libs)
LDFLAGS0 += $(shell pkg-config SDL2_net --libs)

SATS_FILES=\

DATS_FILES=\
 testgame.dats\

C_FILES=\

EXECUTABLE=testgame

all: $(EXECUTABLE)

$(EXECUTABLE) : testgame.dats ; \
	$(ATSCC) $(ATSCCFLAGS) $(CFLAGS0) -o $@ $< $(LDFLAGS0)

clean:
	rm -f $(EXECUTABLE)
	rm -f *~
	rm -f *_?ats.o
	rm -f *_?ats.c

