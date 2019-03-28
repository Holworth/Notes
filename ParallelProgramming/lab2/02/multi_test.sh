gcc $1.c -fopenmp -o $1.out
./$1.out >> $1.log
echo Finished.