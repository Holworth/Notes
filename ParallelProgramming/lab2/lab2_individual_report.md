# CS3211 Part2 Individual Report

* Wang Huaqiang

---

## Lab1: openMP, and memory behaviour

### Task 1

> Compile and run the matrix multiplication program. Observe the number of threads that the program is using. What is the number? Why is it this number? You can change the number of threads using the function omp_set_num_threads(int) in your OpenMP code, or the environment variable OMP_NUM_THREADS.

8 threads. 

Because this time I was running it on my computer, and my computer has a Intel-I76700HQ CPU, which has 4 cores and 8 threads. Therefore openMP used all useable threads tio get the best speed.

### Task 2 

>Tabulate the (unloaded) runtime for the program working on arrays of size 128 up to 2048, and for threads from 1 to (say) 32. The size of the problem should go across the table, and one row for each number of threads (1,2,4,8,16,32). Note that the times will vary dramatically, dependant on other events in the particular computer you are using. In your table, should you use the minimum, average or maximum value for the times?

Notes: After 8 threads, the time of exec will not change at all, for the computer I used support up to 8 threads in parallel.

Because we have other programs runing on the machine, we run the test script multiple times. And then, we pick the shortest time in result, for these results are closest to the ideal performance of the program being tested.

### Task 3

> Record and interpret your table. What do the rows and columns tell you? Can you relate any discontinuities in the results tabulated to things you might know or discover about the processor?

### Task 4 

> Repeat your experiment from Tasks 1..3, only this time use threads from 1 to 40. Compile and run the program as before, tabulating the results. In your writeup, you should be able to explain why we are interested in up to 8 threads on the lab machines and 40 threads on the tembusu machines, and also explain the tabulated results in terms of speedup.

### Task 5

> Download, compile and run the program testmem.c:

### Task 6 

> Tabulate and explain the results you got in task 5. You could even plot them

### Task 7

> Use perf stat to produce a summary of program performance:

Unfortunately, we do not have the permission to use perf on the cluster, and perf does not support Windows Subsystem of Linux. The following test was based on a VM, and as a sequence the result could be different from running perf on a normal linux. 

TBD


### Task 8

> Use perf to measure (L1 and L3) cache loads and misses for different sizes of array. Tabulate and interpret the results.

array size|L1 load|L1 miss|L3 load|L3 miss
-|-|-|-|-

---

## Lab2 Accuracy

### Accuracy examples

This one fails with an interesting effect. What is the interesting 2x value in this case? Make sure you understand exactly what effect is happening here.

> Compile and run the fpadd1 program. Observe the accuracy of the answers you get. Examine the code. Examine the output. You will see a peculiarity between 16500000 and 17000000 additions. Note that you would really expect 19000000 1s added together to have the value 19000000, but it is way way out!

Your goal here is to make sure you understand why this mindlessly simple program acts the way it
does. Why does the strange value 2
24 keep appearing?

### 2

Compile and run the fpadd2 program. Observe the accuracy of the answers you get. Examine
the code. Examine the output. You will see peculiarities between 1000000 and 1500000, 4000000
and 4500000 additions. Your goal here is to make sure you understand why this mindlessly
simple program acts the way it does.

### 

---

## Lab3

---

## Lab4

### 4.1. Simple automata

We represent these NFAs in the form of regular expressions, as they are equivalent mathematically. The two NFAs in 1.2 can be represented as:

```re
[^a]*(a[^a]*a[^a]*)*a
```

and

```re
.*a.*b
```

### Construct automata

#### 1. 

> Construct an NFA which signals every time there is an “abba” sequence found in a string.

![Java Printing - Google Chrome 2019_4_2 14_52_32](/assets/Java%20Printing%20-%20Google%20Chrome%202019_4_2%2014_52_32.png)

#### 2. 

> Construct an NFA which matches whenever `a*b*b*a` is found. The `*` characters indicatethere can be other characters between the “a”s and “b”s. Note though that “abbba” would not match (there should be only one of each character).

![Java Printing - Google Chrome 2019_4_2 14_53_26](/assets/Java%20Printing%20-%20Google%20Chrome%202019_4_2%2014_53_26.png)

#### 3. 

> Construct a recognizer for instances of either of the two sequences “aba” and “bca”. Do this both as a single NFA, and as two NFAs (with two distinct starting states).

![Java Printing - Google Chrome 2019_4_2 14_53_50](/assets/Java%20Printing%20-%20Google%20Chrome%202019_4_2%2014_53_50.png)

#### 4.

> Assuming the degree of parallelism is expressed as a percentage of the program automata cells that are active, what is the maximum degree of parallelism you see with each of the automata you have constructed today?

NFA|maximum degree of parallelism|Instance
-|-|-
1|0.6|abba
2|0.6|abba
3 single NFA|0.43|aba
3 double NFA|0.375|aba

#### 5.

> Can you characterize the sort of problems that automata processors are naturally suited for?

We assume automata mentioned here are DFAs/NFAs, not more powerful calculate model such as PDAs (push down automata). Then, as DFAs/NFAs are equivalent with REGs (regular expressions), they are naturally suitable for regular expressions match. NFA model makes it possible to match REGs in parallel.  