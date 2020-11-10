create database exercicio_08_11_2018
use exercicio_08_11_2018 

create table planeta(
ID_planeta int primary key, Nome_planeta varchar(30), Descri��o varchar (100), ID_sistema int)

create table ra�a(
ID_ra�a int primary key, Nome_ra�a varchar(30), Data_des DATE, Descri��o varchar(100))

create table sistema(
ID_sistema int primary key, Descri��o varchar(100))

create table habitado(
ID_planeta int not null, ID_ra�a int not null)

alter table habitado add foreign key (ID_planeta) references planeta(ID_planeta)

alter table habitado add foreign key (ID_ra�a) references ra�a(ID_ra�a)

alter table habitado add primary key (ID_ra�a, ID_planeta)

alter table planeta add foreign key (ID_sistema) references sistema(ID_sistema)
--2 inserir duas tuplas em cada tabela

insert into planeta values(1, 'terra', 'habitado', 1), (2, 'marte', '?????', 1)

insert into ra�a values(1, 'humanos',  '01-01-0001', 'inteligente'), (2, 'macacos','01-01-0001','animal') 

INSERT into sistema values(1, 'solar'), (2, 'outro') 

insert into habitado values(1, 1), (2, 2)
--3 atualizar a data de todas as ra�as para 01-01-2001
update ra�a set Data_des =  '01-01-2001'

--4 selecionar todas as ra�as do sistema solar

select ra�a.ID_ra�a as 'ra�a', planeta.Nome_planeta as 'planeta', sistema.Descri��o from ra�a
join habitado on habitado.ID_ra�a = ra�a.ID_ra�a
join planeta on planeta.ID_planeta  = habitado.ID_planeta
join sistema on planeta.ID_sistema = sistema.ID_sistema
where sistema.Descri��o = 'solar'

select sistema.Descri��o, 
count(planeta.Nome_planeta) from planeta
join sistema on planeta.ID_sistema = sistema.ID_sistema
group by sistema.Descri��o

--5 mostrar quantas ra�as existem em cada planeta
select Nome_planeta, count(ra�a.Nome_ra�a) from planeta
join habitado on habitado.ID_planeta = planeta.ID_planeta
join ra�a on ra�a.ID_ra�a = habitado.ID_ra�a
group by Nome_planeta

