# STREAM

Copyright (C) 2019 Wang Huaqiang

---

## Usage:

```bat
REM Run in windows 10 env

gcc stream.c -o stream 
.\stream
gcc -O -fopenmp stream.c -o stream
.\stream
REM <!-- gcc -O -fopenmp -DSTREAM_ARRAY_SIZE=100000000 -DNTIME=20 stream.c -o stream -->

gcc stream_float.c -o stream_float 
.\stream_float
gcc stream_float.c -O -fopenmp -o stream_float 
.\stream_float
```

## 直接运行测试程序

### 单核直接运行测试程序

```
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\4> cd "f:\workpath\Notes\OperationSystem\lab\share\vmshare\2\" ; if ($?) { gcc stream.c -o stream } ; if ($?) { .\stream }
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 944 microseconds.
Each test below will take on the order of 27298 microseconds.
   (= 28 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            6305.2     0.026458     0.025376     0.027350
Scale:           7126.3     0.024073     0.022452     0.029311
Add:             9469.7     0.026355     0.025344     0.027328
Triad:           8773.5     0.028630     0.027355     0.030226
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-013 on all three arrays
-------------------------------------------------------------
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2>
```

### 多核运行测试程序

```
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2> gcc -O -fopenmp stream.c -o stream
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2> .\stream
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 8
Number of Threads counted = 8
-------------------------------------------------------------
Your clock granularity/precision appears to be 945 microseconds.
Each test below will take on the order of 7807 microseconds.
   (= 8 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           18223.3     0.009655     0.008780     0.010734
Scale:          18221.4     0.009757     0.008781     0.012687
Add:            20495.5     0.012687     0.011710     0.014641
Triad:          20493.6     0.012905     0.011711     0.013667
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-013 on all three arrays
-------------------------------------------------------------
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2>
```

## 使用单精度带宽

### 单核单精度带宽

```
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2> cd "f:\workpath\Notes\OperationSystem\lab\share\vmshare\2\" ; if ($?) { gcc stream_float.c -o stream_float } ; if ($?) { .\stream_float }
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 4 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 38.1 MiB (= 0.0 GiB).
Total memory required = 114.4 MiB (= 0.1 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 948 microseconds.
Each test below will take on the order of 27300 microseconds.
   (= 28 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            3278.9     0.026242     0.024398     0.034141
Scale:           3726.0     0.022668     0.021471     0.023454
Add:             4917.8     0.026347     0.024401     0.027333
Triad:           4553.9     0.028416     0.026351     0.031252
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-006 on all three arrays
-------------------------------------------------------------
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2>
```

### 多核单精度带宽

```
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2> cd "f:\workpath\Notes\OperationSystem\lab\share\vmshare\2\" ; if ($?) { gcc stream_float.c -O -fopenmp -o stream_float } ; if ($?) { .\stream_float }
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 4 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 38.1 MiB (= 0.0 GiB).
Total memory required = 114.4 MiB (= 0.1 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 8
Number of Threads counted = 8
-------------------------------------------------------------
Your clock granularity/precision appears to be 941 microseconds.
Each test below will take on the order of 3923 microseconds.
   (= 4 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           20497.5     0.004667     0.003903     0.004920
Scale:          20481.6     0.004985     0.003906     0.005857
Add:            20498.6     0.006184     0.005854     0.006833
Triad:          20499.1     0.006398     0.005854     0.006848
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-006 on all three arrays
-------------------------------------------------------------
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\2>
```