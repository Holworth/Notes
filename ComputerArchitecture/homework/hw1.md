# 计算机体系结构

## 作业一

* 王华强
* 2016K8009929035

***

## 1. 计算机系统的层次划分

主要的4个层次如下:

由上至下依次是: 应用软件-->操作系统-->硬件系统-->晶体管级硬件结构

各个层次之间的界面分别是: 应用程序接口API, 指令集架构ISA, 各种硬件工艺模型

划分层次的意义在于上层的层次屏蔽了下面层次的实现细节, 提供了利用下层结构实现功能的通用抽象. 其结果就是: 上层结构的开发者可以不用了解下层所有的实现细节, 专注地做好当前层的开发. 同时, 通过屏蔽实现细节, 上层的设计可以在层次之间界面相同(譬如相同的API,ISA)的情况下便捷的移植到其他平台, 提高了设计的可复用性.

## 2. 计算机性能比较

MIPS分别为10, 20, 30

三台计算机的性能相同, 因为运行相同的程序所用的时间相同.

## 3. 计算计算机的性能提升

提升率为:

$$(1-p+\frac{p}{s})^{-1}-1$$

## 4. 处理器功耗估计

$$4.499W$$

为了得出这个结果需要引入假设: 处理器的静态功耗电阻不变.

计算所用的中间数据如下:

时钟频率(GHz)|U(V)|I(A)|静态功率(W)|动态功率(W)
-|-|-|-|-
0|1|0.1|0.1|-
1|1.1|2.1|0.121|2.189
2|1.1|-|0.121|4.378

## 5. SPEC2000测试报告

### 测试环境

硬件信息:

* Intel® Core™ i7-6700HQ Processor
* 16GB RAM

* Windows10 家庭中文版. Build 17713.
* Windows Subsystem of Linux(WSL). Ubuntu 18.04 LTS. Based on Windows10 家庭中文版. Build 17713.

不同测试时编译选项的不同结果如下:

### -O2 -march=core2  -static  

```
Fri Sep 14 01:07:29 DST 2018
[CPU]:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
[Memory]:
       16664352 kB
[Linux]:
Linux AW-OMEN 4.4.0-17713-Microsoft #1000-Microsoft Fri Jul 06 15:51:00 PST 2018 x86_64 x86_64 x86_64 GNU/Linux
[MAC]:
[Compiler]:
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
g++ (Ubuntu 7.3.0-16ubuntu3) 7.3.0
GNU Fortran (Ubuntu 7.3.0-16ubuntu3) 7.3.0
[Result]:
 Success 164.gzip ratio=1691.21, runtime=82.781208
 Success 175.vpr ratio=2441.03, runtime=57.352890
 Success 176.gcc ratio=3964.55, runtime=27.745870
 Success 181.mcf ratio=2850.26, runtime=63.152125
 Success 186.crafty ratio=3278.06, runtime=30.505851
 Success 197.parser ratio=1975.73, runtime=91.105657
 Success 252.eon ratio=4082.46, runtime=31.843519
 Success 254.gap ratio=2856.06, runtime=38.514609
 Success 255.vortex ratio=3941.17, runtime=48.208997
 Success 256.bzip2 ratio=2304.04, runtime=65.103172
 Success 300.twolf ratio=3241.93, runtime=92.537510
 Success 168.wupwise ratio=4231.35, runtime=37.812959
 Success 171.swim ratio=6415.87, runtime=48.317720
 Success 172.mgrid ratio=2742.22, runtime=65.640205
 Success 173.applu ratio=4733.50, runtime=44.364659
 Success 177.mesa ratio=3871.79, runtime=36.158989
 Success 178.galgel ratio=8812.72, runtime=32.906987
 Success 179.art ratio=10723.32, runtime=24.246213
 Success 183.equake ratio=6272.50, runtime=20.725374
 Success 187.facerec ratio=4676.74, runtime=40.626604
 Success 188.ammp ratio=3344.62, runtime=65.777290
 Success 189.lucas ratio=6952.75, runtime=28.765599
 Success 191.fma3d ratio=4404.40, runtime=47.679597
 Success 200.sixtrack ratio=1446.07, runtime=76.068070
 Success 301.apsi ratio=4462.35, runtime=58.265291

```

### -O0 -march=core2  -static  

```
Fri Sep 14 10:53:16 DST 2018
[CPU]:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
[Memory]:
       16664352 kB
[Linux]:
Linux AW-OMEN 4.4.0-17713-Microsoft #1000-Microsoft Fri Jul 06 15:51:00 PST 2018 x86_64 x86_64 x86_64 GNU/Linux
[MAC]:
[Compiler]:
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
g++ (Ubuntu 7.3.0-16ubuntu3) 7.3.0
GNU Fortran (Ubuntu 7.3.0-16ubuntu3) 7.3.0
[Result]:
 Success 164.gzip ratio=1045.06, runtime=133.963958
 Success 175.vpr ratio=1361.72, runtime=102.811119
 Success 181.mcf ratio=2296.53, runtime=78.379040
 Success 186.crafty ratio=2270.86, runtime=44.036252
 Success 197.parser ratio=1122.67, runtime=160.332063
 Success 252.eon ratio=542.50, runtime=239.631858
 Success 253.perlbmk ratio=2259.07, runtime=79.678869
 Success 254.gap ratio=2948.29, runtime=37.309799
 Success 255.vortex ratio=2197.26, runtime=86.471334
 Success 256.bzip2 ratio=1133.67, runtime=132.314152
 Success 300.twolf ratio=1893.03, runtime=158.476115
 Success 168.wupwise ratio=1451.02, runtime=110.267490
 Success 171.swim ratio=1798.30, runtime=172.385132
 Success 172.mgrid ratio=473.16, runtime=380.423671
 Success 173.applu ratio=724.90, runtime=289.696607
 Success 177.mesa ratio=1971.47, runtime=71.013009
 Success 178.galgel ratio=1690.27, runtime=171.569940
 Success 179.art ratio=4619.88, runtime=56.278498
 Success 183.equake ratio=1986.84, runtime=65.430400
 Success 187.facerec ratio=2260.09, runtime=84.067470
 Success 188.ammp ratio=1369.24, runtime=160.672970
 Success 189.lucas ratio=2888.32, runtime=69.244415
 Success 191.fma3d ratio=1735.07, runtime=121.032780
 Success 200.sixtrack ratio=370.79, runtime=296.660064
 Success 301.apsi ratio=1197.46, runtime=217.125451
```


### -O3 -march=corei7 -static  

```
Fri Sep 14 01:07:54 DST 2018
[CPU]:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
[Memory]:
       16664352 kB
[Linux]:
Linux AW-OMEN 4.4.0-17713-Microsoft #1000-Microsoft Fri Jul 06 15:51:00 PST 2018 x86_64 x86_64 x86_64 GNU/Linux
[MAC]:
[Compiler]:
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
g++ (Ubuntu 7.3.0-16ubuntu3) 7.3.0
GNU Fortran (Ubuntu 7.3.0-16ubuntu3) 7.3.0
[Result]:
 Success 164.gzip ratio=1583.86, runtime=88.391888
 Success 175.vpr ratio=2166.44, runtime=64.622130
 Success 176.gcc ratio=3612.09, runtime=30.453324
 Success 181.mcf ratio=2516.20, runtime=71.536313
 Success 186.crafty ratio=2767.68, runtime=36.131325
 Success 197.parser ratio=1806.65, runtime=99.631884
 Success 252.eon ratio=4366.55, runtime=29.771796
 Success 254.gap ratio=2572.32, runtime=42.762998
 Success 255.vortex ratio=3303.33, runtime=57.517734
 Success 256.bzip2 ratio=2182.25, runtime=68.736460
 Success 300.twolf ratio=2612.74, runtime=114.821908
 Success 168.wupwise ratio=3325.75, runtime=48.109402
 Success 171.swim ratio=5514.74, runtime=56.212990
 Success 172.mgrid ratio=3160.85, runtime=56.946628
 Success 173.applu ratio=4925.62, runtime=42.634226
 Success 177.mesa ratio=3736.05, runtime=37.472712
 Success 178.galgel ratio=9880.41, runtime=29.350994
 Success 179.art ratio=9125.48, runtime=28.491659
 Success 183.equake ratio=7118.95, runtime=18.261110
 Success 187.facerec ratio=4887.25, runtime=38.876669
 Success 188.ammp ratio=3189.30, runtime=68.980720
 Success 189.lucas ratio=6658.33, runtime=30.037562
 Success 191.fma3d ratio=4203.97, runtime=49.952754
 Success 200.sixtrack ratio=1635.48, runtime=67.258676
 Success 301.apsi ratio=4967.97, runtime=52.335275

```


## 6. 浏览器JavaScript性能测试

平台|OS|浏览器|得分
-|-|-|-
PC(i7)|Windows10 build 17713|Chrome	68|17896
Mi8(骁龙835)|Android8.0.0|Chrome 66|11016
Mi8(骁龙835)|Android8.0.0|Tencent Tim 内置浏览器|9772
Mi8(骁龙835)|Android8.0.0|内置浏览器|5861
华为手机(型号不详)|-|系统默认浏览器|9422
iPhone6s(A9)|iOS(版本号未知)|Safari|15233

发现:

1. 计算平台的硬件性能对JavaScript性能有基础性的影响
1. 不同浏览器JavaScript性能差距很大
1. 系统性能是由软件和硬件共同决定的.