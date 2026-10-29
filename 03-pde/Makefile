# Common definitions
CC = clang

# Compiler flags, paths and libraries
CFLAGS = -std=c11 -pedantic -Wall -Wextra -O0 -gdwarf-4
LFLAGS = $(CFLAGS)
LIBS   = -lm

OBJS = partdiff-seq.o askparams.o displaymatrix.o

# Rule to create *.o from *.c
.c.o:
	$(CC) -c $(CFLAGS) $*.c

# Targets ...
all: partdiff-seq.x

partdiff-seq.x: $(OBJS) Makefile
	$(CC) $(LFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	${RM} partdiff-seq.x
	$(RM) *.o *~

partdiff-seq.o: partdiff-seq.c Makefile

askparams.o: askparams.c Makefile

displaymatrix.o: displaymatrix.c Makefile
