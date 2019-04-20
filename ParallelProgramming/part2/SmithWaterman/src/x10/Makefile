# .PHONY baseline_compile baseline_run omp_compile omp_run

run: x10_parallel_compile x10_parallel_run

x10_parallel_compile: waterman_parallel.x10
	x10c++ -o x10_parallel waterman_parallel.x10

x10_parallel_run: x10_parallel
	./x10_parallel

x10_basic_compile: waterman_basic.x10
	x10c++ -o x10_basic waterman_basic.x10

x10_basic_run: x10_basic
	./x10_basic

	