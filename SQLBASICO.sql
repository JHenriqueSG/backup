create table CLIENTE
(
cod_cli		smallint	not null,
nome_cli		varchar(40)	not null,
endereco		varchar(40)	null,
cidade		varchar(20)	null,
cep		char(08)	null,
uf		char(02)	null,
primary key	(cod_cli));

create table VENDEDOR
(
cod_vend	smallint	not	null,
nome_vend	varchar(40)	not	null,
sal_fixo	numeric(9,2)	not	null,
faixa_comiss	char(01)	not	null,
primary key	(cod_vend));

create table PRODUTO
(
cod_prod	smallint	not	null,
unid_prod	char(03)	not null,
desc_prod	varchar(20)	not null,
val_unit	numeric(9,2)	not	null,
primary key	(cod_prod));		

create table PEDIDO
(
num_ped	smallint	not	null,
prazo_entr	smallint	not	null,
cd_cli	smallint	not	null REFERENCES CLIENTE (cod_cli),
cd_vend	smallint	not null REFERENCES VENDEDOR (cod_vend),
		primary key (num_ped));

create table ITEM_PEDIDO
(
no_ped	smallint	not null REFERENCES PEDIDO (num_ped),
cd_prod	smallint	not null REFERENCES PRODUTO (cod_prod),
qtd_ped	float		not null, 
primary key (no_ped, cd_prod));

insert into CLIENTE values (1000, 'Supermercado Carrefour', 'Av. das Américas', 'rio de janeiro', '20000001', 'rj');
insert into CLIENTE values (2000, 'Supermercado Baratao', 'Rua Rolando Lero', 'rio de janeiro', '20000002', 'rj');
insert into CLIENTE values (3000, 'Supermercado Arariboia', 'Rua Itaoca', 'niteroi', '20000003', 'rj');
insert into CLIENTE values (4000, 'UFF', 'Cidade Univers.', 'niteroi', '20000004', 'rj');
insert into CLIENTE values (5000, 'CSN', 'Rua do Aco', 'volta redonda', '20000005', 'rj');
insert into CLIENTE values (6000, 'Pegeout', 'Rodovia Pres. Dutra', 'resende', '20000006', 'rj');
insert into CLIENTE values (7000, 'Ind. Químicas Paulistas', 'Rua Tuiuti', 'sao paulo', '11000001', 'sp');
insert into CLIENTE values (8000, 'Ford Caminhoes', 'Rua Henry Ford', 'sao paulo', '11000002', 'sp');
insert into CLIENTE values (9000, 'Riocel Celulose', 'Rua Gen. Arouca', 'guaiba', '30000001', 'rs');
insert into CLIENTE values (10000, 'Elevadores Sur', 'Rua Planejada', 'guaiba', '30000001', 'rs');

insert into PRODUTO values (100, 'kg', 'Chapa de Aco', 2.5);
insert into PRODUTO values (200, 'kg', 'Cimento', 4.5);
insert into PRODUTO values (300, 'kg', 'parafuso 3.0X10.5 mm', 2);
insert into PRODUTO values (400, 'm', 'Fio plastico', .2);
insert into PRODUTO values (500, 'l', 'Solvente PRW', 5);


insert into VENDEDOR values (11, 'Paulo Alberto', 1500, 'b');
insert into VENDEDOR values (12, 'Ana Cristina', 2100, 'a');
insert into VENDEDOR values (13, 'Cassia Andrade', 900, 'c');
insert into VENDEDOR values (14, 'Armando Pinto', 2500, 'a');
insert into VENDEDOR values (15, 'Maria Paula', 900, 'c');



insert into PEDIDO values (1111, 10, 1000, 11);
insert into PEDIDO values (1112, 5, 1000, 11);
insert into PEDIDO values (1113, 30, 1000, 15);
insert into PEDIDO values (2111, 15, 3000, 14);
insert into PEDIDO values (2112, 18, 3000, 15);
insert into PEDIDO values (2113, 3, 3000, 12);
insert into PEDIDO values (3111, 13, 4000, 12);
insert into PEDIDO values (3112, 7, 4000, 11);
insert into PEDIDO values (4111, 7, 6000, 11);
insert into PEDIDO values (4112, 7, 6000, 14);
insert into PEDIDO values (5111, 10, 8000, 14);
insert into PEDIDO values (6111, 30, 9000, 14);
insert into PEDIDO values (6112, 60, 9000, 12);
insert into PEDIDO values (7111, 20, 10000, 15);


insert into ITEM_PEDIDO values (1111, 100, 100);
insert into ITEM_PEDIDO values (1111, 200, 100);
insert into ITEM_PEDIDO values (1111, 300, 200);
insert into ITEM_PEDIDO values (1112, 400, 100);
insert into ITEM_PEDIDO values (1112, 500, 1000);
insert into ITEM_PEDIDO values (1113, 100, 300);
insert into ITEM_PEDIDO values (2111, 100, 500);
insert into ITEM_PEDIDO values (2111, 500, 400);
insert into ITEM_PEDIDO values (2112, 200, 100);
insert into ITEM_PEDIDO values (2112, 300, 200);
insert into ITEM_PEDIDO values (2113, 500, 500);
insert into ITEM_PEDIDO values (3111, 400, 300);
insert into ITEM_PEDIDO values (3112, 100, 400);
insert into ITEM_PEDIDO values (3112, 200, 600);
insert into ITEM_PEDIDO values (4111, 300, 700);
insert into ITEM_PEDIDO values (4112, 500, 1000);
insert into ITEM_PEDIDO values (5111, 200, 100);
insert into ITEM_PEDIDO values (5111, 300, 500);
insert into ITEM_PEDIDO values (6111, 400, 100);
insert into ITEM_PEDIDO values (6112, 300, 400);
insert into ITEM_PEDIDO values (6112, 400, 200);
insert into ITEM_PEDIDO values (7111, 100, 500);



