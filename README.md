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
```
