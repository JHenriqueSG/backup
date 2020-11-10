/*1. Listar todos os equipamentos*/
use aula3
select * from T_EQUIPAMENTO

/*2. Listar os códigos e os nomes das companhias.*/
select CDCIA, NMCIA from T_COMPANHIA

/*3. Listar os números, a data/hora de saída dos vôos que partem a meia-noite*/
select NRVOO, dtsaida,(hrsaida) from T_VOO
Where hrsaida = '00:00:00'
/*where datepart(hour,hrsaida) = '0' and datepart(minute,hrsaida) = '0'*/

/*4. Listar os nomes dos clientes brasileiros*/
select NMCLI from T_CLIENTE
where CDPAIS_CLI =(select cdpais from t_pais where nmpais = 'BRASIL')

/* ou 
select NMCLI from T_CLIENTE
join T_PAIS
on T_CLIENTE.CDPAIS_CLI = T_PAIS.CDPAIS
where NMPAIS = 'BRASIL'*/

/*5. Listar os códigos e nomes dos equipamentos que tiverem mais de 1 motor.*/
select CDEQU, NMEQP from T_EQUIPAMENTO
where QTMOTOR > 1

/*6. Listar os números, a data/hora de saída dos vôos que atendem as rotas 001, 002, 003. */
select NRVOO, DTSAIDA, HRSAIDA from T_VOO
join T_ROTA
on T_VOO.NRROTA_VOO = T_ROTA.NRROTA_VOO
where T_VOO.NRROTA_VOO in (001,002,003)

/*7. Listar os nomes dos clientes nascidos no ano de 1992.*/
select NMCLI, DTNASC_CLI from T_CLIENTE
where DTNASC_CLI like '%1992%'

/*8. Listar sem repetição os números dos vôos em que algum cliente viajou sem desconto.*/
select distinct NRVOO_RSV from T_RESERVA
where PCDESC_RSV is null;


/*9. Listar os códigos dos equipamentos com a quantidade de motores desconhecida*/
select CDEQU, QTMOTOR from T_EQUIPAMENTO
where QTMOTOR is null

/*10. Listar o código dos clientes de sexo conhecido.*/
select CDCLI, IDSEX_CLI from T_CLIENTE
where IDSEX_CLI is not null

/*11. Listar os números das rotas que partem dos aeroportos GALEÃO (GIG), SANTOS
DUMONT (SDU), ou GUARULHOS (GRU) */
select NRROTA_VOO, CDAEROP_ORI from T_ROTA
join T_AEROPORTO
on T_AEROPORTO.CDAEROP = T_ROTA.CDAEROP_ORI
where CDAEROP_ORI IN ('GRU', 'SDU', 'GIG');


/*12. Listar os números das rotas que não chegam aos aeroportos SANTOS DUMONT (SDU),
GALEÃO (GIG), CONFINS (CNF) ou GUARULHOS (GRU).*/
select NRROTA_VOO, CDAEROP_DES from T_ROTA
join T_AEROPORTO
on T_AEROPORTO.CDAEROP = T_ROTA.CDAEROP_DES
where CDAEROP_DES not in ('GRU', 'SDU', 'CNF', 'GIG');

/*13. Listar os números, a data/hora de saída dos vôos que partam antes das 6 da manhã e não atendem as 
rotas 001, 002, 003.*/
select NRROTA_VOO,
convert(char(10), DTSAIDA, 103) as 'DATA SAIDA',
convert(char(8), HRSAIDA,108) as 'HORA SAIDA' from T_VOO
where DATEPART(hour,HRSAIDA) < 6
and NRROTA_VOO not in ('001', '002', '003')

/*14. Listar os códigos e nomes dos equipamentos cujo tipo de propulsão seja motor (“M”) e não sejam "JATO".*/
select CDEQU, NMEQP, IDTIP_PROP, DCTIP_EQP from T_EQUIPAMENTO
where IDTIP_PROP = 'M'
and DCTIP_EQP <>'JATO'

/*15. Listar o nome do cliente e o código do respectivo responsável para os que nasceram
em data desconhecida.*/
select NMCLI, CDCLI_RSP from T_CLIENTE
where DTNASC_CLI is Null

/*16. Listar os nomes dos equipamentos que tem propulsão com 2 motores*/
select NMEQP, QTMOTOR from T_EQUIPAMENTO
where QTMOTOR = 2

/*17. Listar os códigos e nomes dos equipamentos que sejam a jato e transportem mais de
100 pessoas, ou tenham propulsão a motor e transportem menos de 20 pessoas*/

select CDEQU, NMEQP, IDTIP_PROP, QTPASSAG from T_EQUIPAMENTO
where (QTPASSAG <= 20 and IDTIP_PROP = 'M')
or (QTPASSAG >= 100 and DCTIP_EQP = 'JATO')

/*18. Listar os nomes das companhias cujo código do país ou da companhia contenham as letras "B" ou "R".*/

select CDCIA, NMCIA, CDPAIS_CIA from T_COMPANHIA
where CDPAIS_CIA like '%B%'
or CDPAIS_CIA like '%R%'
or NMCIA like '%B%'
or NMCIA like '%R%'

/*19. Listar os vôos disponíveis cuja data de saída estejam programados para os dias de 01 e
10 de janeiro de 1993 e que não atendam a rota 001. Na listagem, atrasá-los em 28
dias.*/
select convert(char(10), DTSAIDA,103) as ANTES, 
       convert(char(10), dateadd(day,-28,DTSAIDA),103) as DEPOIS 
	   from T_VOO
where datepart(day, DTSAIDA) in (1, 10) and
datepart(month, DTSAIDA) = 1 and
datepart(year, DTSAIDA) = '1993'
and NRROTA_VOO <> 1




/*20. Listar o nome, a data de nascimento e a idade de todos os clientes brasileiros (BR),
japoneses (JA) ou franceses (FR).*/
 
 select NMCLI,(convert(char(2), day(DTNASC_CLI)) + T_CLIENTE
 join T_PAIS
(select floor(DATEDIFF(day, DTNASC_CLI, getdate()) / 365.25)

where CDPAIS_CLI in ('BR', 'JA', 'FR'))



