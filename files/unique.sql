drop table if exists t_vip;
create table t_vip(
    id int,
    name varchar(255) unique
);
insert into t_vip values(1,'zhangsan');
insert into t_vip values(2,'lisi');
