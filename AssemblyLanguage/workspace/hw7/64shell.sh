echo as --gstabs -o $1.o $1.S
as --gstabs -o $1.o $1.S
echo ld -o $1 $1.o
ld -o $1 $1.o
echo running $1
./$1