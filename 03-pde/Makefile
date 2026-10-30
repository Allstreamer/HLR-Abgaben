# Common definitions
CC = clang
#CC = gcc

# Testing assert:
#CUSTOM_FLAGS = -O3 -march=westmere -gdwarf-4 -DNDEBUG
#CUSTOM_FLAGS = -O3 -march=westmere -gdwarf-4 -fsanitize=address,leak

# Benchmarking flags:
#CUSTOM_FLAGS = -O3 -march=westmere -gdwarf-4 -DNDEBUG -fno-omit-frame-pointer -fno-optimize-sibling-calls
#CUSTOM_FLAGS = -O3 -march=westmere -flto -DNDEBUG -Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize

# Release flags:
CUSTOM_FLAGS = -O3 -march=westmere -flto -fuse-ld=lld -DNDEBUG

# Compiler flags, paths and libraries
CFLAGS = -std=c11 -pedantic -Wall -Wextra $(CUSTOM_FLAGS)
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
