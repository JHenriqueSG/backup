create database juncao
use juncao

create table funcionario(
	id_func int primary key,
	nome_func varchar(30) not null,
	id_cargo int
)

create table cargo(
	id_cargo int primary key,
	descricao_cargo varchar(30)
)

alter table funcionario add foreign key (id_cargo)
references cargo(id_cargo)

insert into cargo values (1,'Professor'), (2, 'Medico'), (3, 'Analista de Sistemas'), (4, 'Enfermeiro'), (5,'Diretor')
insert into funcionario values (1,'Rodrigo',1), (2,'Flavia',2), (3,'Joaquim',2),(4,'Carlos',null)

--Produto Cartesiano (CROSS JOIN)

select nome_func, descricao_cargo from cargo
cross join funcionario

select p.nome_func, q.nome_func from funcionario p
cross join funcionario q
where p.nome_func <> q.nome_func

--Junção onde há interseção(INNER JOIN)

select nome_func, descricao_cargo from funcionario
inner join cargo on funcionario.id_cargo = cargo.id_cargo

--Agrupar e filtrar 
select descricao_cargo, count(cargo.id_cargo) as QTD from cargo
join funcionario on funcionario.id_cargo = cargo.id_cargo
group by descricao_cargo
having count(cargo.id_cargo) > 1

--Junção interseção + lado esquerdo (LEFT JOIN)
--Listar todas as pessoas e seus cargos (mesmo que esteja sem ocupação)
select nome_func, descricao_cargo from funcionario
left join cargo on funcionario.id_cargo = cargo.id_cargo

--Listar todos os cargos e as pessoas que ocupam (listar cargo mesmo se ngm tiver ocupando)
select nome_func, descricao_cargo from cargo
left join funcionario on funcionario.id_cargo = cargo.id_cargo

--Junção interseção + lado direito (RIGHT JOIN)
--Mesmo efeito do left join, porém a posição das tabelas invertem 
--Listar todos os cargos e as pessoas que ocupam (listar cargo mesmo se ngm tiver ocupando)
select nome_func, descricao_cargo from funcionario
right join cargo on funcionario.id_cargo = cargo.id_cargo

--Listar todas as pessoas e seus cargos (mesmo que esteja sem ocupação)
select nome_func, descricao_cargo from cargo
right join funcionario on funcionario.id_cargo = cargo.id_cargo

--LEFT JOIN + RIGHT JOIN = FULL JOIN
select nome_func, descricao_cargo from cargo
full join funcionario on funcionario.id_cargo = cargo.id_cargo

--Todos os cargos sem funcionários e funcionarios sem cargo
select nome_func, descricao_cargo from cargo
full outer join funcionario on funcionario.id_cargo = cargo.id_cargo
where funcionario.id_cargo is null or cargo.id_cargo is null

--Selecionar todo cargo que não possui nenhum funcionario
select * from cargo where id_cargo not in (select id_cargo from funcionario where id_cargo is not null) 


create table pais(
	id_pais int primary key,
	nome_pais varchar(30) not null
)

create table estado(
	id_estado int primary key,
	nome_estado varchar(30) not null,
	id_pais int
)

create table municipio(
	id_municipio int primary key,
	nome_municipio varchar(30),
	id_estado int
)

alter table estado add foreign key(id_pais)
references pais(id_pais)

alter table municipio add foreign key(id_estado)
references estado(id_estado)

insert into pais values (1,'Brasil'),(2,'Argentina'),(3,'Chile')
insert into estado values (10, 'Minas Gerais',1),
						  (20, 'São Paulo',1),
						  (30, 'Rio de Janeiro',1),
						  (40, 'Lo Lombrelo',2),
						  (50, 'La Luna',2),
						  (60, 'SEM PAIS',null)

insert into municipio values (101,'Belo Horizonte',10),
							 (201,'J. Monlevade',10),
							 (301,'Itabira',10),
							 (401,'Bauru',20),
							 (501,'Piracicaba',20),
							 (601,'São Paulo',20),
							 (701,'La Cuna',40),
							 (801,'La Casa',40)

--a) Selecionar todos os paises que não possuem estados cadastrados

--b) Selecionar todos os estados e seus respectivos paises (mostrar estado mesmo se não estiver vinculado a um país)

--c) Qual consulta combina todos os paises e estados cadastrados (produto cartesiano)

--d) Selecionar todos os paises sem estados e estados sem paises

--e) Mostrar o nome de cada municipio e os estado que pertence.  

--f) Mostrar o nome de cada municipio e os estados que pertence.  Também deve ser mostrado o nome dos estados que não possuem municipio e os 
--municipios que não possuem estado

--g) Mostrar o nome de todos os paises que possui mais de um municipio cadastrado. 
