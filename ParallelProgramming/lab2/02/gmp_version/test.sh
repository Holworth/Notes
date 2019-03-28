gcc $1.c -fopenmp -L/mnt/f/workpath/Notes/ParallelProgramming/lab2/02/gmp-4.3.2 -lgmp -o $1.out
./$1.out > $1.log
echo Finished.