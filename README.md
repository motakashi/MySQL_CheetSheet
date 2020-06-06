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
  rank enum('gold', 'silver', 'bronze')
  coins set('gold', 'silver', 'bronze')
);
```

### データ挿入
```
insert into users (id, name, score) values (1, 'motakashi', 2.0);
```

### データ表示
```
select * from users;
select name as user, score as point from users order by point desc;

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

### レコードの更新
```
update users set name = 'sasaki', score = 2.9 where name = 'tanaka';
```

### レコードの削除
```
delete from users where score < 5.0;
```

### 数値計算
```
update users set score = score * 1.2 where id % 2 = 0;

select round(5.355); -- 5
select round(5.355, 1); -- 5.4
select floor(5.833); -- 5
select ceil(5.238); -- 6

# ランダム表示
select rand();
select * from users order by rand() limit 1;
```

### 文字列操作
```
select length('Hello'); -- 5
select substr('Hello', 2); -- ello
select substr('Hello', 2, 3); -- ell
select upper('Hello'); -- HELLO
select lower('Hello'); -- hello
select concat('hello', 'world'); -- helloworld

# 文字列でソート
select length(name), name from users order by length(name);
select length(name) as len, name from users order by len;
```

### データの内容によってselectの表示をわかりやすく見せる(if,case)
```
select
  name,
  score,
  if (score > 5.0, 'OK', 'NG') as result
from
  users;

select
  name,
  score,
  case floor(score) % 2
    when 0 then 'even'
    when 1 then 'odd'
    else null
  end as type
from
  users;

select
  name,
  score,
  case
    when score > 8.0 then 'Team-A'
    when score > 6.0 then 'Team-B'
    else 'Team-C'
  end as team
from
  users;
```

### 抽出結果をテーブルにする
```
# 単純なselectによるテーブル作成
create table users_copy select * from users;

# テーブル構造作成
create table users_with_team as
select
  id,
  name,
  score,
  case
    when score > 8.0 then 'Team-A'
    when score > 6.0 then 'Team-B'
    else 'Team-C'
  end as team
from users;

# テーブル構造のみコピー
create table users_empty like users;
```

### データ集計
```
# 行数確認
select count(*) from users_with_team;
# カラム内にデータがある行数を確認
select count(score) from users_with_team;

# カラムのデータの合計、最小値、最大値、平均
select sum(score) from users_with_team;
select min(score) from users_with_team;
select max(score) from users_with_team;
select avg(score) from users_with_team;

# カラムの重複データを省いたデータを表示
select distinct team from users_with_team;
# カラムの重複データを省いたデータの数を表示
select count(distinct team) from users_with_team;
```

### グルーピングによる集計(group by, having)
```
# グルーピング
select sum(score), team from users_with_team group by team;
select sum(score), team from users_with_team group by team desc;

# グルーピング対象のデータの条件を追加したい場合
select sum(score), team from users_with_team group by team having sum(score) > 10.0;

# グルーピング対象以外のカラムのデータで条件を追加したい場合
select sum(score), team from users_with_team where id > 3 group by team;
```

### 一時的に集計のためだけのテーブルを作成する（サブクエリ）
```
select
  sum(t.score),
  t.team
from
  (select
    id,
    name,
    score,
    case
      when score > 8.0 then 'Team-A'
      when score > 6.0 then 'Team-B'
      else 'Team-C'
    end as team
  from users) as t 
group by t.team;
```

### 抽出条件の保存(view)
```
# 条件の保存
create view top3 as select * from users order by score desc limit 3;

# viewの実行
select * from top3;

# viewの確認
show tables;

# viewの設定内容を確認したい場合 (AS以降が設定内容になる)
show create view top3;
```

### トランザクション(一連の処理として実行したい場合)
```
start transaction;
(処理に問題がなければ)commit;
(処理に問題があれば)rollback;
```

### インデックスの作成・削除
```
alter table <テーブル名> add index <インデックス名> (<インデックスをつけたいカラム名>);

# インデックスの確認
-- show index from <テーブル名>;

# selectでインデックスがきいているかの確認
explain select * from users where score > 5.0;

# インデックスの削除
alter table <テーブル名> drop index <インデックス名>;
```

### 2つのテーブルに共通するデータを取り出す（内部結合）
```
select * from <テーブルA> inner join <テーブルB> on <テーブルA>.id = <テーブルB>.post_id;
# inner joinのinnerは省略できます
select * from posts join comments on posts.id = comments.post_id;

select posts.id, posts.title, posts.body, comments.body from posts join comments on posts.id = comments.post_id;
# どちらかにしかないカラム名は、テーブル名を省略できます
select posts.id, title, posts.body, comments.body from posts join comments on posts.id = comments.post_id;
```

### どちらかのテーブルにあるデータをベースにデータを結合する（外部結合）
```
# leftの場合はテーブルAにあるデータを軸に結合する
select * from <テーブルA> left outer join <テーブルB> on <テーブルA>.id = <テーブルB>.post_id;
# outer joinのouterは省略できます

select * from posts left join comments on posts.id = comments.post_id;
# rightの場合はテーブルBにあるデータを軸に結合する
-- select * from <テーブルA> right outer join <テーブルB> on <テーブルA>.id = <テーブルB>.post_id;
```
