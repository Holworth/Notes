# SQL语法简述

## 如何跑路

```sql
drop database dbname;
```

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