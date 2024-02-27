# search and replace 
# %s/term/replacement_term/g
#CFLAGS =  -ggdb
all: gameTest
first: gameTest.o
	gcc -static -ggdb  -o gameTest gameTest.o
first.o: gameTest.s
	as -o gameTest.o gameTest.s
clean: 
	rm -vf gameTest *.o
