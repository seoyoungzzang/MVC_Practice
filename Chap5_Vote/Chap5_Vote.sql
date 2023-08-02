use kopo34;

drop table hubo;
create table hubo(
id int not null,
name varchar(20),
primary key (id),
index(id));

drop table tupyo;
create table tupyo(
id int,
age int,
foreign key (id) references hubo (id) on delete cascade);

desc hubo;
desc tupyo;
desc examtable;

select * from hubo;

drop table hubo;

select * from tupyo;
