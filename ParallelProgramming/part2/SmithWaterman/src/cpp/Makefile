# .PHONY baseline_compile baseline_run omp_compile omp_run

run: omp_compile omp_run

baseline_compile: cpp_interface.cpp smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp smithwaterman.cpp -g -o baseline

baseline_run: baseline_compile
	./baseline x y z -0.5 0

omp_compile: cpp_interface.cpp omp_smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp omp_smithwaterman.cpp -g -o omp -fopenmp -lpthread

omp_run: omp_compile
	./omp x y z -0.5 0

	