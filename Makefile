# search and replace 
# %s/term/replacement_term/g
all: nestedForTest
first: nestedForTest.o
	gcc -static  -o nestedForTest nestedForTest.o
first.o: nestedForTestas.s
	as -o nestedForTestas.o nestedForTest.s
clean: 
	rm -vf nestedForTest *.o
