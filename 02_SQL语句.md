# SQL语句

## 简单查询（一个字段）

`select 字段名 from 表名`

select和from都是关键字

字段名和表名都是标识符

> SQL语句是通用的，都是以分号`;`结尾

> **SQL语句不区分大小写**

## 查询多个字段

==字段名使用逗号隔开==

`select 字段名1,字段名2,字段名3 from 表名`

## 查询所有字段

1. 把每个字段都写上，用逗号隔开
2. 使用 `*` 星号 （效率低--把星号转换为字段再执行；可读性差）

## 给查询的列起别名

`as` 关键字

`select 字段名1 as 别名 from 表名`

`select dname as deptname from dept;`

**只是将显示查询结果的列名修改，原表列名不变**

> select语句不会进行修改操作

as关键字还可以省略

`select 字段名1 空格 别名 from 表名`

> SQL语句也是要进行编译运行的，不符合语法则报错

如果别名有空格，则用单引号（或者双引号）将别名括起来

`select 字段名1 空格 '别名 别名'  from 表名`

**在所有数据库中，字符串统一用单引号括起来，是标准，双引号在oracle数据库中用不了，但是mysql可以**

## 列参与运算

`select 字段名*12 from 表名`

**字段可以使用数学表达式**

例子` select ename,sal*12 as yearsal from emp;`

**别名可以是中文，但是要用单引号括起来**

## 条件查询

查询出符合条件的数据。

语法格式:

```
select 
	字段1，字段2，字段3
from
	表名
where
	条件;
```

## 条件大全

|                       =                       |    等于（数值或者字符串）     |
| :-------------------------------------------: | :---------------------------: |
|                    <>或!=                     |            不等于             |
|                       <                       |             小于              |
|                       >                       |             大于              |
|                      <=                       |           小于等于            |
|                      >=                       |           大于等于            |
| between ... and ...（必须左小右大且是闭区间） | 两个值之间（等同于>= and <=） |
|             is null或is not null              |     是否为空（等号不行）      |
|                    and/or                     |             且/或             |
|                  in或not in                   |      包含，相当于多个or       |
|                     like                      |           模糊查询            |
|                                               |                               |

1. 等号也可以查询字符串，不是==

` select empno,ename from emp where ename='smith';` 

2. **在数据库中null不能使用等号衡量，数据库中的null代表什么也没有，不是一个值**
3. **and 和 or 同时出现时，有优先级问题？and优先级比or的更高，先执行and。可以通过==加小括号解==决**
4. in不是一个区间，即判断元素是否落在这个集合`select * from emp where job in('manager','salesman');`
5. like模糊查询，适用于字符串匹配：`%` 表示任意多个字符；`_` 表示任意一个字符。**如果带匹配的字符串有_或者%，则使用\进行转义，`\_` `\%` **

` select * from emp where ename like '%o%';`

`select * from emp where ename like 'm%';`

##　单字段排序

语法格式：**默认升序**

```
select 
	字段1，字段2，字段3
from
	表名
order by
	按照排序的字段;
```

```
select 
	字段1，字段2，字段3
from
	表名
order by
	按照排序的字段 desc;	//指定降序。指定asc则是升序
```

## 多个字段排序

```
select 
	字段1，字段2，字段3
from
	表名
order by
	首先排序的字段 desc , 其次排序的字段 asc;	//指定降序。指定asc则是升序
```

**当第一个字段相同，则按照第二个字段进行排序**

**字符串也是可以排序的，即按照字典序排列**

## 根据字段位置排序

```
select 
	字段1，字段2，字段3
from
	表名
order by
	字段的列数;			//例如1表示按照查询结果的第一列进行排序
```

*不建议这样写，不健壮*

## 综合

条件查询where，排序order by，可以综合到一起，但是有顺序

```
select 
	...
from 
	...
where 
	...
order by 
	...
```

执行顺序：from，where，select，order by（排序总是在最后执行）

##　数据处理函数／单行处理函数

单行处理函数特点：一个输入对应一个输出，即函数是一条记录一条一条处理

多行处理函数特点：多个输入对应一个输出，如`sum`

**处理函数是作用于字段的**

1. `lower` 转换成小写 `select lower(ename) as NAME from emp;`
2. `upper` 转换大写 `select upper(ename) from emp;`
1. `substr` 取子串 substr(被截取的字段,起始下标,截取的长度) ==数据库字符串下标以1开始==

​	例题：找出以A开头的员工姓名的信息

* 模糊查询：`select * from emp where ename like 'A%';`
* substr函数：`select * from emp where substr(ename,1,1)='A';`

4. `concat` 字符串拼接 `select concat(empno,ename) from emp;`

首字母大写 ` select concat(substr(ename,1,1),lower(substr(ename,2,length(ename)-1))) from emp;`

5. `length` 取长度 ` select length(ename) as enamelength from emp;`
6. `trim` 字符串去空格 ` select * from emp where ename=trim('  KING');` 如果不用trim则无法查到结果
7. str_to_date 将字符串转换为日期
8. date_format 格式化日期
9. format 设置千分位
10. `round` 四舍五入

select后面可以跟字段名或者常量值

*　`select 字段 from 表名;` 即标准的查找

*  `select 常量(数值或者字符串) from 表名;` 不是查找，而是按照表的格式全部默认赋值为该常量

`select round(1234.56) as result from emp;`  结果都是1235

`select round(1234.56,0) as result from emp;` 结果同上

`select round(1234.56,1) as result from emp;` 结果保留一位小数1234.6

`select round(1234.56,-1) as result from emp;` 结果四舍五入个位数，结果是1240

11. `rand()` 生成随机数，默认为（0，1）`select round(rand()*100) from emp;` 0-100随机数
11. `ifnull` 空处理函数，专门处理空值。==在数据库中，只要有null参与的数学运算，其结果都为空==

例如：`select sal+comm as sumsalary from emp;` 结果有可能是null，所以要使用null。

用法：`ifnull(数据，被当作的值)` 即如果数据为空时自动转换为对应的值

改进：`select ename,(sal+ifnull(comm,0))*12 as yearsal from emp;` 就不会出现null的情况了

13. `case ... when ... then ...when ... then ... else ... end` 即当什么情况做什么，什么情况做什么，其他情况做什么

例子：`select ename,job,sal as oldsal,(case job when 'manager' then sal*100 when 'salesman' then sal*10 else sal end) as newsal from emp;`

## 分组函数/多行处理函数group function

多行处理函数特点：多个输入对应一个输出，即最后的结果只有一行，如`sum`

==**分组函数在使用的时候必须先进行分组，然后才能使用。如果没有分组，则整张表默认为一组**==

1. `count` 计数 `select count(ename) from emp;`
2. `sum` 求和 `select sum(sal) from emp;`
3. `avg` 平均值 `select avg(sal) from emp;`
4. `max` 最大值 `select max(sal) from emp;`
5. `min` 最小值

注意事项：

1. 分组函数自动忽略null，不用对null进行处理。即在计算sum的时候，会自动把null的值忽略，不用对null进行处理。可以通过count进行查看
2. 分组函数中count(*)和count(具体字段)的区别。

* count(具体字段)：表示统计该字段下所以不为null的元素总数
* count(*)：表示统计表中的总行数

**在数据库中，不存在某条记录，其全部字段都为null。有一个不为null，则数据有效**

3. **分组函数不能够直接使用在where语句中**；否则报错

ERROR 1111 (HY000): Invalid use of group function

具体原因：分组查询group by

因为以下关键字的顺序不能颠倒，执行顺序from，where，group by，select，order by。需要先执行where，然后才分组，才能使用分组函数

4. 所有分组函数可以组合一起使用。`select sum(sal),min(sal),max(sal),avg(sal),count(*) from emp;`

## 分组查询！！！！！

`order by` 对数据进行分组，然后对每一组的数据进行操作。不分组，则默认整个表为一组

以下关键字的顺序不能颠倒，==**执行顺序from，where，group by，select，order by**==

```
//语法结构
select 
	...
from 
	...
where
	...
group by
 	...
order by
	...
```

案例：找出每个岗位的工资和，按照岗位分组，然后对工资求和

`select sum(sal),job from emp group by job;`  ==**可以直接查询分组字段的值job，但是其他的字段则不能查询或无意义**==

有的版本的mysql可以执行，但是oracle不能执行，因为其语法严格

==**特别的：如果进行了分组，即有group by语句，则select后面只能跟：分组的字段，以及分组函数。其他的都不行**==

案例：找出每个岗位的最高工资，按照岗位分组，然后对工资求最大值

`select job,max(sal) from emp group by job;`

## 两个字段联合分组

案例：找出每个部门，不同工作岗位的最高薪资

**需要将两个字段联合成一个字段看，即联合分组，group by 后面跟两个字段**

可以多个字段联合分组，且这些字段都可以跟在select后面。

` select job,deptno,max(sal) from emp group by deptno,job;`

## having

`where` 是在from后面执行的，类似于，先找到了表，再通过where排除了某些记录

`having` 可以对分完组的数据进一步过滤。

==`having` 不能单独使用，必须和`group by` 联合使用，而且其中可以使用分组函数，因为已经分过组了。==

`where` 去除的是某些不符合条件的记录，一条一条的记录

`having` 去除的是某些不符合条件的分组，即把一整个分组去掉了

效率分析：

​	**having的效率比较低，因此where和having优先选择where**

案例：求每个部门的最高薪资大于3000的

`select deptno,max(sal) from emp where sal>3000 group by deptno;`

`select deptno,max(sal) from emp group by deptno having max(sal)>3000;`

**where无法处理的则用having**

案例：求每个部门的平均薪资大于2500的

`select deptno,avg(sal) from emp group by deptno having avg(sal)>2500;`

## 总结

```
select
	...
from 
	...
where
	...
group by
	...
having
	...
order by
	...
```

执行顺序：from，where，group by，having，select，order by

`select job,avg(sal) from emp where job !='manager' group by job having avg(sal)>1500 order by avg(sal) desc;`

DQL永远都是查询，不会修改数据库
