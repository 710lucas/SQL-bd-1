use Hotel

--exiba o nome de todos os hospedes
select nome from Hospedes 

--exiba todos os dados de servicos
select * from Servicos 

-- Mostre o tipo, o valor da diária, 
--e o lucro mensal de cada quarto (valor da diária * 31). 
--Renomeie esta última coluna para Valor da Diária/Mês.
select tipo, valorDiaria, valorDiaria*31 as 'Valor da diária/mes' from Quartos

--Mostre a soma e a média dos preços de todos os serviços.
select SUM(preco) as 'Soma dos precos', AVG(preco) as 'Media dos precos' from Servicos

--Mostre o valor da diária do quarto mais caro e do mais barato.
select MAX(valorDiaria) as 'Mais caro', MIN(valorDiaria) as 'Mais barato' from Quartos

--Exiba a data de nascimento do hóspede mais novo.
select MAX(dataNascimento) as 'data nascimento hospede mais novo' from Hospedes

--Mostre quantos serviços foram solicitados pelo hóspede de CPF 922411035844.
select count(*) from Solicitacoes where hospede = 922411035844

--Mostre quantos hóspedes distintos já tiveram estadias.
select count(distinct(hospede)) from Estadias

--Mostre a descrição, preço e o preço com 35% de aumento, de todos os serviços.
select descricao, preco, preco + (preco*0.35) as 'preco com aumento' from Servicos

--Quais os dados dos quartos que possuem valor de diária maior que R$ 300?
select * from Quartos where valorDiaria > 300

--Mostre os dados de todos os hóspedes que tiveram estadias no ano de 2018.
select * from estadias where dataEntrada >= '2018-01-01 00:00:00.000' and dataSaida < '2019-01-01 00:00:00.000'

--Exiba os dados dos serviços solicitados em setembro de 2023.
select * from Solicitacoes where data between '2023-09-01 00:00:00.000' and '2023-10-01 00:00:00.000'

-- Exiba os nomes dos hóspedes e a hora da solicitação do serviço, para hospedes que solicitaram
-- serviços de Lavanderia ou de Babá.
-- codServico para Lavanderia = 1
-- codServico para baba = 3
-- select Hospedes.nome, Servicos.descricao, Solicitacoes.hora from Hospedes, Solicitacoes, Servicos where Solicitacoes.hospede = Hospedes.CPF and (Solicitacoes.servico = 1 or Solicitacoes.servico = 3);
select Hospedes.nome, Solicitacoes.data, Solicitacoes.hora, Servicos.codServico, Servicos.descricao 
	from Hospedes, Solicitacoes, Servicos
	where Servicos.codServico in (1,3)
	and Hospedes.CPF = Solicitacoes.hospede 
	and Servicos.codServico = Solicitacoes.servico 
	
-- Mostre quantos serviços foram solicitados por hóspedes do sexo masculino, no primeiro semestre
-- de 2012.
select count(*) from Solicitacoes, Hospedes, Servicos 
	where Hospedes.sexo = 'M'
	and Solicitacoes.data between '2012-01-01 00:00:00.000' and '2012-30-06 00:00:00.000'
	