use kopo34;

drop table gongji;
create table gongji(
id int not null primary key auto_increment,
title varchar(70),
date date,
content text);

desc gongji;

select * from gongji;

