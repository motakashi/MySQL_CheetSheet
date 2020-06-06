drop database if exists myapp;
create database myapp;
grant all on myapp.* to myapp_user@localhost identified by 'password';
