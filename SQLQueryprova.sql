create database exercicio_08_11_2018
use exercicio_08_11_2018 

create table planeta(
ID_planeta int primary key, Nome_planeta varchar(30), Descrição varchar (100), ID_sistema int)

create table raça(
ID_raça int primary key, Nome_raça varchar(30), Data_des DATE, Descrição varchar(100))

create table sistema(
ID_sistema int primary key, Descrição varchar(100))

create table habitado(
ID_planeta int not null, ID_raça int not null)

alter table habitado add foreign key (ID_planeta) references planeta(ID_planeta)

alter table habitado add foreign key (ID_raça) references raça(ID_raça)

alter table habitado add primary key (ID_raça, ID_planeta)

alter table planeta add foreign key (ID_sistema) references sistema(ID_sistema)
--2 inserir duas tuplas em cada tabela

insert into planeta values(1, 'terra', 'habitado', 1), (2, 'marte', '?????', 1)

insert into raça values(1, 'humanos',  '01-01-0001', 'inteligente'), (2, 'macacos','01-01-0001','animal') 

INSERT into sistema values(1, 'solar'), (2, 'outro') 

insert into habitado values(1, 1), (2, 2)
--3 atualizar a data de todas as raças para 01-01-2001
update raça set Data_des =  '01-01-2001'

--4 selecionar todas as raças do sistema solar

select raça.ID_raça as 'raça', planeta.Nome_planeta as 'planeta', sistema.Descrição from raça
join habitado on habitado.ID_raça = raça.ID_raça
join planeta on planeta.ID_planeta  = habitado.ID_planeta
join sistema on planeta.ID_sistema = sistema.ID_sistema
where sistema.Descrição = 'solar'

select sistema.Descrição, 
count(planeta.Nome_planeta) from planeta
join sistema on planeta.ID_sistema = sistema.ID_sistema
group by sistema.Descrição

--5 mostrar quantas raças existem em cada planeta
select Nome_planeta, count(raça.Nome_raça) from planeta
join habitado on habitado.ID_planeta = planeta.ID_planeta
join raça on raça.ID_raça = habitado.ID_raça
group by Nome_planeta

