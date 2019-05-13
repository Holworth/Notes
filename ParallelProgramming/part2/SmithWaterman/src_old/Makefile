# .PHONY baseline_compile baseline_run omp_compile omp_run

baseline_compile: cpp_interface.cpp smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp smithwaterman.cpp -g -o baseline

baseline_run: baseline
	./baseline x y z -0.5 0

omp_compile: cpp_interface.cpp omp_smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp omp_smithwaterman.cpp -g -o omp

omp_run: baseline
	./omp x y z -0.5 0

x10_compile: waterman_parallel.x10
	x10c++ -o x10_basic waterman_parallel.x10

x10_run: x10_basic
	./x10_basic

run: omp_run
	