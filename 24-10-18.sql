/*1) Criar as tabelas e suas depend�ncias (Chave estrangerias)*/

create database exercicio24_10_2018
use exercicio24_10_2018

create table projeto(ID_proj DECIMAL(4,0) PRIMARY KEY,
NomeProj VARCHAR(30), Localiza��o VARCHAR(30), FK_ID_Depto DECIMAL(2,0))

create table trabalha(ID_func DECIMAL(4,0) not null, ID_Proj DECIMAL(4,0) not null, NUmHoras DECIMAL(6,1), 
PRIMARY KEY(ID_Func, ID_Proj))

create table funcionario(ID_Func DECIMAL(4,0) PRIMARY KEY, NomeFunc VARCHAR(30), 
Endere�o VARCHAR(50), DataNasc DATE, FK_ID_Superv DECIMAL(4,0), FK_ID_Depto DECIMAL(2,0),
Sexo CHAR(1), Salario DECIMAL(8,2))

create table dependente(ID_Dep DECIMAL(6,0) primary key, FK_ID_Func DECIMAL(4,0), NomeDep VARCHAR(30), 
DataNasc DATE, Sexo CHAR(1), Parentesco CHAR(15))

create table departamento(ID_Depto DECIMAL(2,0) PRIMARY KEY, NomeDepto VARCHAR(30),
ID_Gerente DECIMAL(4,0))

alter table projeto
add foreign key (FK_ID_Depto)
references departamento (ID_Depto)

alter table trabalha
add foreign key (ID_Func)
references funcionario(ID_Func)
alter table trabalha
add foreign key (ID_Proj)
references projeto(ID_Proj)

alter table funcionario
add foreign key (FK_ID_Depto)
references departamento(ID_Depto)
alter table funcionario
add foreign key (FK_ID_Superv)
references funcionario(ID_Func)

alter table dependente
add foreign key(FK_ID_Func)
references funcionario(ID_Func)

alter table departamento
add foreign key(ID_Gerente)
references funcionario(ID_Func)

/*2) Inserir 3 departamentos, sendo eles (constru��o, computa��o e pesquisa).*/

insert into departamento (ID_Depto, NomeDepto)
values (1, 'constru��o')
insert into departamento (ID_Depto, NomeDepto)
values (2, 'computa��o')
insert into departamento (ID_Depto, NomeDepto)
values (3, 'pesquisa')

/*30  Inserir 5 funcion�rios*/
insert into funcionario(ID_Func, NomeFunc, Endere�o, DataNasc, Sexo, Salario, FK_ID_Depto)
values (1, 'Maria', 'jardim 1', '1987-07-03', 'F', 3000.00, 3)
insert into funcionario(ID_Func, NomeFunc, Endere�o, DataNasc, Sexo, Salario, FK_ID_Depto)
values (2, 'Jo�o', 'jardim 2', '1980-12-10', 'M', 3000.00, 2)
insert into funcionario(ID_Func, NomeFunc, Endere�o, DataNasc, Sexo, Salario, FK_ID_Depto)
values (3, 'Carlos', 'jardim 3', '1978-05-11', 'M', 2500.00, 1)
insert into funcionario(ID_Func, NomeFunc, Endere�o, DataNasc, Sexo, Salario, FK_ID_Depto)
values (4, 'Daniel', 'jardim 1', '1988-10-21', 'M', 5000.00, 1)
insert into funcionario(ID_Func, NomeFunc, Endere�o, DataNasc, Sexo, Salario, FK_ID_Depto)
values (5, 'Clara', 'jardim 3', '1990-11-24', 'F', 4500.00, 3)
update funcionario
set FK_ID_Superv = 4
where NomeFunc <> 'Daniel'
update funcionario
set FK_ID_Superv = null
where ID_Func = 4

/*4) Inserir 10 diferentes rela��es de trabalho projeto (tabela trabalha)*/
insert into projeto (ID_proj, NomeProj, Localiza��o, FK_ID_Depto)
values (1, 'edificio', 'Belo Horizonte', 1)
insert into projeto (ID_proj, NomeProj, Localiza��o, FK_ID_Depto)
values (2, 'planta baixa', 'Belo Horizonte', 2)
insert into projeto (ID_proj, NomeProj, Localiza��o, FK_ID_Depto)
values (3, 'estudo de area', 'Belo Horizonte', 3)

insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (1, 4, 200)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (2, 3, 400)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (3, 4, 350)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (1, 5, 450)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (2, 3, 600)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (3, 5, 1000)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (1, 2, 360)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (2, 1, 400)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (3, 2, 400)
insert into trabalha(ID_Proj, ID_func, NUmHoras)
values (2, 1, 400)

/*5) Inserir 5 dependentes.*/
insert into dependente (ID_Dep, FK_ID_Func, NomeDep, DataNasc, Sexo, Parentesco)
values (5, 5, 'jos�', '1990-01-01', 'M', 'conjuge')
insert into dependente (ID_Dep, FK_ID_Func, NomeDep, DataNasc, Sexo, Parentesco)
values (1, 4, 'laura', '1988-02-01', 'F', 'conjuge')
insert into dependente (ID_Dep, FK_ID_Func, NomeDep, DataNasc, Sexo, Parentesco)
values (2, 5, 'cris', '2008-01-01', 'f', 'filha')
insert into dependente (ID_Dep, FK_ID_Func, NomeDep, DataNasc, Sexo, Parentesco)
values (3, 5, 'julio', '2012-01-01', 'M', 'filho')
insert into dependente (ID_Dep, FK_ID_Func, NomeDep, DataNasc, Sexo, Parentesco)
values (4, 3, 'ana', '1989-01-01', 'M', 'conjuge')
select * from dependente
/*6) Listar nome dos Gerentes dos projetos que est�o sob a ger�ncia do departamento constru��o*/
update departamento
set ID_Gerente = 4
where ID_Depto = 1

select NomeFunc, NomeDepto from funcionario
join departamento
on funcionario.ID_Func = departamento.ID_Gerente
where NomeDepto = 'constru��o'

/*7) Nome de todos os funcion�rios que trabalham em um projeto sob a ger�ncia do departamento
contru��o. (Usar subquery)*/
select NomeFunc from funcionario
where  FK_ID_Depto in(select ID_Depto from departamento where ID_Depto in
(select FK_ID_Depto from projeto where NomeDepto = 'constru��o'))

/*8) Contabilizar total de dependentes dos funcion�rios do departamento pesquisa.(subquery)*/
select count(ID_Dep) from dependente
where FK_ID_Func in (select ID_Func from funcionario where FK_ID_Depto in
(select ID_Dep from departamento where ID_Depto = 3))
group by FK_ID_Func

/*9) Contabilizar o n�mero de funcion�rios por projeto (join)*/
select COUNT(ID_Func) 'Funcionarios', NomeProj 'projeto'  from funcionario
join departamento
on funcionario.FK_ID_Depto = departamento.ID_Depto
join projeto on departamento.ID_Depto = projeto.FK_ID_Depto
group by NomeProj

select * from dependente
