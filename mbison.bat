C:\sw\cygwin\bin\bison -d %1.y
:: C:\bison -d %1.y
C:\sw\cygwin\bin\flex -L -o%1.c %1.l
:: C:\flex -L -o%1.c %1.l
gcc -c %1.c
gcc -c %1.tab.c
gcc -L"c:\sw\cygwin\lib" %1.o %1.tab.o -o%1.exe -lfl -ly
:: gcc -L"C:\cygnus\cygwin-b20\H-i586-cygwin32\lib" %1.o %1.tab.o -o%1.exe -lfl -ly