# .PHONY baseline_compile baseline_run omp_compile omp_run

run: omp_compile omp_run

baseline_compile: cpp_interface.cpp smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp smithwaterman.cpp -g -o baseline

baseline_run: baseline_compile
	./baseline AF043946.1 AF043947.1 BLOSUM62 10 5

omp_compile: cpp_interface.cpp omp_smithwaterman.cpp smithwaterman.h
	g++ cpp_interface.cpp omp_smithwaterman.cpp -g -o omp -fopenmp -lpthread

omp_run: omp_compile
	./omp AF043946.1 AF043947.1 BLOSUM62 10 5

	