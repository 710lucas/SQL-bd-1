-- select * from Hospedes where dataNascimento is not null AND dataNascimento between '1990-01-01 00:00:00.000' and '2000-01-01 00:00:00.000'


select * from Hospedes order by nome

select sexo, count(*) as 'qtd' from Hospedes group by sexo

select datanascimento, COUNT(dataNascimento) from Hospedes group by dataNascimento

--mostrando pra cada hospede seu nome e a quantidade de estadias q ele teve
select Hospedes.nome, count(*)as 'quantidade estadias' from estadias, Hospedes where Hospedes.CPF = Estadias.hospede group by nome

--mostre para cada hospede, seu nome, sexo, quantidade de servicos solicitados e uma media de preco
--media avg
select Hospedes.nome, Hospedes.sexo, count(*) as 'qtd servicos', avg(Servicos.preco) as 'media preco', sum(Servicos.preco) as 'preco total'
	from Hospedes, Servicos, Solicitacoes 
	where Solicitacoes.hospede = Hospedes.CPF and Servicos.codServico = Solicitacoes.servico
	group by Hospedes.nome, hospedes.sexo


--mostre para cada hospede, seu nome, sexo, quantidade de servicos solicitados e uma media de preco COM MEDIA DE PRECO > 60
--HAVING: So pode ser usada com o group by; é condicional
select Hospedes.nome, Hospedes.sexo, count(*) as 'qtd servicos', avg(Servicos.preco) as 'media preco', sum(Servicos.preco) as 'preco total'
	from Hospedes, Servicos, Solicitacoes 
	where Solicitacoes.hospede = Hospedes.CPF and Servicos.codServico = Solicitacoes.servico 
	group by Hospedes.nome, hospedes.sexo
	having avg(Servicos.preco) > 60

--subconsultas
-- Mostre o nome do hospede mais novo
select nome from Hospedes where dataNascimento = (select max(dataNascimento) from Hospedes)

--mostre o nome da hospede mais nova
select nome from Hospedes where dataNascimento = (select max(dataNascimento) from Hospedes where sexo = 'F')


select * from Servicos
select * from Solicitacoes

