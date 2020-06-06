/*
number:
- int
- float
- double
- int unsigned

string:
- char(4)
- varchar(255)
- text

date/time:
- date
- time
- datetime '2017-07-22 17:22:33'

true/false:
- boolean -> tinyint(1)
  true -> 1
  false -> 0
*/

drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20) unique,
  score float default 0.0
);

insert into users (name, score) values ('taguchi', 5.8);
insert into users (name, score) values ('fkoji', 8.2);
insert into users (name, score) values ('dot', 6.1);
insert into users (name, score) values ('Tanaka', 4.2);
insert into users (name, score) values ('yamada', null);
insert into users (name, score) values ('tashiro', 7.9);

/*
insert into users (id, name, score) values (1, 'taguchi', 5.8);
insert into users (id, name, score) values (2, 'fkoji', 8.2);
insert into users (id, name, score) values (3, 'dotinstall', 6.1);
insert into users (id, name, score) values (4, 'yamada', null);
insert into users (id, name) values (5, 'tanaka');
insert into users (id, name) values (6, 'tanaka');
*/
