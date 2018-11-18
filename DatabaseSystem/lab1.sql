
create table region  (r_regionkey  integer primary key,
                      r_name       char(25) not null,
                      r_comment    varchar(152));

create table nation  (n_nationkey  integer primary key,
                      n_name       char(25) not null,
                      n_regionkey  integer not null,
                      n_comment    varchar(152),
                      foreign key (n_regionkey) references region(r_regionkey)
                      );

create table supplier (s_suppkey     integer primary key,
                       s_name        char(25) not null,
                       s_address     varchar(40) not null,
                       s_nationkey   integer not null,
                       s_phone       char(15) not null,
                       s_acctbal     decimal(15,2) not null,
                       s_comment     varchar(101),
                       foreign key (s_nationkey) references nation(n_nationkey)
                       );

create table customer (c_custkey     integer primary key,
                       c_name        varchar(25) not null,
                       c_address     varchar(40) not null,
                       c_nationkey   integer not null,
                       c_phone       char(15) not null,
                       c_acctbal     decimal(15,2)   not null,
                       c_mktsegment  char(10) not null,
                       c_comment     varchar(117),
                       foreign key (c_nationkey) references nation(n_nationkey)
                       );

-- Newly added: 

-- drop table lineitem;
-- drop table orders;
-- drop table partsupp;
-- drop table part;
-- drop table customer;
-- drop table supplier;
-- drop table nation;
-- drop table region;


create table part (
    p_partkey integer primary key,
    p_name varchar(55),
    p_mfgr char(25),
    p_brand char(10),
    p_type varchar(25),
    p_size integer,
    p_container char(10),
    p_retailprice decimal,
    p_comment varchar(23)
);

create table partsupp(
    ps_partkey integer,
    ps_suppkey integer,
    ps_availqty integer,
    ps_supplycost decimal,
    ps_comment varchar(199),
    primary key (ps_partkey, ps_suppkey),
    foreign key (ps_partkey) references part(p_partkey),
    foreign key (ps_suppkey) references supplier(s_suppkey)
);


create table orders(
    o_orderkey integer,
    o_custkey integer,
    o_orderstatus char(1),
    o_totalprice decimal,
    o_orderdate date,
    o_orderpriority char(15),
    o_clerk char(15),
    o_shippriority integer,
    o_comment varchar(79),
    primary key (o_orderkey),
    foreign key (o_custkey) references customer(c_custkey)
);

create table lineitem(
    l_orderkey integer,
    l_partkey integer,
    l_suppkey integer,
    l_linenumber integer,
    l_quantity decimal,
    l_extendedprice decimal,
    l_discount decimal,
    l_tax decimal,
    l_returnflag char(1),
    l_linestatus char(1),
    l_shipdate date,
    l_commitdate date,
    l_receiptdate date,
    l_shipinstruct char(25),
    l_shipmode char(10),
    l_comment varchar(44),
    primary key (l_orderkey, l_linenumber),
    foreign key (l_orderkey) references orders(o_orderkey),
    foreign key (l_partkey) references part(p_partkey),
    foreign key (l_suppkey) references supplier(s_suppkey),
    foreign key (l_partkey, l_suppkey) references partsupp(ps_partkey, ps_suppkey)
);


copy region from '/home/dbms/Lab1/TPCH/tpch-gen/data/region.tbl' with (format csv, delimiter '|');
copy nation from '/home/dbms/Lab1/TPCH/tpch-gen/data/nation.tbl' with (format csv, delimiter '|');
copy supplier from '/home/dbms/Lab1/TPCH/tpch-gen/data/supplier.tbl' with (format csv, delimiter '|');
copy customer from '/home/dbms/Lab1/TPCH/tpch-gen/data/customer.tbl' with (format csv, delimiter '|');
copy part from '/home/dbms/Lab1/TPCH/tpch-gen/data/part.tbl' with (format csv, delimiter '|');
copy partsupp from '/home/dbms/Lab1/TPCH/tpch-gen/data/partsupp.tbl' with (format csv, delimiter '|');
copy orders from '/home/dbms/Lab1/TPCH/tpch-gen/data/orders.tbl' with (format csv, delimiter '|');
copy lineitem from '/home/dbms/Lab1/TPCH/tpch-gen/data/lineitem.tbl' with (format csv, delimiter '|');


for q in `seq 1 22`; do
      psql -d tpch -f $q.sql > $q.log
    done

-- ALTER TABLE orders
-- rename o_order_priority to o_orderpriority;

-- ALTER TABLE orders
-- rename o_ship_priority to o_shippriority;