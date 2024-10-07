# MySQL

> 国内互联网公司一般使用mysql，免费轻量

[toc]

## 了解数据库

1. 数据库DataBase(DB)：按照一定格式存储数据的一些文件的组合

2. 数据库管理系统DataBaseManagement(DBMS)：专门用于管理数据库中的数据，可以对数据库的数据增删改查                       常见系统：MySQL、Oracle、MS SqlServer、DB2、sybase等

3. SQL：结构化查询语句。是一套标准，可以在不同的DBMS中使用。

​	程序员需要编写SQL语句，然后DBMS负责执行SQL语句，最终完成数据库中数据的增删改查。

==关系：DBMS--执行-->SQL--操作-->DB==

## 安装MySQL

Oracle官网找community版本下载，然后配置Configurator，下一步下一步.....

### 端口号

端口号port：任何网络软件应用都会有的，是应用的唯一代表

端口号通常和IP地址在一块，IP地址用来定位计算机，port端口号用来定位应用程序

同一台计算机上，端口号不能重复，具有唯一性。

mysql数据库默认占用3306端口号

### 字符编码方式

设置mysql数据库的字符编码方式为UTF-8

### 服务名称

默认是MySQL90，不用修改。

默认是自动启动状态（下次重启操作系统时自动启动），只有启动了才可以使用mysql。

通过命令CMD管理员启动：

```
net stop 服务名称;
net start 服务名称;
```

其他的服务也可以这样启停

### 超级管理员

用户名必须为root不可更改，密码自己设置

### 卸载

双击安装包卸载，Remove。再把programData和Program File x86文件夹下的MySQL目录删除

C:\Users\F\Downloads\mysql-9.0.1.msi

##　登录MySQL

* 运行MySQL 9.0 Command Line Client程序，输入密码即可
* 在命令行输入mysql -uroot -p20031122 实现本地登录

## MySQL常用命令

> ==**MySQL命令不区分大小写**==

1. `exit`	退出
2. `mysql -uroot -p`   登录(隐藏密码)
3. `show databases;`   查看数据库，databases是复数

mysql默认自带了四个数据库

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

4. `use test;`  选择使用数据库test，显示Database changed，表示正在使用test数据库
5. `create database 数据库名称;`  创建数据库
6. `show tables;`   查看数据库下有哪些表，tables是复数

## 表

数据库当中最基本的单元是表：table

数据库中以表格的形式表示数据

行(row)：数据/记录

列(column)：字段（有字段名、数据类型、约束等）（唯一性约束：不能重复）

## SQL语句分类

* DQL：数据查询语言          含select关键字			
* DML：数据操作语言          主要对表中的数据进行增删改查insert、delete、update
* DDL：数据定义语言          主要修改表的结构而非数据create、drop、alter
* TCL：事物控制语言          事物提交commit事物回滚rollback
* DCL：数据控制语言          授权grant撤销权限revoke

## 导入数据.sql至数据库表

`source 路径`	路径中不含中文

## 查看表中的数据

`select * from 表名;`	统一执行这个SQL语句

## 查看表的结构describe

`desc 表名;`	查看表的结构(describe也行)

```
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| EMPNO    | int         | NO   | PRI | NULL    |       |
| ENAME    | varchar(10) | YES  |     | NULL    |       |
| JOB      | varchar(9)  | YES  |     | NULL    |       |
| MGR      | int         | YES  |     | NULL    |       |
| HIREDATE | date        | YES  |     | NULL    |       |
| SAL      | double(7,2) | YES  |     | NULL    |       |
| COMM     | double(7,2) | YES  |     | NULL    |       |
| DEPTNO   | int         | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
```

字段名，数据类型（varchar是java中的String类型）

## 常用命令

1. `select version();`		查看数据库版本号
2. `select database();`      查看当前使用的是哪个数据库
3. 默认命令以分号结束，如果要终止，则在末尾输入`\c` ，然后回车
4. `\q` `quit` `exit` 都可以退出mysql

