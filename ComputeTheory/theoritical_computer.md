# 理论计算机期末拾遗

* TIME(t(n)):={L|某个O(t(n))时间TM判定语言L}
* NTIME(t(n)):={L|某个O(t(n))时间NTM判定语言L}
* P:单带图灵机(及其等价模型)可以在P时间内识别的语言
* NP:单带图灵机(及其等价模型)可以在P时间内验证的问题/某个非确定性TM在P内可计算的语言
* NP=all(NTIME(n^k))

NP问题：
* CLIQUE<G,k>
* SUBSET-SUM
* SAT
* 3SAT

搜索规约判定: 常见的很多问题都有这样的性质: 若已知一个多项式时间的判定算法, 则可以在非确定多项式的时间内搜索出结果

ie:P判定<-->NP搜索

SAT-->SPACE(O(n))

* PATH-->NLcomp
* coPATH-->NL(证明，归纳计数)

由上知NL=coNL

确定性复杂性类对补封闭。

非确定性复杂性类：NSPACE在f(n)>logn的情况下成立。

空间可构造函数1^n-->more than logn 对应着可以构造这样的一个图灵机 f(n)在O(f(n))内可计算。 (存在TM以f(n)为时间复杂度)

时间可构造函数1^n-->more than nlogn (通用机模拟其他图灵机时有一个logn的额外开销) 对应着可以构造这样的一个图灵机 f(n)在O(f(n))内可计算。 (存在TM以f(n)为时间复杂度)

线性加速定理：使用符号组合来更新字母表。

空间可构造定理： 证明：对角化方法

A与P的相等关系
* ATIME(f(n))属于SPACE(f(n))属于ATIME(f(n)^2)
* ASPACE(f(n))=TIME(2^O(f(n)))

(证明：类似萨维奇定理， AP是NP的推广)

由此得到结论： AL=P AP=PSPACE ASPECE=EXP

多项式时间层次，PH类。 PH(常数次交错)属于PSPACE(多项式次交错)=AP

PH类也可由OTM(谕示图灵机)定义

TIME多带(t(n))=TIME(t(n)^2) ????

NTIME(t)=TIME(2^O(t))  ????

改作业

完整的规约证明：规约构造，正确性证明， 复杂度证明