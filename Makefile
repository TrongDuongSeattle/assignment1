all:test
first:test.o
	gcc -o test test.o
first.o:test.s
	as -o test.o test.s
clean: 
	rm -vf test *.o
