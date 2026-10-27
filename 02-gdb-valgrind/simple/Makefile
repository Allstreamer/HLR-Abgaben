all: simple.x
	
CFLAGS = -std=c11 -pedantic -Wall -Wextra -Og -ggdb -gdwarf-4

simple.x: simple.o
	gcc $(CFLAGS) -o simple.x simple.o
	
simple.o: simple.c
	gcc $(CFLAGS) -c simple.c

clean:
	rm -f simple.x
	rm -f *.o
	rm -f *~
