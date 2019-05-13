# MIPS and MFLOPS

Copyright (C) 2019 Wang Huaqiang

---

## Usage:

```
g++ -S mips.cc
g++ -S mflops.cc
g++ mips.cc -o mips.exe
g++ mflops.cc -o mflops.exe
./mips
./mflops
```

## Result:

```
PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\1> cd "f:\workpath\Notes\OperationSystem\lab\share\vmshare\1\" ; if ($?) { g++ -std=c++11 mips.cc -o mips -lpthread } ; if ($?) { .\mips }

start:1 end:16864 CLOCKS_PER_SEC:1000
ips:3.85459e+009

PS F:\workpath\Notes\OperationSystem\lab\share\vmshare\1> g++ -S .\mflops.ccPS F:\workpath\Notes\OperationSystem\lab\share\vmshare\1> cd "f:\workpath\Notes\OperationSystem\lab\share\vmshare\1\" ; if ($?) { g++ -std=c++11 mflops.cc -o mflops -lpthread } ; if ($?) { .\mflops }

start:0 end:41399 CLOCKS_PER_SEC:1000
ips:1.57009e+009
```

注意: flops的值需要使用`mips.cc`与`flops.cc`的结果进行换算之后求得. 原因是浮点指令在`flops.cc`的循环主体中占$\frac{4}{13}$.