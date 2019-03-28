baseline_compile: baseline.cpp smithwaterman.cpp smithwaterman.h
	g++ baseline.cpp smithwaterman.cpp -g -o baseline

baseline_run: baseline
	./baseline

run: baseline_compile
	./baseline x y z -0.5 0