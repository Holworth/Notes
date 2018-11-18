# 算法作业3

* 王华强
* 2016K8009929035

***

## Problem 1

### 伪代码

<!-- ?????????? -->

<!-- 直接计算总数不行吗?好像不行. -->

```c
degree_array[n];
sort(degree_array);//对degree_array进行排序, 排序顺序为由大到小;
while(i=1;i<=n;i++)
{
    int t=i;
    while(degree_array[i]>0)
    {
        degree_array[i]--;
        t++;
        if(t>n)return failed;
        degree_array[t]--;
        if(degree_array[t]<0)return failed;
    }
}
if(degree_array[n]==0)return succeed;
```

### 最优子结构和贪心选择属性

最优子结构:

贪心选择属性:

### 正确性证明



### 复杂度分析

$$O(nlogn)+\sum^n_{i=1}d_i$$

其中:

排序花费$O(nlogn)$

做减法花费$\sum^n_{i=1}d_i$

***


## Problem 2

### 伪代码

```c
//将在超算上和PC上进行计算的时间求和: 一个任务的最早结束时间.
//将所有任务在超算上用时求和, +一个任务在PC上运行时间: 一个任务的最晚结束时间.
//目的是使得所有任务中最大的最晚结束时间最小.

pc_time[n];
sup_time[n];
sort(pc_time);//由大到小排序
按此顺序执行即可;

```

### 最优子结构和贪心选择属性

最优子结构:

贪心选择属性:

### 正确性证明

下证明将pc上执行时间最小的任务放到最后执行是最好的选择.

设所有任务在超算上的执行时间为sum_stime;

假设pc_time是已经完成排序的数组;

将pc上执行时间最小的任务放到最后执行需要的时间小于等于将其他任务放在最后执行的时间:

将pc上执行时间最小的任务放到最后执行需要的时间:

```
任务的最终完成时间=max(
    sum_stime+pc_time[n],
    sum_stime+pc_time[n-1]-sup_time[n],
    sum_stime+pc_time[n-2]-sup_time[n]-sup_time[n-1],
    ......
    );
```

交换最后一个元素和其他的元素: 例如交换n和(n-1)的执行顺序:

```
任务的最终完成时间=max(
    sum_stime+pc_time[n-1],
    sum_stime+pc_time[n]-sup_time[n-1],
    sum_stime+pc_time[n-2]-sup_time[n]-sup_time[n-1],
    ......
    );
```

显然sum_stime+pc_time[n-1]>sum_stime+pc_time[n-1]-sup_time[n];

显然sum_stime+pc_time[n-1]>sum_stime+pc_time[n];

于是交换后的最终完成时间大于交换前的, 因此只有将pc_time最小的放在后面才能取得最小值.

同理可证倒数第二, 第三位...

因此需要按照在PC上运行时间递减的顺序运行.

## 复杂度分

排序花费$O(nlogn)$

***


## Problem 3

### 伪代码

```c
string t;
string s;
//设字符串下标从1开始
int b=1;
for(int a=1;a<=len(t);)
{
    if(t[a]==s[b])//march
    {
        a++;
        b++;
    }else 
    {
        a++;//比较下一个a;
    }
    if(b==(len(s)+1))return true;
}
return false;
```

### 最优子结构和贪心选择属性

贪心子问题: 

字符串s的前i个字符是字符串t的子串.

贪心选择属性:

若字符串s是字符串t的子串, 则字符串s的前i个字符是字符串t的子串(i可以任意取值). 且字符串s的前i+1个字符可以在前i个字符的匹配之后继续匹配.

### 正确性证明

我们考虑以下的两个字符串;

```
t:=faaoobbacr
s:=abc
```

要判断subsequence, 只要从头开始对照两个字符串. 如果

```
t:=faaoobbacr
s:=--a---b-c-
```

如图: 一个字母出现了多次且靠后者可以完成按次序配对, 则靠前的字母也可以:

```
t:=faaoobbacr
s:=-a---b--c-
```

取靠前的字母之后, 只要考虑:

```
t:=--aoobbacr
s:=--bc
```

的匹配.

因此, 如果则串s是t的subsequence, 则上述算法必定可以完成匹配.

同时, 显然地, 如果依照上述的算法无法匹配, 则串s不可能是t的subsequence;

因此, 只要贪心地在相同字母首次出现时进行匹配即可.

### 复杂度分析

$$O(len(t))$$

(只要遍历扫描一遍字符串t即可)

***


## Problem 4 (基本思路)

### 伪代码

```c
array_a[n];
array_b[n];
sort(a);
sort(b);
按顺序输出结果;
```

### 最优子结构和贪心选择属性

最优子结构:

贪心选择属性:

### 正确性证明
<!-- 
引理: 

```
对于a>b>0, c>d>0, 有: a^c+b^d>=a^d+b^c.
证明: 
a^c+b^d>=a^d+b^c
a^c+b^d-a^d+b^c>=0
(a^(c-d)+1)*(a^d)+b^d*(1-b^(c-d))>=0
``` 
-->

### 复杂度分析

排序花费$O(nlogn)$