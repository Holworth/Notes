# 数据结构 作业3

王华强 2016K8009929035

***

<!-- 第5章数组与广义表：5.1, 5.8, 5.11,5.12, , 5.15；				5.19, 5.20, 5.25, 5.27, 5.37 -->


## 第5章：	

## 5.1 假设有二维数组A6×8，每个元素用相邻的6个字节存储，存储器按字节编址，已知A的起始存储位置（基地址）为1000，计算：

(1) 数组A的体积（即存储量）；

`6*6*8=288`

(2) 数组A的最后一个元素a57的第一个字节的地址；

`1288-6=1282`

(3) 按行存储时，元素a14的第一个字节的地址；

`1072`

(4) 按列存储时，元素a47的第一个字节的地址。

`1276`

## 5.8 假设一个准对角矩阵按以下方式存于一维数组B[4m]中：写出由一对下标（i，j）求k的转换公式。

`k=(i/2)(下取整)*4+(1-i%2)*2+(1-j%2)`

## 5.11 利用广义表的GetHead和GetTail操作写出如上题的函数表达式，把原子banana分别从下列广义表中分离出来。

(1) L1 = (apple, pear, banana, orange);

`gethead(gettail(gettail(L1)))`
 
(2) L2 = ((apple, pear), (banana, orange));

`gethead(gethead(gettail(L2)))`

(3) L3 = (((apple), (pear), (banana), (orange)));

`gethead(gethead(gettail(gettail(gethead(L3)))))`

(4) L4 = (apple, (pear), ((banana)), (((orange))));

`gethead(gethead(gethead(gettail(gettail(L4)))))`

(5) L5 = ((((apple))), ((pear)), (banana), orange);

`gethead(gethead(gettail(gettail(L5))))`

(6) L6 = ((((apple), pear), banana), orange); 

`gethead(gettail(gethead(L6)))`

(7) L7 = (apple, (pear, (banana), orange));

`gethead(gethead(gettail(gethead(gettail(L7)))))`

## 5.12 按教科书5.5节中图5.8所示结点结构，画出下列广义表的存储结构图，并求它的深度。

(1) ((()),a,((b,c),(),d),(((e)))) 

深度4

见附图文件

(2) ((((a),b)),(((),(d)),(e,f))) 

深度4

见附图文件

![广义表.svg](广义表.svg)

## 5.15 写出求给定集合的幂集的递归定义。

```cpp
set getpowerset(set src)
{
    if(src.notempty())
    {
        elem=src.head();
        src.pop_head()
        yeildset(elem+getpowerset(src));//含elem
        yeildset(getpowerset(src));//不含elem
    }
}

void yeildset()
{
    //将当前元素作为一个集合添加到结果集合中
}
```
 