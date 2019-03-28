gcc $1.c -fopenmp -lgmp -o $1.out
./$1.out >> $1.log
echo Finished.