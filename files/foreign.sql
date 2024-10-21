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