compile_and_test: compile_all test_only 

test_only: 
	python autotest.py

compile_all:
	cd ../src/x10 && make x10_parallel_compile
	cd ../src/x10 && make x10_basic_compile
	cd ../src/x10 && make x10_diagonal_compile
	cd ../src/cpp && make baseline_compile
	cd ../src/cpp && make omp_compile
	mv -u ../src/x10/x10_parallel ./
	mv -u ../src/x10/x10_basic ./
	mv -u ../src/x10/x10_parallel_diagonal ./
	mv -u ../src/cpp/baseline ./
	mv -u ../src/cpp/omp ./