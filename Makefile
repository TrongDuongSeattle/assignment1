# search and replace 
# %s/term/replacement_term/g
all: nestedforas
first: nestedforas.o
	gcc -static  -o nestedforas nestedforas.o
first.o: nestedforasas.s
	as -o nestedforasas.o nestedforas.s
clean: 
	rm -vf nestedforas *.o
