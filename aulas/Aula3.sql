use Hotel

-- Mostre os nomes dos hóspedes e a descrição dos serviços solicitados, para cada hóspede que
--solicitou serviço no segundo semestre de 2023.

select h.nome, se.descricao, s.servico  
	from Hospedes h, Solicitacoes s, Servicos se
	where s.data between '2023-06-01' and '2023-12-31'
	and  s.servico = se.codServico 
	and s.hospede = h.CPF
	
-- Exiba os dados dos serviços solicitados por hóspedes cujo nome tenha “Santos” em qualquer parte.
-- Ordene pela descrição do serviço.
	
--REGRA DE JUNÇÕES: 3 tabelas, 2 junções (ultimos dois ands)
	-- n tabelas, n-1 junções
	
-- '%santos' termina com santos
-- 'santos%' começa com santos
-- '%santos%' pode ser no começo, fim ou meio
select se.*, h.nome from Servicos se, Hospedes h, Solicitacoes s
	where h.nome like '%Santos%'
	and se.codServico = s.servico
	and s.hospede = h.CPF 
	order by se.descricao 
	
-- Mostre os nomes dos hóspedes e quantidade de suas estadias, apenas para hospedes que tiveram
-- estadias em quartos do tipo Standard ou Luxo Superior em 2012.	
select h.nome, count(e.hospede ) from Hospedes h, Estadias e, Quartos q 
	where q.tipo in ('Standard', 'Luxo Superior')
	and e.dataEntrada between '2012-01-01' and '2012-12-31'
	and h.CPF = e.hospede 
	and e.quarto = q.numero 
	GROUP BY h.nome
	
	
-- Mostre as datas de entrada e saída das estadias realizadas por hóspedes que informaram a data de
-- nascimento. Ordene pela data de entrada em ordem descendente.
select e.dataEntrada, e.dataSaida from Estadias e, Hospedes h
	where h.dataNascimento is not NULL 
	and e.hospede = h.CPF 
	order by e.dataEntrada DESC
	
-- e) Mostre a quantidade por sexo de cada serviço solicitado.
select h.sexo, se.descricao, count(so.servico) from Servicos se, Hospedes h, Solicitacoes so
	where se.codServico = so.servico 
	and h.CPF = so.hospede 
	group by h.sexo, se.descricao --agroupando por sexo e descricao, então mostrando o servico pelo agrupamento
	
-- f) Exiba os distintos nomes dos hóspedes que tiveram estadias em quartos cujo valor da diária é
-- maior que R$500, e que solicitaram serviço de Lanchonete ou Passadeira.
select DISTINCT h.nome from Hospedes h, Estadias e, Quartos q, Solicitacoes so, Servicos se
	where q.valorDiaria > 500
	and se.descricao in ('Lanchonete', 'Passadeira')
	and h.CPF = e.hospede 
	and e.quarto = q.numero 
	and so.hospede = h.CPF
	and se.codServico = so.servico 
	
-- g) Mostre, para cada serviço, a sua descrição e uma média de preços pagos, apenas para serviços
-- solicitados entre os anos de 2015 e 2018.
select se.descricao, AVG(se.preco) as 'Preço Médio' from Servicos se, Solicitacoes so
	WHERE so.data between '2015-01-01' and '2018-12-31'
	and se.codServico  = so.servico 
	group by se.descricao
	
	
-- h) Mostre, para cada quarto, o seu tipo, valor de diária e quantidade de estadias. Ordene pelo tipo do
-- quarto.
select q.tipo , q.valorDiaria , count(*) as 'Quantidade de estadias' from Quartos q, Estadias e
	where q.numero = e.quarto 
	group by q.tipo, q.valorDiaria 
	order by q.tipo ASC

-- i) Mostre os nomes dos hóspedes que pagaram pelo quarto com maior valor de diária.
select h.nome from Hospedes h, Estadias e, Quartos q
	where h.CPF = e.hospede 
	and q.valorDiaria= (select MAX(q2.valorDiaria) from quartos as q2)
	
select DISTINCT h.nome from Hospedes h, Estadias e, Quartos q
	where h.CPF = e.hospede 
	and q.valorDiaria= (select MAX(q2.valorDiaria) from quartos as q2)

	
