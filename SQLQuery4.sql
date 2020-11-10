create database exercicio24_102
use exercicio24_102

create table projeto(ID_proj DECIMAL(4,0) PRIMARY KEY,
NomeProj VARCHAR(30), Localização VARCHAR(30), FK_ID_Depto DECIMAL(2,0))

create table trabalha(ID_func DECIMAL(4,0), ID_Proj DECIMAL(4,0), NUmHoras DECIMAL(6,1), 
PRIMARY KEY(ID_Func, ID_Proj))

create table funcionario(ID_Func DECIMAL(4,0) PRIMARY KEY, NomeFunc VARCHAR(30), 
Endereço VARCHAR(50), DataNasc DATE, ID_Superv DECIMAL(8,2), FK_ID_Depto DECIMAL(2,0),
Sexo CHAR(1), Salario DECIMAL(4,0))

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
add foreign key (ID_Superv)
references funcionario(ID_Func)