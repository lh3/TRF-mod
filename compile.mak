CC=			gcc
CFLAGS=		-g -Wall -O3
CPPFLAGS=
INCLUDES=
OBJS=		src/trf.o
PROG=		trf-mod
LIBS=		-lz

ifneq ($(asan),)
	CFLAGS+=-fsanitize=address
	LIBS+=-fsanitize=address
endif

.SUFFIXES:.c .o
.PHONY:all clean depend

.c.o:
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

trf-mod:$(OBJS)
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

clean:
		rm -fr gmon.out src/*.o a.out $(PROG) *~ *.dSYM

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -f compile.mak -- $(CFLAGS) $(DFLAGS) -- src/*.c)

# DO NOT DELETE

src/trf.o: src/trfrun.h src/tr30dat.h src/tr30dat.c src/trfclean.h
