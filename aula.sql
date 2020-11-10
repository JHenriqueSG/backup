	 create database restricao
use restricao



create table pessoa(
	chave int primary key identity(1,1),
	nome varchar(40) not null,
	sexo char(1) check (sexo in ('F','M')),
	cpf char(11) unique,
	pin char(6) default '123456'
)

create table engenheiro(
	chave int not null identity(1,1),
	fk_pessoa int,
	crea varchar not null,
	constraint pk_engenheiro primary key(chave),
	constraint fk_pessoa_engenheiro foreign key(fk_pessoa) references pessoa(chave)
)

insert into pessoa(nome,sexo,cpf) values ('Rodrigo','M','00011100011')
insert into pessoa(chave,nome,sexo,cpf)values (2,'Pedro','M','11111100011')

select * from pessoa
--permitir passar id mesmo com identity
SET IDENTITY_INSERT pessoa on
insert into pessoa(chave,nome,sexo,cpf)values (2,'Pedro','M','11111100011')

SET IDENTITY_INSERT engenheiro off

--verificando onde houve erro, olhe a mensagem em vermelho que será gerada 
insert into pessoa(chave,nome,sexo,cpf)values (2,'Pedro','M','11111100011')

--precisamos inserir dois engenheiros, porem o campo crea foi criado sem tamanho, como modificar? 
alter table engenheiro alter column crea varchar(10) not null

--agora quero passar o id, então deveria ativar o identity_insert, porém...
SET IDENTITY_INSERT engenheiro ON

--o jeito certo de fazer
SET IDENTITY_INSERT pessoa OFF
SET IDENTITY_INSERT engenheiro ON

--agora inserindo engenheiro, verificar o erro que sera gerado
insert into engenheiro(chave,fk_pessoa,crea) values(1,1,'0101')
insert into engenheiro(chave,fk_pessoa,crea) values(1,2,'0909')

--na verdade eu precisava que a chave da tabela engenheiro + pk_pessoa fosse uma chave primaria composta
--tenho que apagar tudo e refazer? Não

--a) apago chave primária
alter table engenheiro drop constraint pk_engenheiro

--b) crio novamente (chave primária precisa ser not null)
alter table engenheiro alter column fk_pessoa int not null
alter table engenheiro add constraint pk_engenheiro primary key(chave,fk_pessoa)

select * from engenheiro

--problemas ao alterar chave primaria em pessoa
--1) já existe uma ligação com dados feita com outra tabela
--2) tenho que verificar o nome criado para o SGBD para a restrição de pk
alter table pessoa drop constraint PK__pessoa__52ACE05BB22EA7E2

--toda constraint pode ter nome (esse exemplo é apenas didático...)
create table projeto(
	chave int not null identity(1,1),
	CEA int not null,
	KDD int not null,
	engenheiro_responsavel int not null,
	pessoa_responsavel int not null,
	constraint tipo_CEA check (CEA > 0 and KDD > 0),
	constraint pk_projeto primary key(chave),
	constraint fk_projeto_engenheiro foreign key(engenheiro_responsavel,pessoa_responsavel) 
	references engenheiro(chave,fk_pessoa)
)

insert into projeto values(12,13,1,1)

select * from projeto

--imagina que para alguns usuários do BD é necessário fornecer apenas o nome do projeto e o crea do responsavel
--como fazer isso? View seria uma opcao...

create view responsavel as select p.CEA as PROJETO, e.crea as CREA from projeto p
						   join engenheiro e 
						   on p.engenheiro_responsavel = e.chave and
						      p.pessoa_responsavel = e.fk_pessoa

select * from responsavel where projeto = 12

--order by + view
create view responsavel2 as select p.CEA as PROJETO, e.crea as CREA from projeto p
						   join engenheiro e 
						   on p.engenheiro_responsavel = e.chave and
						      p.pessoa_responsavel = e.fk_pessoa
	                       order by p.CEA

create view responsavel2 as select top 3 p.CEA as PROJETO, e.crea as CREA from projeto p
						   join engenheiro e 
						   on p.engenheiro_responsavel = e.chave and
						      p.pessoa_responsavel = e.fk_pessoa
	                       order by p.CEA

--se essa consulta fosse complexa, porém com filtro?
CREATE FUNCTION f_responsavel (@CEA INT)
RETURNS TABLE
AS
RETURN
(select p.CEA as PROJETO, e.crea as CREA from projeto p
						   join engenheiro e 
						   on p.engenheiro_responsavel = e.chave and
						      p.pessoa_responsavel = e.fk_pessoa
						   where p.CEA = @CEA)  

select * from f_responsavel(11)
select * from f_responsavel(12)

--funcao com retorno escalar

create function f_teste(@engenheiro int)
returns int
as begin
	declare @quantidade int;
	select @quantidade = count(*) from projeto 
		where projeto.engenheiro_responsavel = @engenheiro;
	if (@quantidade is null)
		set @quantidade = 0;
	return @quantidade;
end

select e.crea, dbo.f_teste(e.chave) as QTD from engenheiro e

--vamos testar inserindo um novo engenheiro em dois projetos
SET IDENTITY_INSERT pessoa OFF
SET IDENTITY_INSERT engenheiro OFF
SET IDENTITY_INSERT pessoa ON

insert into pessoa(chave, nome,sexo,cpf) values (100,'Engenheiro','M','9999999999')
insert into engenheiro values (100,'999')
select * from engenheiro 
--antes de executar as linhas abaixo verifique o id do engenheiro cadastrado
--insert into projeto values(CEA,KDD,ENG,PESSOA)
insert into projeto values (1000, 1000,2,100)
insert into projeto values (1001, 1001,2,100)

select e.crea, dbo.f_teste(e.chave) as QTD from engenheiro e


--nova base de dados

create table produto(
	chave int not null identity(1,1),
	descricao varchar(30) not null,
	codigo_barra varchar(30) not null unique,
	preco_normal decimal(10,2) not null,
	preco_promocao decimal(10,2) default 0,
	constraint pk_produto primary key(chave)
)

insert into produto values ('coca-cola','456789','3.00','3.00'),
						   ('pao','-------','0.50','0.5'),
						   ('canela','987654678','2.00','2.00'),
						   ('sabão','7654765','1.00','1.00')

alter procedure desconto 
	@produto int,
	@desconto decimal(3,2)
as begin
	declare @chave int, @desc varchar(30), @cod varchar(30)
	declare @preco_a decimal(10,2), @preco_d decimal(10,2)	 

	IF @produto = -1
		declare v_produtos cursor static for (select * from produto)
	else
		declare v_produtos cursor static for (select * from produto where chave = @produto)
	
	open v_produtos
	fetch next from v_produtos into @chave,@desc,@cod,@preco_a,@preco_d;		
	while @@FETCH_STATUS = 0
	begin
		print '-----------------------------------------------------------------'
		print 'Produto: ' + @desc
		print 'Preço Normal: ' + convert(varchar(6),@preco_a)
		print 'Antiga promoção: '+ convert(varchar(6),@preco_d )
		set @preco_d = @preco_a * (1 - @desconto)
		print 'Nova promoção : ' + convert(varchar(6),@preco_d)
		update produto set preco_promocao = @preco_d where chave = @chave
		fetch next from v_produtos into @chave,@desc,@cod,@preco_a,@preco_d;	
	end
	close v_produtos
	deallocate v_produtos
end

exec desconto -1,0.1