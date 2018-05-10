# 数据结构 作业3

王华强 2016K8009929035

***

<!-- 3.3, 3.7, 3.10； 3.17, 3.18, 3.20, 3.21, 3.24, 3.25, 3.28, 3.31 -->

## 第4章：	



## 4.3
设s = ‘I AM A STUDENT’，t = ‘GOOD’，q = ‘WORKER’。

求：StrLength(s) ，StrLength(t) ，SubString(s, 8, 7) ，SubString(t, 2, 1) ，Index(s, ‘A’) ，Index(s, t) ，Replace(s, ‘STUDENT’, q) ，Concat(SubString(s, 6, 2), Concat(t, SubString(s, 7, 8)))

```
StrLength(s)==14
StrLength(t)==4
SubString(s, 8, 7)=="STUDENT"
SubString(t, 2, 1)=="O"
Index(s, ‘A’)==3
Index(s, t)==0
Replace(s, ‘STUDENT’, q), s==‘I AM A WORKER’
Concat(SubString(s, 6, 2), Concat(t, SubString(s, 7, 8))),
-->Concat("A ", Concat("GOOD", "STUDENT"))
-->"A GOOD STUDENT"
```

## 4.4


已知下列字符串

```
a = ‘THIS’,　f = ‘A SAMPLE’,　c = ‘GOOD’,　d = ‘NE’,　b = ‘ ’.
s = Concat(a, Concat(SubString(f, 2, 7), Concat(b, SubString(a, 3, 2)))),
s --> Concat("THIS", Concat(" SMAPLE", Concat(" ", "IS"))),
s --> "THIS SMAPLE IS"
t = Replace(f, "SAMPLE", c),
t --> "A GOOD",
u = Concat(SubString(c, 3, 1), d),
u -->"ONE",
g = ‘IS’,
v = Concat(s, Concat(b, Concat(t, Concat(b, u)))),
v = Concat("THIS SMAPLE IS", Concat(" ", Concat("A GOOD", " ONE"))),
v --> "THIS SAMPLE IS A GOOD ONE"
```

试问：s，t，v，StrLength(s) ，Index(v, g) ，Index(u, g) 各是什么？

```
s --> "THIS SMAPLE IS"
t --> "A GOOD",
v --> "THIS SAMPLE IS A GOOD ONE"
StrLength(s)-->14
Index(v, g)-->13
Index(u, g)-->0
```
 
## 4.8 

已知主串s = ‘ADBADABBAABADABBADADA’,

模式串pat = ‘ADABBADADA’,

写出模式串的nextval函数值，并由此画出KMP算法匹配的全过程。

使用优化过的KMP算法

nextval: 以1为字符串首元素, 0为空位置, 记录字符串长度

原串|A|D|A|B|B|A|D|A|D|A
-|-|-|-|-|-|-|-|-|-|-
原串位置|1|2|3|4|5|6|7|8|9|10
nextval|0|1|0|2|1|0|1|1|4|0

匹配过程:
```
‘ADBADABBAABADABBADADA’
‘ADABBADADA’

‘ADBADABBAABADABBADADA’
   ‘ADABBADADA’

‘ADBADABBAABADABBADADA’
     ‘ADABBADADA’

‘ADBADABBAABADABBADADA’
        ‘ADABBADADA’

‘ADBADABBAABADABBADADA’
           ‘ADABBADADA’
```