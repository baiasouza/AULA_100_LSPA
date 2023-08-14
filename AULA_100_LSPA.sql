create database ibge_lspa;

use ibge_lspa;

create table produtos (
	cod_produto int,
    nome_produto varchar(45),
    primary key(cod_produto)
    );
    
create table safra (
	cod_safra int,
    cod_produto int,
    volume int,
    ano int,
    mes int,
    primary key(cod_safra),
    foreign key(cod_produto) references produtos(cod_produto)
    );
    
    select * from produtos;
    select * from safra;
    
-- 1) Listar todos os produtos e suas safras correspondentes
select p.cod_produto, p.nome_produto, s.cod_safra from produtos p 
inner join safra s on p.cod_produto = s.cod_produto;

-- 2) Listar o nome do produto, volume e ano da safra para um
-- produto específico (por exemplo, código do produto 1)
select p.nome_produto, s.volume, s.ano from produtos p 
inner join safra s on p.cod_produto = s.cod_produto where s.cod_produto = "1";

-- 3) Calcular o volume total de safras para cada produto
select p.nome_produto, sum(s.volume) as volume_total
 from produtos p inner join safra s on p.cod_produto = s.cod_produto group by s.cod_produto;
 
 -- 4) Listar os produtos que tiveram safras no ano de 2023
 select p.nome_produto, s.ano from produtos p 
inner join safra s on p.cod_produto = s.cod_produto where s.ano = "2023";

-- 5) Listar o nome do produto e o volume médio das safras para
-- produtos com volume médio superior a 100 milhões de toneladas
select p.nome_produto, avg(s.volume) as volume_medio from safra s 
inner join produtos p on s.cod_produto = p.cod_produto group by p.nome_produto
having volume_medio > "100000000";

-- Listar os produtos e suas safras ordenados pelo ano e mês da safra
select * from produtos p inner join safra s on p.cod_produto = s.cod_produto order by s.ano, s.mes;

-- Calcular o total de volume de safras
-- agrupados por produtos no ano de 2023
select p.nome_produto, sum(s.volume) as volume_total from produtos p 
inner join safra s on p.cod_produto = s.cod_produto where s.ano = "2023" group by s.cod_produto;

-- Calcular volume de safras do produto 
-- com código 2 no ano de 2023 no mês de Junho
select p.nome_produto, s.volume from produtos p 
inner join safra s on p.cod_produto = s.cod_produto where s.ano = "2023" and mes = 6 
and s.cod_produto = 2 group by s.cod_produto;