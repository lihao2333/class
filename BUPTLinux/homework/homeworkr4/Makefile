cc = gcc
ar = ar
calc:calc.c libadd.a
	$(cc) -o calc calc.c -L. -ladd
add.o:add.c add.h
	$(cc) -c add.c 
libadd.a:add.o
	$(ar) rcs libadd.a add.o
clean:
	rm -rf libadd.a add.o calc



