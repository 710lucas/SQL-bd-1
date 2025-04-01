-- Selecione o nome do funcionario mais novo
select f.nome, f.datanasc from Funcionario f
	where f.datanasc = (select MAX(datanasc) from Funcionario)

-- b) Mostre os nomes dos produtos que foram comprados no pedido mais recente.
select pr.nome from Produto pr
	join Itens i on i.produto = pr.codigo
	join Pedido pe on pe.codigo = i.pedido
	where pe.dataFatura = (select MAX(dataFatura) from Pedido)

-- c) Quais os nomes e salários dos funcionários do sexo masculino que realizaram pedidos no ano de 2020
-- e 2021? (sub-consulta obrigatória)
select f.nome, f.salario from Funcionario f
	where f.codigo in (select pe.vendedor from Pedido pe where pe.dataFatura between '01-01-2020' and '31-12-2021' and pe.vendedor = f.codigo )
	and f.sexo = 'M'

-- d) Quais os nomes dos produtos que foram comprados por clientes pessoa física no ano de 2022? (sub-
-- consulta obrigatória)

select * from Cliente

select pr.nome from Produto pr
	where pr.codigo in (select i.produto from Itens i where i.pedido in (select pe.codigo from Pedido pe where pe.cliente in (select c.codigo from Cliente c where c.tipo = 'PF') and pe.dataFatura between '01-01-2022' and '31-12-2022' ))


-- e) Exiba os nomes dos clientes que realizaram pedidos no ano de 2014 ou no ano de 2016.
select c.nome, pe.dataFatura from Cliente c
	join Pedido pe on pe.cliente = c.codigo
	where pe.dataFatura between '01-01-2014' and '31-12-2014' 
	or pe.dataFatura between '01-01-2016' and '31-12-2016'

-- f) Exiba os nomes das cidades que possuem clientes que realizaram pedidos em 2023. (sub-consulta
-- obrigatória)
select ci.nome from Cidade ci
	where ci.codigo in (
		select cidade from Cliente where codigo in (
			select cliente from Pedido where dataFatura between '01-01-2023' and '31-12-2023'
		)
	)

-- g) Mostre as datas dos pedidos que tiveram produtos com preço de venda maior que R$ 200 e do tipo
-- Cama ou Eletro.
select * from Tipo

select pe.dataFatura, i.preco from Pedido pe
	join Itens i on i.pedido = pe.codigo
	join Produto pr on i.produto = pr.codigo
	join Tipo t on pr.tipo = t.codigo
	where t.nome in ('Cama', 'Eletro')
	and i.preco > 200


-- h) Quais os distintos nomes dos produtos vendidos cujo preço de venda seja maior do que a média dos
-- preços de vendas dos produtos.
select distinct pr.nome from Produto pr
	join Itens i on i.produto = pr.codigo
	where i.preco > (select AVG(preco) from Itens)