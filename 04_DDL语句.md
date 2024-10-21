# DDL语句

DDL包括：`create` `drop` `alter`

## 表的创建create

语法：

`create table 表名 (字段1 数据类型 , 字段2 数据类型 , 字段3 数据类型);`

表名和字段名都属于标识符，建议以t_开始，见名知意。

创建时还可以确定默认值，不指定则为NULL

`字段1 数据类型 default 默认值`

> 数据库中的命名规范：所有的标识符都是小写，单词用_连接

## Mysql中的常见数据类型

| varchar  | 可变长度的字符串(255) | 比较智能，节省空间，会根据实践数据长度分配空间。varchar(10)。节省空间；动态分配速度慢。姓名 |
| :------: | :-------------------: | :----------------------------------------------------------: |
|   char   |    定长字符串(255)    | 分配固定长度空间存储数据，但是可能会浪费空间。浪费空间；固定分配速度快。性别 |
|   int    |  数字中的整数型(11)   |              相当于java中的int，int(3)建议长度               |
|  bigint  |    数字中的长整型     |                      相当于java中的long                      |
|  float   |     单精度浮点型      |                                                              |
|  double  |     双精度浮点型      |                                                              |
|   date   |        短日期         |                                                              |
| datetime |        长日期         |                                                              |
|   clob   |      字符大对象       |          最多可以存储4G的字符串，例如文章，超过255           |
|   blob   |     二进制大对象      | 专门用来存储图片，声音，视频等流媒体数据，插入数据要使用IO流 |

`clob`：Character Large Object

`blob`：Binary Large Object

## 表的删除drop

语法：

`drop table 表名;`

当表名不存在的时候会报错，改进

`drop table if exists 表名;`

> Mysql也有可视化工具

## 数据的插入insert（DML）

语法：

`insert into 表名 (字段名1，字段名2，字段名3...) values(值1，值2，值3);`

注意字段名和值一一对应，数量，数据类型，顺序可以和表不同

**每次插入都是新增一行记录，而且不一定要插入所有的属性，不插入的则自动默认为NULL**

前面的字段名不能省略，如果省略等于后面的值都要写上

`insert into t_stu values(4,'brus','f',21,'12345@gmail.com');`

插入日期：

1. 数字格式化：`format(数字，'格式')` 

```
mysql> select ename,format(sal,'$999,999') as sal from emp;
+--------+-------+
| ename  | sal   |
+--------+-------+
| SMITH  | 800   |
| ALLEN  | 1,600 |
| WARD   | 1,250 |
| JONES  | 2,975 |
```

2. `str_to_date('字符串日期','日期格式')` ：将字符串varchar转换成date类型。通常使用在插入一个日期类型的数据时。如果字符串日期格式为`'%Y-%m-%d'` ，则不需要转换了，因为mysql自动转换。

```
create table user(id int,name varchar(20),birth date);
insert into user(id,name,birth) values(1,'jack',str_to_date('01-10-1990','%d-%m-%Y'));
```

```
mysql> select * from user;
+------+------+------------+
| id   | name | birth      |
+------+------+------------+
|    1 | jack | 1990-10-01 |
+------+------+------------+
1 row in set (0.00 sec)
```

3. `date_format(日期字段,'格式')` ：将date类型转换为一定格式的字符串，通常在查询日期时使用，设置展示日期的格式，默认select会有默认的格式 `%Y-%m-%d`

```
mysql> select id,name,birth from user;
+------+------+------------+
| id   | name | birth      |
+------+------+------------+
|    1 | jack | 1990-10-01 |
+------+------+------------+
```

```
mysql> select id,name,date_format(birth,'%Y/%m/%d') bir from user;
+------+------+------------+
| id   | name | bir        |
+------+------+------------+
|    1 | jack | 1990/10/01 |
+------+------+------------+
```

```
mysql的日期格式：
	%Y	年
	%m	月
	%d	日
	%h	时
	%i	分
	%s	秒
```

> java中的日期格式：YYYY-MM-DD HH:MM:SS SSS

`date` 和`datetme`

`date` 是短日期：年月日						**默认格式：%Y-%m-%d**

`datetme`是长日期：年月日时分秒		**默认格式：%Y-%m-%d %h:%i:%s**

```
mysql> create table user(id int,name varchar(20),birth date,create_time datetime);
Query OK, 0 rows affected (0.01 sec)
mysql> insert into user(id,name,birth,create_time) values(1,'jack',str_to_date('01-10-1990','%d-%m-%Y'),'2024-10-14 10:57:09');
Query OK, 1 row affected (0.00 sec)
mysql> select * from user;
+------+------+------------+---------------------+
| id   | name | birth      | create_time         |
+------+------+------------+---------------------+
|    1 | jack | 1990-10-01 | 2024-10-14 10:57:09 |
+------+------+------------+---------------------+
1 row in set (0.00 sec)
```

获取系统当前时间函数：`now()` 是datetime类型

```
mysql> insert into user(id ,name,birth,create_time) values(2,'mike','2003-11-22',now());
Query OK, 1 row affected (0.00 sec)
mysql> select * from user;
+------+------+------------+---------------------+
| id   | name | birth      | create_time         |
+------+------+------------+---------------------+
|    1 | jack | 1990-10-01 | 2024-10-14 10:57:09 |
|    2 | mike | 2003-11-22 | 2024-10-14 11:01:39 |
+------+------+------------+---------------------+
2 rows in set (0.00 sec)
```

### 一次插入多条

`insert into 表名(字段1，字段2....) values(值1，值2...),(值1，值2...),(值1，值2...);`

```
mysql> insert into user values
    -> (2,'liu','2004-1-1',now()),
    -> (3,'cheng','2008-4-4',now()),
    -> (4,'flawa','2024-10-1',now());
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0
```

## 数据的修改update(DML)

语法：
`update 表名 set 字段1=值1，字段2=值2 ... where 条件;`

没有条件会导致所有数据更新

## 数据的删除delete(DML)

语法：
`delete from 表名 where 条件;`

这里的删除指的是删除一条条记录，没有条件会导致所有数据被删除

> 由于命令窗口是GBK编码的，但是Mysql数据库是utf-8编码，所以可能会报错或者乱码

删除表中的所有数据 ：`delete from 表名;`

**表中的数据被删除，但是数据在硬盘上的实际内容还在，即只是抹除了数据，但是空间没有释放**

**缺点：删除效率低，一个一个字段删除**

**优点：支持回滚，可以恢复**

```\
start transaction;		//开启事务
delete from user_name;	//删除
select * from user_name;//查看
rollback;				//回滚
select * from user_name;//查看
```

==**快速**==，不可回滚地删除表中的数据，表还在

`truncate table 表名`   **(DDL)**

## 表的复制（了解）

将查询结果当作一张新的表创建

语法：
`create table 表名 as 查询结果;`

简单复制

`create table 表别名 as select * from 表名;`

获取子表

`mysql> create table user_name as select id,name from user;`

将查询结果插入到新的表中

`mysql> insert into user_name select id,name from user;`

查询结果需要符合原表的结构

## 表结构的修改alter（了解）

**添加修改删除字段**

开发过程一般不修改表结构，修改表结构操作少，可以用工具

# 约束constraint（重要）

创建表的时候可以给表中的字段加上一些约束，保证表中数据的完整性，有效性

常见约束：

1. 非空约束：`not null`
2. 唯一性约束：`unique`
3. 主键约束：`primary key` PK
4. 外键约束：`foreign key` FK
5. 检查约束：`check` mysql不支持

## 非空约束

```
create table t_vip(
    id int,
    name varchar(255) not null
);
```

`not null`直接放到建表的字段后面

必须往该字段插入内容，否则报错

只有列级约束

## 唯一性约束

### 单个字段唯一性：

```
create table t_vip(
    id int,
    name varchar(255) unique
);
```

插入字段不能重复，但是可以都为null，null不算重复

列级约束

### 两个字段联合唯一性:

即在创建表的最后加上` unique(name,email)`

name和email两个字段联合起来唯一

表级约束

### 各自唯一性：

即两个字段分别加上`unique`

### 联合非空约束：

```
create table t_vip(
    id int,
    name varchar(255) unique not null
);
```

在mysql中，如果一个字段同时被not null和unique约束，则该字段自动变成主键字段。Oracle不是这样

##　主键约束

主键约束，主键字段，主键值。

**主键是每一行记录的唯一标识，任何一张表都应该有主键，否则表无效**

**主键特征：not null * unique 不能为空也不能重复**

```
create table t_vip(
    id int,
    name varchar(255) primary key
);
```

1. 列级约束：`primary key`添加在字段后面

2. 表级约束：`primary key(字段)` 

1. 单一主键：推荐使用

2. 复合主键：`primary key(字段1,字段2)` 

**一张表主键约束只能添加一个，主键只能有一个**

*主键一般都是数字，定长的，不建议varcahr做主键*

1. 自然主键：主键值是一个自然数，和业务无关
2. 业务主键：主键值和业务紧密关联，例如银行卡号

实际开发中，自然主键用的多。因为主键只要做到不重复即可，不需要有意义，



**自动维护主键值**

`id int primary key auto_increment,` 即自动维护id的值，自增方式，从1开始递增

> 约束添加到列后面的是列级约束，其他的是表级约束（多个字段联合起来添加约束）



## 外键约束

外键约束，外键字段，外键值。

外键：即两张表相关联的那个字段，显然也是需要约束的

### 子表和父表

子表中用了父表的数据。

删除表：先子再父

创建表：先父再子

删除数据：先子再父

插入数据：先父再子

```
drop table if exists t_student;
drop table if exists t_class;
create table t_class(
    classno int primary key,
    classname varchar(255)
);
create table t_student(
    no int primary key auto_increment,
    name varchar(255),
    cno int,
    foreign key(cno) references t_class(classno)
);
insert into t_class values(100,'csu');
insert into t_class values(101,'pku');
insert into t_student(name,cno) values('cj',100);
insert into t_student(name,cno) values('lgf',101);
insert into t_student(name,cno) values('ab',100);
insert into t_student(name,cno) values('cd',101);

select * from t_class;
select * from t_student;
```

`foreign key(cno) references t_class(classno)`

外键一约束，对应的外键字段就不能随便写了，字段的值只能来自父表中字段的值。

**外键值可以为空，被引用的字段必须有唯一性classno，但是不一定是主键**



# 其他

> XXX.sql称为sql脚本文件，其中含义大量sql语句
>
> 执行脚本文件会把所有的sql语句执行
>
> `source 脚本绝对路径`

# 存储引擎（了解）

mysql中特有的术语。

存储引擎实际上是一个表存储/组织数据的方式，不同引擎不同存储方式

> 查看建表的时候具体命令 ` show create table t_student;`

```
 CREATE TABLE `t_student` (
  `no` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `cno` int DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `cno` (`cno`),
  CONSTRAINT `t_student_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `t_class` (`classno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
```

建表时，可以指定

ENGINE存储引擎				默认是InnoDB

CHARSET字符编码方式		默认是utf8mb4

```
mysql> create table engine(
    ->  id int
    -> )engine =innodb default charset =gbk;
```

可以自己指定

## 常见存储引擎

查看存储引擎

`show engines \g`

| Engine |                             特点                             |
| :----: | :----------------------------------------------------------: |
| MyISAM | 使用三个文件表示每个表，格式文件.frm、数据文件.MYD、索引文件.MYI（提高查询速度）。**可以被转化为压缩，只读，节省空间，不支持事务，安全低** |
| InnoDB | Mysql默认存储引擎，格式文件.frm，数据+索引存储在表空间，**支持事务，支持数据库崩溃后的恢复。主打一个安全，但是效率不高，也不能省空间** |
| MEMORY | 存储的数据在内存中，一断电就消失了，且行的长度固定。**速度极快**。 |

*对应一张表，只要是主键或则unique字段，默认创建索引*

# 事务（重点）

一个完整的业务逻辑，例如转账A-,B+，最小的工作单元，同时成功或则失败

**只要DML语句才会有事务说法，即insert，delete，update，只有这三个动数据**

**一个事务就是多条DML语句同时成功或失败**

```
事务开启
insert
update
delete
...
事务结束
```

在事务执行的过程中，每一条DML操作都会记录到**事务性活动的日志文件**中

提交事务：清空日志，将数据持久化到数据库表中

回滚事务：将之前所有的DML操作撤销，清空日志

类似于git

提交：`commit`

回滚：`rollback ` （回滚上次提交位置）

事务：`transaction`

**mysql默认是自动提交，执行一条DML语句，则提交一次**

具体语法：

```
start transaction;
DML
DQL
DML
...
rollback/commit		回退或提交结束事务
```

##　四个特性ACID

1. 原子性:A 事务是最小的工作单元，不可再分
2. 一致性:C 所有操作同时成功或则失败
3. 隔离性:I 事务之间相互隔离
4. 持久性:D 保存到硬盘上

## 隔离性

隔离级别：读未提交，读已提交，可重复读，序列化/串行化。级别由低到高

1. 读未提交：事务A可以读取到事务B未提交的数据。

   导致脏读现象（Dirty read）读了藏数据，一般是理论，实际从第二档起步

2. 读已提交：事务A只能读取到事务B提交的数据。

   解决藏读现象，导致问题：不可重复读取数据。即A事务过程中，B事务提交，导致读取数据变化

   Oracle数据库默认级别，每次读取数据绝对真实。

3. 可重复读：事务A开启后，不管多久，每次A中读取到的数据都是一致的，即使B事务提交

   导致幻影读，每次读取到的数据不是真实的，每次读取的都是事务开启时的数据

   mysql默认的级别

4. 序列化/串行化：最高隔离级别，效率最低，解决所有问题，表示事务排队，不能并发



**查看当前会话隔离级别**：`select @@transaction_isolation;` 

**设置全局隔离级别**：`set global transaction isolation level repeatable read;`

1. Read Uncommitted（读取未提交内容）
2. Read Committed（读取提交内容）
3. Repeatable Read（可重读）
4. Serializable（可串行化）：两个事务同时操作的话，会导致一个事务卡住，即排队等另一个事务完成

验证隔离级别：

