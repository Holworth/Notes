Parallel Programming
=====================

This course is taken in NUS.

<!-- [TOC] -->

<!-- TOC -->
- [1. 拾遗](#1-拾遗)
- [2. CSP# cheatsheet](#2-csp-cheatsheet)
    - [2.1. CSP](#21-csp)
    - [2.2. CSP](#22-csp)
    - [2.3. CSP Examples](#23-csp-examples)
- [3. X10 cheatsheet](#3-x10-cheatsheet)
- [4. Parallel Programming](#4-parallel-programming)
    - [4.1. Lect 7: Introduction to x10.](#41-lect-7-introduction-to-x10)
        - [4.1.1. MP, MPI and X10 in a nutshell](#411-mp-mpi-and-x10-in-a-nutshell)
            - [4.1.1.1. MP model](#4111-mp-model)
            - [4.1.1.2. MPI model](#4112-mpi-model)
            - [4.1.1.3. X10 model](#4113-x10-model)
        - [4.1.2. X10 basics](#412-x10-basics)
            - [4.1.2.1. Keyword: async](#4121-keyword-async)
            - [4.1.2.2. Keyword: finish](#4122-keyword-finish)
            - [4.1.2.3. Keyword: when](#4123-keyword-when)
            - [4.1.2.4. Keyword: atomic](#4124-keyword-atomic)
            - [4.1.2.5. X10 Types](#4125-x10-types)
            - [4.1.2.6. X10 Print](#4126-x10-print)
            - [4.1.2.7. Cache performance influence](#4127-cache-performance-influence)
        - [4.1.3. Traditional analysis of parallel programs](#413-traditional-analysis-of-parallel-programs)
    - [4.2. Lect 8: More on x10, and project outline. The Dwarves. Concepts in advanced analysis: interconnection/network topologies, algorithmic dependence based on Dwarves.](#42-lect-8-more-on-x10-and-project-outline-the-dwarves-concepts-in-advanced-analysis-interconnectionnetwork-topologies-algorithmic-dependence-based-on-dwarves)
        - [4.2.1. Measuring runtime](#421-measuring-runtime)
        - [4.2.2. Pattern languages for parallel computing](#422-pattern-languages-for-parallel-computing)
            - [4.2.2.1. The Dwarfs of parallel HPC](#4221-the-dwarfs-of-parallel-hpc)
            - [4.2.2.2. Prefix sum (SCAN) and Cannon](#4222-prefix-sum-scan-and-cannon)
                - [4.2.2.2.1. Matrix-matrix multiplication: Cannon’s algorithm](#42221-matrix-matrix-multiplication-cannons-algorithm)
            - [4.2.2.3. FFT and stencils](#4223-fft-and-stencils)
                - [4.2.2.3.1. Stencils](#42231-stencils)
        - [4.2.3. Communications](#423-communications)
    - [4.3. Lect 9: Accuracy: guest lecture from John Gustafson.](#43-lect-9-accuracy-guest-lecture-from-john-gustafson)
    - [4.4. Lect 10: Detail on parallel approaches, with analysis: Monte Carlo, stencils, PDEs; analysis wrt underlying architectures.](#44-lect-10-detail-on-parallel-approaches-with-analysis-monte-carlo-stencils-pdes-analysis-wrt-underlying-architectures)
        - [4.4.1. Clarification on stencils, and laboratory 4 introduction](#441-clarification-on-stencils-and-laboratory-4-introduction)
            - [4.4.1.1. Stencil errors](#4411-stencil-errors)
            - [4.4.1.2. Non Von-Neumann Program model](#4412-non-von-neumann-program-model)
        - [4.4.2. Analytical modelling](#442-analytical-modelling)
        - [4.4.3. Example analytical modelling](#443-example-analytical-modelling)
            - [4.4.3.1. QuickSort](#4431-quicksort)
            - [4.4.3.2. Odd-even transposition bubble sort](#4432-odd-even-transposition-bubble-sort)
            - [4.4.3.3. Matrix-matrix multiplication](#4433-matrix-matrix-multiplication)
    - [4.5. Lect 11: Assistance with project.](#45-lect-11-assistance-with-project)
    - [4.6. Lect 12: Language extensions for parallel programming: e.g. map-reduce, locks, barriers, API extensions etc.](#46-lect-12-language-extensions-for-parallel-programming-eg-map-reduce-locks-barriers-api-extensions-etc)
        - [4.6.1. GPUs, and programming them](#461-gpus-and-programming-them)
            - [4.6.1.1. Flynn, GPUs](#4611-flynn-gpus)
            - [4.6.1.2. CUDA, OpenCL, webgl](#4612-cuda-opencl-webgl)
            - [4.6.1.3. X10-GPU, and WebGL-JavaScript programming](#4613-x10-gpu-and-webgl-javascript-programming)
                - [4.6.1.3.1. pure CUDA](#46131-pure-cuda)
                - [4.6.1.3.2. x10 CUDA](#46132-x10-cuda)
        - [4.6.2. Parallel algorithm Design](#462-parallel-algorithm-design)
            - [4.6.2.1. Overview - types of algorithms](#4621-overview---types-of-algorithms)
            - [4.6.2.2. Design: decomposition, TDG, granularity, TIG](#4622-design-decomposition-tdg-granularity-tig)
            - [4.6.2.3. Recursive and data decomposition](#4623-recursive-and-data-decomposition)
                - [4.6.2.3.1. Commonly used techniques for decomposing problems](#46231-commonly-used-techniques-for-decomposing-problems)
    - [4.7. Lect 13: The future, and exam coaching.](#47-lect-13-the-future-and-exam-coaching)
- [5. CUDA (for reference)](#5-cuda-for-reference)
- [6. MPI (for reference)](#6-mpi-for-reference)
- [7. UNUM (for reference)](#7-unum-for-reference)
- [8. Others (for reference)](#8-others-for-reference)autoauto<!-- /TOC -->

# 1. 拾遗

Flynn taxonomy

SISD
SIMD
MISD
MIMD

FFT

fixed-time speedup
fixed-size speedup (Amdahl)

Float add: return the same result : many reasons??!!
least error ? 

CSP parallel

deadlock free : judge: how to use process algebra laws?
nontermination deadlock free
assertions!!!

CSP model: a property to be checked

Spectral methods ??? 2017 1.6

MPI ??? scan ???

CSP MPI ???

semaphore

monitor???

1516 1.10: CSP shared events in MPI

Cannon's algorithm
Cartesian topologies

All the algorithms talked about in class (IMP) eg: even-odd bubble sort.

LTL expressions???

x10 time problems?

degree of parallelism?

computing grid/cluster?

CSP# / CSP

Skip() & Stop()

4D hypercube ???

file:///C:/Users/AW/Downloads/L4-2019csp-and-tutorial.pdf

TQ1

# 2. CSP# cheatsheet

## 2.1. CSP 

## 2.2. CSP#

## 2.3. CSP Examples

# 3. X10 cheatsheet

# 4. Parallel Programming

## 4.1. Lect 7: Introduction to x10.

Introduce basic analysis - systems based on the notion of parallel and serial fractions (Common with CS3210) - this will also include Gustafson’s law.

### 4.1.1. MP, MPI and X10 in a nutshell

#### 4.1.1.1. MP model
* MP threads run within a single multicore machine in one address space
* Lots of threads, shared memory in one multicore CPU

#### 4.1.1.2. MPI model

* MPI is a descendent of systems like PVM (Parallel Virtual Machine),and was never intended to be actually used by “humans”
* Lots of processes, no shared memory.
* MP and MPI are sometimes used together. Processes run in their own memory spaces.

#### 4.1.1.3. X10 model

* Places, which share a partitioned global memory
* Difference between x10 and MPI: A key differentiation point with MPI is it’s runtime architecture - it has a notion of a partitioned global address space.

### 4.1.2. X10 basics

#### 4.1.2.1. Keyword: async

* The `async` creates the effect of creating a new activity
* The activity will have access to the same variables as the calling thread.
* Note that async “creates the effect”, it does not “create a thread”.
* An x10 compiler may decide to inline an async call.  It will not do this if the assignments have side effects.

Tips: use `async` only for large data flows for speed up. Example: in quick sort, only async when array length > 10000. 

#### 4.1.2.2. Keyword: finish

Local activity

* The finish will not continue, until all activities in S have completed. `finish` acts like a synchronization barrier.

Example:

```scala
public static def qsort(data:Rail[int], l:long, r:long) {
    index:long = partition(data, l, r);
    finish {
        if (l < index - 1) async qsort(data, l, index - 1);
        if (index < r) qsort(data, index, r);
    }
}
```

#### 4.1.2.3. Keyword: when

* The when creates the effect of a conditional atomic operation.
* When c is True, the statement S is executed **atomically**

```java
when (true) S;
atomic S;
// it is the same
```

#### 4.1.2.4. Keyword: atomic

You know how to use it, right?

* Conditional atomic use is uncommon...
* But it is common to use the atomic keyword.


#### 4.1.2.5. X10 Types

```scala
Rail[Int]
Array[Int]
Array[Float]
```

* Rail: provides a simple, fast implementation of indexed storage that can be used as the foundation of other array types. 
* Array: provides densely indexed, rectangular, multi-dimensional arrays, in one place. DistArray is in multiple places.
* Region: supports a set of k-dimensional points: R && S is the intersection of R and S, all points which are in both R and S. Region.make(1..10)&&Region.make(3..20) is the region of rank 1 containing the points 3..10. 
* R * S is the cartesian product of R and S. Region.make(1..2)*Region.make(3..4) is the region of rank 2 containing the four points with coordinates [1,3], [1,4], [2,3], [2,4].

constrained types: constraints c are a limited predicate involving == and !=.

```scala
Matrix[Int]{self.I==self.J}
```

#### 4.1.2.6. X10 Print

```java
Console.OUT.println("Hello, World");
```

#### 4.1.2.7. Cache performance influence

Row and column order.
Problem size.

### 4.1.3. Traditional analysis of parallel programs 

Speedup: Definition

$$\frac{Time(single\ processor)}{Time(multi\ thread)}$$

* Amdahl speedup := serial time (constant) / parallel time
* Gustafson speedup := serial time / parallel time (constant)


## 4.2. Lect 8: More on x10, and project outline. The Dwarves. Concepts in advanced analysis: interconnection/network topologies, algorithmic dependence based on Dwarves.

### 4.2.1. Measuring runtime

<!-- `time` command not reliable -->

Timer in x10:

```java
import x10.util.Timer;
...
val start = x10.util.Timer.nanoTime();
...
val stop = x10.util.Timer.nanoTime();;
Console.OUT.printf("%1.3f seconds.\n", ((stop-start) as double)/1e9);

```

### 4.2.2. Pattern languages for parallel computing

#### 4.2.2.1. The Dwarfs of parallel HPC

* A dwarf is an algorithmic method, which captures a pattern of communication and computation.
* To belong to one of the HPC dwarfs, a parallel application must exhibit similar patterns of communication and computation to one of the (7/13) dwarfs.

Name|Content|Problem|Solution
-|-|-|-
Dense Linear Algebra|Patterns of parallel algorithmic solutions.(Nearby node communication)|Solving large systems of linear equations..|Distribute data
Spectral methods|Patterns of parallel algorithmic solutions.(All to all communication)|Wave simulation. Use FFT in a different domain.|Butterfly networks,
all-to-all distribution.
Structured grid|Patterns of parallel algorithmic solutions. (Specific node communication)| Weather simulation. Use 2D/3D space.|Nodes compute local area, communicate with
nearby ones. The use of stencils is common.

* FFT Transpose operation results in all-to-all communication
* Butterfly Network: This is one of the most complex connections of the nodes. There are nodes which are connected and arranged in terms of their ranks. They are arranged in the form of a matrix. See: https://en.wikipedia.org/wiki/Butterfly_network#Components and https://en.wikipedia.org/wiki/Multistage_interconnection_networks .

#### 4.2.2.2. Prefix sum (SCAN) and Cannon

Prefix sum or “Scan”

scan: see lect8.pdf p14

built-in scan in x10:
```scala
static val sum = (f1:int, f2:int) => f1 + f2;
public static def main(args:Rail[String]) {
...
val r = new x10.util.Random();
val data = new Rail[int](N, (long)=>r.nextInt(9999n));
val dataout = new Rail[int](N);
...
display( data,x10.lang.Int.operator_as(N) );
val start = x10.util.Timer.nanoTime();
x10.util.RailUtils.scan( data, dataout, sum, 0n );
val stop = x10.util.Timer.nanoTime();
display( dataout,x10.lang.Int.operator_as(N) );
...
Console.OUT.printf("Time is %15.0f nS.\n", ((stop-start) as double));
```

parallel version scan in x10:
```scala
public static def parmyscan(din:Rail[Int], dout:Rail[Int], l:Int, r:Int) {
    var mid:Int = l+((r+1n-l)/2n)-1n;
    var mid1:Int = mid+1n;
    if ( (r-l)>1 ) {
        finish {
            async parmyscan(din,dout,l,mid);
            parmyscan(din,dout,mid1,r );
        }
    for (i in mid1..r) {
        if (mid !=0n) { dout(i) += dout(mid); }
    }
    } else {
        dout(l) = din(l);
        dout(r) = din(l)+din(r);
    }
}
```

TODO: places in x10

##### 4.2.2.2.1. Matrix-matrix multiplication: Cannon’s algorithm

TODO Complexity on the Slides.

CANNON's Algorithm

> 著名的Cannnon算法使用一个由s2个处理器组成的二维网孔结构（mesh），而且这个mesh还是周边带环绕的（The processors are connected as a torus）。处理器Processor (i,j) （我们用它来表示位于位置(i,j)处的处理器）最开始时存有子矩阵Ai,j和Bi,j。随着算法的进行，这些子矩阵会向左或向上位移.

> 这个算法的根本出发点是在处理器阵列中，要合理分布两个待乘的矩阵元素。由乘积公式可知，要在处理单元 P(i,j)中计算乘积元素C(i,j)，必须在该单元中准备好矩阵元素A(i,s)和B(s,j)。但是如果我们像下图那样分布矩阵元素，我们在计算C(i,j)时所需的元素显然是不足够的，但是可以通过向上循环位移B的元素，并向左循环位移A的元素，来获取合适的成对的矩阵元素。

#### 4.2.2.3. FFT and stencils

DFT/FFT communication

At each of the log N stages of computation, each processor would
have to share one element.

communication medium|complexity
-|-
On shared bus|(ts + te) × N log N, an O(N log N)
On an N-D hypercube| (ts + te) × log N

> On an N-D hypercube, this would mean that each communication is on a different axis and can happen simultaneously

##### 4.2.2.3.1. Stencils

A set of points for numerical approximation used in Taylor's Formula

Taylor's Formula, for reference:

$$f(x)=f(a)+{\frac  {f'(a)}{1!}}(x-a)+{\frac  {f^{{(2)}}(a)}{2!}}(x-a)^{2}+\cdots +{\frac  {f^{{(n)}}(a)}{n!}}(x-a)^{n}+R_{n}(x).$$


### 4.2.3. Communications

For connectivity between CPUs, or CPUs with memory
* Static, or direct: networks have direct links between nodes.
* Dynamic, or indirect: networks have multiple paths between nodes(Switches re−route as needed)

Networks: for pic, see slides

* Bus systems
* Simple switching networks
* Multistage networks
* Completely connected (hard to implement) and star networks
* 1D, 2D, 3D mesh, with and without wraparound
* Hypercubes :... 4D Hypercube (Tesseract)
* Tree networks, fat trees:  bottleneck -> root
* IBM Blue Gene/Q : Interconnection network - a 5D cubic torus

> Multistage interconnection networks (MINs) are a class of high-speed computer networks usually composed of processing elements (PEs) on one end of the network and memory elements (MEs) on the other end, connected by switching elements (SEs). The switching elements themselves are usually connected to each other in stages, hence the name.

## 4.3. Lect 9: Accuracy: guest lecture from John Gustafson.

* UNUM
* GNU GMP

## 4.4. Lect 10: Detail on parallel approaches, with analysis: Monte Carlo, stencils, PDEs; analysis wrt underlying architectures.

### 4.4.1. Clarification on stencils, and laboratory 4 introduction 

#### 4.4.1.1. Stencil errors

We can use stencils in any number of dimensions. For 1D, we might have a
stencil to approximate the derivative of a function f(x), here comes the error. The error can be represented in form of $O(h^2)$.

#### 4.4.1.2. Non Von-Neumann Program model

* Functional programming language
* Integration and differentiation analog circuits
* NFA and DFA
* Automatons in Micron’s processor

### 4.4.2. Analytical modelling

Analytical modelling with communication

communication (broadcast) topology structure
* ring 
* mesh
* hypercube
* tree

### 4.4.3. Example analytical modelling

注意: 渐进分析时要考虑到建立时间/传输时间的大小问题. 若两者相差悬殊则可以藉此设计更好的算法.


<!-- Sort examples ... Quick sort, bubble sort, and oddEven Matrix multiplication -->

#### 4.4.3.1. QuickSort 

#### 4.4.3.2. Odd-even transposition bubble sort

See slides

* After n phases of odd-even exchanges, the sequence is sorted. Each phase of the algorithm requires Θ(n) comparisons. Serial complexity is Θ(n2).

* For a one-item-per-processor case, each processor does one compare-exchange. The parallel run time of this formulation is Θ(n). (If there is no communication cost)

<!-- async for ??? TODO DONE -->

<!-- examples on slides: difference? -->

Complexity TODO ???

#### 4.4.3.3. Matrix-matrix multiplication

TODO

## 4.5. Lect 11: Assistance with project.

Nothing, really nothing~

## 4.6. Lect 12: Language extensions for parallel programming: e.g. map-reduce, locks, barriers, API extensions etc. 

### 4.6.1. GPUs, and programming them
#### 4.6.1.1. Flynn, GPUs

Flynn’s taxonomy

1. Single Instruction, Single Data stream (SISD) Sequential computer with no parallelism in either the instruction or data streams. (Traditional)
1. Single Instruction, Multiple Data streams (SIMD) Computer with multiple data streams against a single instruction stream (GPU).
1. Multiple Instruction, Single Data stream (MISD) Multiple instructions over single data stream. (Fault tolerance)
1. Multiple Instruction, Multiple Data streams (MIMD) Multiple processors executing different instructions on different data. (Top500) Plus variants: SPMD (Single Program Multiple data), SIMT (Single instruction, multiple threads)...

*GPUs challenge Flynn’s taxonomy

#### 4.6.1.2. CUDA, OpenCL, webgl

* CUDA, NVIDIA’s Common Unified Device Architecture. (on NVIDIA GPU chips)
* OpenCL is Open Computing Language framework. (GPUs, DSPs, FPGAs and so on.)
* WebGL provides an interface between JavaScript and (GPU) hardware.

Peculiar limits:

Language is typically a recursion-free, function-pointer-free language.

#### 4.6.1.3. X10-GPU, and WebGL-JavaScript programming

Take matrix mul for instance.

##### 4.6.1.3.1. pure CUDA

```cpp
// Matrix multiplication on the GPU: P = M * N. w is the width
__global__ void matMul( float* P, float* M, float* N, int w) {
int bx = blockIdx.x; int by = blockIdx.y;
int tx = threadIdx.x; int ty = threadIdx.y;
int i = by * blockDim.y + ty;
int j = bx * blockDim.x + tx;
float acc = 0.0;
for(int k=0; k<w; k++){
acc = acc + M[ i * w + k ] * N[ k * w + j ];
}
P[ i * w + j ] = acc;
}

threads = dim3(BLOCK_SIZE, BLOCK_SIZE);
grid = dim3(WC / threads.x, HC / threads.y);
cudaMemcpy(d_M, h_M, mem_size_M,cudaMemcpyHostToDevice);
cudaMemcpy(d_N, h_N, mem_size_N, cudaMemcpyHostToDevice);
matMul_<<< grid, threads >>>(d_P, d_M, d_N, N);
cudaMemcpy(h_P, d_P, mem_size_P, cudaMemcpyDeviceToHost);
```

##### 4.6.1.3.2. x10 CUDA

```java
// Matrix multiplication on the GPU: P = M * N. w is width
static def matMul (gpu:Place,
P:GlobalRail[Float]{home==gpu},
M:GlobalRail[Float]{home==gpu},
N:GlobalRail[Float]{home==gpu}, w:Int) {
finish async at (gpu) @CUDA {
finish for (i in 0n..(w-1n)) async {
clocked finish for (j in 0n..(w-1n)) clocked async {
var acc:Float = 0.0f;
for ( k in 0..(w-1n)) {
acc = acc+ M(i*w+k) * N(k*w+j);
}
P(i*w+j) = acc;
}
}
}

//Only the inner for loop runs on the GPU. The mainline is:
val dM = CUDAUtilities.makeGlobalRail[Float](gpu, N*N);
val M = new Rail[Float](N*N);
finish {
Rail.asyncCopy(M, 0, dM, 0, N*N);
...
}
matMul(gpu, dP, dM, dN, N as Int);
```

GPU.js

gpu.createKernel creates a kernel function which runs on a GPU. Note that part of a GPU.js program runs on the CPU and should be (say) IA32/X86 code, and part runs on GPU, and uses WebGL/OpenGL to compile to the code for the GPU.

### 4.6.2. Parallel algorithm Design

#### 4.6.2.1. Overview - types of algorithms

Taxonomy:
* Pipeline/producer-consumer
* Supervisor-worker/master-slave
* Data parallel
* Task graph
* Work Pool
* Hybrids
* ...

* Pipeline/Producer-consumer - “Stream parallelism”
* Supervisor-worker/master-slave (master allocate the work, slaves do the work)
* Data parallel - Performing identical, or near identical calculations on multiple elements:

#### 4.6.2.2. Design: decomposition, TDG, granularity, TIG

* Decompose the problem into tasks that can be executed concurrently
* A decomposition can be illustrated in the form of a directed graph with nodes corresponding to tasks and edges indicating that the result of one task is required for processing the next. Such a graph is called a **task dependency graph**.
* **Maximum degree of concurrency** is the maximum number of such tasks at any point during execution
* **critical path length**.

#### 4.6.2.3. Recursive and data decomposition

task interaction graph  TODO

##### 4.6.2.3.1. Commonly used techniques for decomposing problems

1. recursive decomposition
2. data decomposition (input, output, inout)
3. exploratory decomposition ?
4. speculative decomposition ?


<!-- Examples taken from: - MIMD/MPI/MP - PGAS/X10 - SIMD/GPU. -->

## 4.7. Lect 13: The future, and exam coaching.



# 5. CUDA (for reference)


Type|Mode|Syntax|Scope|Speed
-|-|-|-|-
Register|RW|int x; |thread|Fastest
Local|RW|int x[10]; |thread |Very fast
Shared|RW|__shared__ int x;|block|Fast
Global|RW|__global__ int x; |grid|Slow
Constant|R|__constant__ int x;|grid Slow
Texture|R|__texture__ int x;|grid Slow

* threadIdx是一个uint3类型，表示一个线程的索引。
* blockIdx是一个uint3类型，表示一个线程块的索引，一个线程块中通常有多个线程。
* blockDim是一个dim3类型，表示线程块的大小。
* gridDim是一个dim3类型，表示网格的大小，一个网格中通常有多个线程块。

# 6. MPI (for reference)

MPI_Init
MPI_Comm_rank
MPI_Comm_size
MPI_Bcast
MPI_Isend
MPI_Send
MPI_Irecv
MPI_Waitall
MPI_Allreduce
MPI_Finalize

# 7. UNUM (for reference)

# 8. Others (for reference)

* Cluster Computing: Tightly coupled systems Single system image Centralized Job management & scheduling system
* Grid Computing: Loosely coupled (Decentralization) Diversity and Dynamism Distributed Job Management & scheduling

Differnece between the Cluster computing and Grid computing:

> The big difference is that a cluster is homogenous while grids are heterogeneous. The computers that are part of a grid can run different operating systems and have different hardware whereas the cluster computers all have the same hardware and OS.

> A grid can make use of spare computing power on a desktop computer while the machines in a cluster are dedicated to work as a single unit and nothing else.

