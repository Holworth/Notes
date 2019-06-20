# 算法作业2

* 王华强
* 2016K8009929035

***

## Problem 1

先考虑各个节点排列在一条直线上的情况.

### DP最优子结构和状态转移方程

DP最优子结构`best[n]`: 只抢前n个房子能抢到的最大钱数.

状态转移方程: 

$$best[n]=max(best[n-1], best[n-2]+val[n])$$

<!-- ### 算法描述 -->

### 伪代码

```c
//房子编号从1开始, 共有n个房子.
val[n+1];//从各个房子里能抢到的钱
best[n+1];//只抢前n个房子能抢到的最大钱数
best[0]=0;//一个房子都不抢
best[1]=val[1];//只抢第一个房子
for(int i=2;i<=n;i++)
{
    best[i]=max(best[i-1], best[i-2]+val[i]);
}
return best[n];
```

### 正确性证明

对于只有0,1个房子的情况显然成立.

用数学归纳法证明. 设`best[i]`为只抢前i个房子能抢到的最大钱数. 对于第n个房子, 可以选择抢或者不抢. 如果抢第n个就不能抢第n-1个, 因此能抢收到的最大钱数为best[i-2]+val[i]. 如果不抢第n个房子则能抢到的钱数为best[i-1]. 因此状态转移方程成立.


### 复杂度分析

每次循环只需要计算`best[i]=max(best[i-1], best[i-2]+val[i])`, 复杂度为常数级. 因此整体复杂度为:

$$O(n)$$

### 环型路的情况

只考虑房子数超过2个的情况. 

在环路中任意挑选出两个连续的房子记为1,2, 余下房子依次编号. 设房子的总数为n.

分别计算以下几种情况的最大收入值:

1. 两个房子都不抢, 再用之前的算法计算出房子3-房子n的直线最优值.
1. 抢房子1, 再用之前的算法计算出房子3-房子n-1的直线最优值.
1. 抢房子2, 再用之前的算法计算出房子4-房子n的直线最优值.

三种情况中的最大值即为所求. 复杂度仍为`O(n)`


## Problem 2

定义数据结构如下: 

将二叉树的根结点编号为1, bintree[1]代表二叉树的根节点的值. 对于二叉树的一个节点i, 其左节点为2i, 右节点为(2i+1). (ie: 二叉树数组)

设二叉树节点数为n.

如果i>n, best[i]=0;

### DP最优子结构和状态转移方程

DP最优子结构`best[n]`: 节点n为根节点的子树中能取得的最大值.

状态转移方程: 

```c
best[n]=max(
    best[2n]+best[2n+1],//不选取根节点, 直接求两子树的和
    best[4n]+best[4n+1]+best[4n+2]+best[4n+3]+bintree[n]//选取根节点, 则根节点的两个子节点不可以被选择
    );
```

<!-- ### 算法描述 -->

### 伪代码

```c
bintree[n+1];//各个节点的值
best[4*(n+1)];//节点n为根节点的子树中能取得的最大值
for(int i=0; i<4*(n+1); i++)
{
    best[i]=0;
}
for(int i=n;i>=0;i--)
{
best[i]=max(
    best[2i]+best[2i+1],//不选取根节点, 直接求两子树的和
    best[2i]+best[4i+1]+best[4i+2]+best[4i+3]+bintree[i]//选取根节点, 则根节点的两个子节点不可以被选择
    );
}
return best[1];
```

### 正确性证明

从叶子节点开始计算, 算法对于叶子节点显然成立.

用数学归纳法证明. 设`best[i]`为节点i为根节点的子树中能取得的最大值. 在一个节点下的所有子树的最优解都被求出的情况下, 以这个节点为根节点的子树的最优解必然是上述的两种情况之一. 因此状态转移方程成立.

### 复杂度分析

每次循环状态转移函数计算复杂度为常数级. 主体循环执行了n次 因此整体复杂度为:

$$O(n)$$

## Problem 3

### DP最优子结构和状态转移方程

DP最优子结构`best[n]`: 从第一个字符到第n个字符所能取得的最大解码数.

状态转移方程: 

```
if(n-1,n这两个位置上的数字可以代表一个字母)
{
    best[n]=max(
        best[n-1], 
        best[n-2]+best[n-1]//例如: 12-->1, 2或12
        );
}else
{
    best[n]=best[n-1];
}
```

<!-- ### 算法描述 -->

### 伪代码

```c
best[n+1];//从第一个字符到第n个字符所能取得的最大解码数
best[1]=1;
for(int i=2;i<=n;i++)
{
    if(i-1,i这两个位置上的数字可以代表一个字母)
    {
        best[i]=max(best[i-1], best[i-2]+best[i-1]);
    }else
    {
        best[i]=best[i-1];
    }
}
return best[n];
```

### 正确性证明

只有一个数字时只有一种解码方式.

对于n个数字时的情况, 其解码方式为:

1. 若最后两个数字只能被理解成单独的两个字母, 解码种类数与n-1个数字时的情况相同, 因为只引入了一个新字母.
1. 若最后两个数字可以被理解成单独的两个字母或一个字母, 即有两种理解方式, 则与前n-2个字母组合, 共有best[n-2]+best[n-1]种组合方式.


### 复杂度分析

同上:

$$O(n)$$

## Problem 4 (基本思路)

设串长度为n.

此题没有使用DP.

通过求前缀和的方法来利用"连续子串的条件". 通过求模来检查"the sum of which is the multiple of k"的条件.

### 代码

```c
//下标从1开始
int prefix_sum[n+1];//前缀和, 已求模
int k_first_position[k+1];//求模后为i的整数首次出现的位置为k_first_position[i];
int k_length_cnt[k+1];//求模后为i的两个整数的最长间隔

int sum=0;

for(int i=1; i<=n; i++)
{
    k_first_position[i]=n+1;
    k_length_cnt[i]=0;
    sum+=int_string[i];
    prefix_sum[i]=sum%k;
}

for(int i=1;i<=n;i++)
{
    if(i<k_first_position[prefix_sum[i]])//模k余prefix_sum[i]的数第一次出现
    {
        k_first_position[prefix_sum[i]=i;
    }
    if((i-k_first_position[prefix_sum[i]+1)>k_length_cnt[prefix_sum[i]])
    {
        k_length_cnt[prefix_sum[i]]=i-k_first_position[prefix_sum[i]+1;
    }
}

int result=0;

for(int i=0; i<k; i++)
{
    if(k_length_cnt[i]>result)
    {
        result=k_length_cnt[i];
    }
}

return result;
```

### 正确性证明

显然.

### 复杂度分析

$$O(2n+k)$$

```
2019.6.19 补充:

原做法使用空间换时间.

是否有空间复杂度更低的算法?

```

## Problem 5 (基本思路)

从左到右用动态规划求**一次**交易的最优解, 从右到左用动态规划求**一次**交易的最优解, 然后取不同的分割点进行将左右两次交易叠加, 最后选取和最高的分割点并求出和.

### DP最优子结构和状态转移方程

设共有n天.

DP最优子结构:

`best_left[i]`: 从第一天开始到第i天结束, 期间只交易一次的最大收入.

`best_right[i]`: 从第i天开始到第n天结束, 期间只交易一次的最大收入.

状态转移方程: 

$$best_left[i]=max(best_left[i-1], val[i]-min_found)$$

$$best_right[i]=max(best_right[i+1], val[i]-min_found)$$

<!-- ### 算法描述 -->

### 伪代码

```c
best_left[n+1];
best_right[n+1];
min_found=正无穷;
best_left[0]=0;
for(int i=1; i<=n; i++)
{
    if(val[i]<min_found)
        min_found=val[i];
    best_left[i]=max(best_left[i-1], val[i]-min_found);
}

min_found=正无穷;
best_right[0]=0;
for(int i=n; i>=1; i--)
{
    if(val[i]<min_found)
        min_found=val[i];
    best_right[i]=max(best_right[i-1], val[i]-min_found);
}

max=0;
for(int i=1; i<=n; i++)
{
    if((best_left[i]+best_right[i])>max)
        max=best_left[i]+best_right[i];
}

return max;
```

### 正确性证明

略.

注意最优解只进行一次交易的情况也包含在其中. (比如best_left[1]+best_right[1])

### 复杂度分析

$$O(n)$$

***

Copyright (C) 2018 Huaqiang Wang
