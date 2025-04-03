use Hotel

-- qual o nome do hospede que solicitou o serviço mais barato

select h.nome from Hospedes h, Solicitacoes so, Servicos se
	where h.CPF = so.hospede
	and se.codServico = so.servico
	and se.preco = (select min(preco) from Servicos)

select nome from Hospedes 
	where CPF in (select hospede from Solicitacoes where servico in (select codServico from Servicos where preco in (select min(preco) from Servicos)))


-- qual o nome do hospede e a data de splicitacao que solicitou o serviço mais barato
select h.nome, so.data from Hospedes h, Solicitacoes so, Servicos se
	where h.CPF = so.hospede
	and se.codServico = so.servico
	and se.preco = (select min(preco) from Servicos)


-- quais os serviços solicitados em 2023 por hospedes do sexo masculino

select se.* 
	from Servicos se 
	JOIN Solicitacoes so on se.codServico = so.servico 
	JOIN Hospedes h on h.CPF = so.hospede
	where h.sexo = 'M'
	and so.data between '01-01-2023' and '31-12-2023'

select * from Servicos
	where codServico in 
		(select servico from Solicitacoes where data between '01-01-2023' and '31-12-2023'
			and hospede in (select CPF from Hospedes where sexo = 'M'))
