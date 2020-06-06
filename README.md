# MySQL_CheetSheet

## データベース操作
```
[vagrant@localhost mysql_lessons]$ mysql -u root
mysql> show databases;

mysql> create database mydb01;

mysql> drop database mydb03;

mysql> use mydb02;

mysql> select database();
```

## 作業用ユーザー設定
### アカウント追加
```
mysql> create user user@localhost identified by 'password';

mysql> grant all on mydb01.* to user@localhost;

mysql> quit;

[vagrant@localhost mysql_lessons]$ mysql -u user -p

mysql> select user();

mysql> show databases;

mysql> quit;
```

### アカウント追加
```
[vagrant@localhost mysql_lessons]$ mysql -u root

mysql> drop user user@localhost;
```

### 外部ファイルからのコマンド実行
```
# パターン1
[vagrant@localhost mysql_lessons]$ mysql -u root < anotherfile_database.sql
[vagrant@localhost mysql_lessons]$ mysql -u anotherfile_user -p
mysql> quit;

# パターン2
[vagrant@localhost mysql_lessons]$ mysql -u root
mysql> \. ./anotherfile_database.sql
```

### テーブル操作
```
[vagrant@localhost mysql_lessons]$ mysql -u myapp_user -p

mysql> use myapp;

mysql> \. ./myapp.sql

mysql> show tables;

# テーブル構造の確認
mysql> desc users;

mysql> drop table users;
```

### テーブル作成
```
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20) unique,
  -- score float not null
  score float default 0.0
);
```

### データ挿入
```
insert into users (id, name, score) values (1, 'motakashi', 2.0);
```

### データ表示
```
select * from users;

# 条件抽出
select * from users where name = 'taguchi' or name = 'fkoji';
select * from users where name in ('taguchi', 'fkoji');
select * from users where name = 'taguchi';
select * from users where name like 't%';
select * from users where name like '%a%';
select * from users where name like '%a';
select * from users where name like 'T%';
select * from users where name like binary 'T%';
select * from users where name like '______';
select * from users where name like '_a%';

# 並び換え
select * from users order by score;
select * from users where score is not null order by score desc;

# 件数制限
select * from users limit 3;
select * from users limit 3 offset 3;
select * from users order by score desc limit 3;
```

### テーブル構造の変更
```
# カラムの追加
alter table users add column email varchar(255) after name;

# カラムの削除
alter table users drop column score;

# カラムの設定の変更
alter table users change name user_name varchar(80) default 'nobody';

# テーブル名の変更
alter table users rename persons;
```
