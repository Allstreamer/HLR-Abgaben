# Makefile for parprakt

# Common definitions
CC	= gcc

# Compiler flags, paths and libraries
CFLAGS	= -ggdb -Wall -pedantic -Wextra -Og -gdwarf-4
LFLAGS  = 
LIBS	= -lm

OBJS        = partdiff-seq.o askparams.o displaymatrix.o

# Rule to create *.o from *.c
.c.o:
	$(CC) -c $(CFLAGS) $*.c

# Targets ...
all: partdiff-seq.x Makefile

partdiff-seq.x: $(OBJS) Makefile
	$(CC) $(LFLAGS) -o $@ $(OBJS) $(LIBS)

clean:  
	$(RM) *.o *~ partdiff-seq.x

#partdiff-seq.o: partdiff-seq.c Makefile 
partdiff-seq.o:

askparams.o: askparams.c Makefile

displaymatrix.o: displaymatrix.c Makefile
