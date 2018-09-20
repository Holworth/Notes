for file in ./* do
    gcc $file -o $file.o
    objdump -d $file.o >> $file.log
    objdump -x $file.o >> $file.log
    objdump -t $file.o >> $file.log
done