bison -d $1.y
flex -L -o $1.c $1.l
gcc -c $1.c
gcc -c $1.tab.c
gcc $1.o $1.tab.o -o $1 -lfl -ly

rm -f $1.c $1.tab.c $1.tab.h