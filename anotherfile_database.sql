# comment
-- comment
/*
comment
comment
comment
*/
drop database if exists anotherfile_database;
create database anotherfile_database;
grant all on anotherfile_database.* to anotherfile_database_user@localhost identified by 'anotherpassword';
