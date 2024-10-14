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

## 表的复制

将查询结果当作一张新的表创建

语法：
`create table 表名 as 查询结果;`

简单复制

`create table 表别名 as select * from 表名;`

获取子表

`mysql> create table user_name as select id,name from user;`













