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
  id int unsigned,
  name varchar(20),
  score float
);
