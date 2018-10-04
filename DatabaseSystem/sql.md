# SQL语法简述

## 如何跑路

```sql
drop database dbname;
```

## 前言

注意关系代数的格式!

不同关系代数及其对应的格式如下:

* 过滤(条件选择): $\sigma_{rating>8}(Sailors)$
* 投影: $\pi_{sid,sname}(Sailors)$
* Join: $Sailors \亚登之印 Reserves$

关系代数可以结合在一起使用.

Join符号打不出来... 亚登之印了解一下.

## 创建数据库和表

```sql
create database %name;
create table %name(
    column_name1 integer not null,
    -- main_key integer primary key,
    column_name2 float,
    date_data date,
    unique(attribute1,attribute2),
    primary key(attribute1),
    foreign key(attribute2) references table_name(Primary_key) 
);
```

```
create table;
drop table;
alter table add attribute3 char(10);
alter table add attribute4 char(10) default "2222";
alter table add attribute4 char(10);
alter table drop attribute4;
```

```sql
smallint
integer
real
double (32)
float
decimal/numeric(size,c)
char(n) (定长字符串)
varchar(n) (变长字符串)
timestamp
BLOB (Binary Large Object)
CLOB (Character Large Object)
enum(var1,var2,var3)
```

```
Null
Default
```

## 表示联系集

```sql
create table 联系集(
    table1_attribute integer,
    table2_attribute integer,
    data1 integer,
    data2 integer,
    primary key(table1_attribute,table2_attribute),
    foreign key(table1_attribute) reference table1(table1_attribute),
    foreign key(table2_attribute) reference table2(table2_attribute),
);
```

## 表示弱实体集

```sql
create table tname(
    Key1 integer,
    ID integer,
    primary key(Key1,ID),
    foreign key(ID) references table1(ID)
        on delete cascade
        -- 在依托的实体集被删除时自动删除
)
```

## 表示ER图的类层次

```sql
create table tname(
    Key1 integer,
    ID integer,
    primary key(ID),
    foreign key(ID) references table1(ID)
        on delete cascade
        -- 在依托的实体集被删除时自动删除
)
```

<!-- ```mermaid
graph TD;
Student-.->ISA
``` -->

## SQLite 语法

`.schema`显示表的完整信息

`.tables`查看当前表的列表

`.help`

## 选择语句 select

```sql
select *
from table_name
where attribute1=1;

select name1,name2
from table_name
where attribute1=1;
```

`where`中还可以使用以下的特殊条件:

```sql
列名 between value1 and value2
列名 in (value1, value2)
字符串 like 模式
字符串 not like 模式
```

sql中的模式字符串不同于unix中的regstr, 参见:

http://www.runoob.com/sql/sql-wildcards.html

`where`还可以配合`and`, `or`, `not`使用, 可以使用()表达优先级:

```sql
select *
from table_name
where 列1>100
and   列2<100
and   (列三!=1 or 列4 < 9);
```

> 补充一点: `NULL`参与的比较操作结果为`UNKNOWN`

## 投影 Select

> 将关系代数的投影视为降维

```sql
select *
from table1;
```

## 投影+去重 Distinct

```sql
select distinct *
from table1;
```

## INSERT INTO

> 第一种形式无需指定要插入数据的列名，只需提供被插入的值即可：

```sql
INSERT INTO table_name
VALUES (value1,value2,value3,...);
```

> 第二种形式需要指定列名及被插入的值：

```sql
INSERT INTO table_name (column1,column2,column3,...)
VALUES (value1,value2,value3,...);
```

## SQL DELETE 语句

> DELETE 语句用于删除表中的行

```sql
DELETE FROM table_name
WHERE some_column=some_value;
--不使用where的话所有数据都会被删除
```

## ORDER BY

> ORDER BY 关键字用于对结果集按照一个列或者多个列进行排序。

> ORDER BY 关键字默认按照升序对记录进行排序。如果需要按照降序对记录进行排序，可以使用 DESC 关键字

```sql
SELECT column_name,column_name
FROM table_name
ORDER BY column_name,column_name ASC|DESC;
```

> ORDER BY 多列的时候，先按照第一个column name排序，在按照第二个column name排序

## SQL UPDATE

> UPDATE 语句用于更新表中已存在的记录。

```sql
UPDATE table_name
SET column1=value1,column2=value2,...
WHERE some_column=some_value;
--如果不使用where, 所有行的数据都会被更新.
```

## Join

示例如下:

```sql
SELECT Websites.id, Websites.name, access_log.count, access_log.date
FROM Websites
INNER JOIN access_log
ON Websites.id=access_log.site_id;
```

注意`join`和`on`的搭配.

### Join中可用的Sql Join类型

* INNER JOIN：如果表中有至少一个匹配，则返回行 (基本的等值链接, 内部链接)
* LEFT JOIN：即使右表中没有匹配，也从左表返回所有的行 (外部链接)
* RIGHT JOIN：即使左表中没有匹配，也从右表返回所有的行 (外部链接)
* FULL JOIN：只要其中一个表中存在匹配，则返回行 (外部链接)

> 连接的结果可以在逻辑上看作是由SELECT语句指定的列组成的新表.

### Equl-Join等值链接

就是`inner join`

注意: inner join 与 join 是相同的

### join 多个表

#### SQL-89
```sql
select a1,a2
from table1
inner join t2, t3
where table1.a1=t2.a1 and table1.a1=t3.a1
```

#### SQL-92

```sql
select 
TODO
```

### 等值连接

TODO

### \theta 链接

```sql
select T.a,F.b
from T,F
where T.a>F.b
```

## 别名 AS

列的 SQL 别名语法

```sql
SELECT column_name AS alias_name
FROM table_name;
```

表的 SQL 别名语法

```sql
SELECT column_name(s)
FROM table_name AS alias_name;
```

## 集合操作

TODO

### Union

> SQL UNION 操作符
> UNION 操作符用于合并两个或多个 SELECT 语句的结果集。

> 请注意，UNION 内部的每个 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每个 SELECT 语句中的列的顺序必须相同。

```sql
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
```

> 默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。

```sql
SQL UNION ALL 语法
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
```

> UNION 结果集中的列名总是等于 UNION 中第一个 SELECT 语句中的列名。

### INTERSECT

### EXCEPT

## 笛卡尔积

```sql
select *
from table1, table2;
```

## Division (除)

非常用操作, 没有直接SQL语句支持.

We define:

$$A(x,y), B(y)$$

Then:

$$A/B:=\left\{ x | \forall y \in B, (x,y) \in A \right\}$$

## 同时查询多个table(链接,过滤,投影)

```sql
select color
from Sailors, Reserves, Boats
where Sailors.sid=Reserves.sid 
AND Reserves.date=today
AND Sailors.name='POI' 
AND Reserves.bid=Boats.bid;

```

```sql
select distinct sname
from Sailors,Reserves AS r1, Reserves AS r2
where Sailors.sid=R1.sid
AND Sailors.sid=R2.sid
AND R2.sid!=R1.sid;
```

## SQL Except

```sql
select * from a
except
select * from b
```


## 求统计信息

```
select AVG(GPA) ... 
select MAX(GPA) ... 
select MIN(GPA) ... 
select COUNT(GPA) ... 
select SUM(GPA) ... 
select SUM(distinct GPA) ... 
```

## GROUP BY

```sql
select major, count(*) as number
from Student
where age>20
group by major
having grade>80
order by number asc;
```

distinct可以看作是group by的一个特例. 组名只保留一个.

`having`:在group by的基础上进行选择.

`order by`:排序

## 嵌套的select语句

关键字: in, exists, any

```sql
select major, count(*) as number
from Student
where stid in (
    select .....
)
```

```sql
select major, count(*) as number
from Student
where exists (
    select .....
)
```

```sql
select name
from Student S
where score > any (
    select score
    from Student S2
    where S2.name like '%Tom%'
);
```

```sql
select name
from Student S
where score > all (
    select score
    from Student S2
    where S2.name like '%Tom%'
);
```

性能较差, 尽量避免

## 完整性约束(TODO)

### 主键 primary key()

### foreign key() references()

### CHECK()对单个表定义

只对insert和update敏感.

### ASSERTION()

对任何修改都敏感.

警告: 代价非常大!

## 触发器

TODO

```
Constraint cname xxxxx
```
可以命名约束.

***

ref: http://www.runoob.com/sql/

