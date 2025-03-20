-- a) Exibir código, nome, preço de custo, preço de venda e a diferença entre estes dois preços para todos
-- os produtos.
select nome, custo, venda, venda-custo as 'Diferença venda X custo' from Produto

-- b) Mostre todos os pedidos realizados no ano de 2009.
select * from Pedido
	where dataPedido between '2009-01-01' and '2009-12-31'
	
--c) Mostre quantos funcionários tem e-mail
select count(*) from Funcionario
	where email is not null
	
-- d) Exibir código e nome de todos os funcionários que tenham “Silva” em qualquer parte do nome
select codigo, nome from Funcionario
	where nome like '%Silva%'
	
-- e) Mostre os produtos comprados por clientes pessoa jurídica.
select pr.* from Cliente c, Pedido pe, Produto pr, Itens i
	where pe.cliente = c.codigo 
	and i.pedido = pe.codigo 
	and i.produto = pr.codigo 
	and c.tipo = 'PJ'
	
-- f) Mostre os nomes e as cidades que nasceram os funcionários que realizaram pedidos de Liquidificador.
select distinct f.nome, ci.nome from Funcionario f, Cidade ci, Pedido pe, Produto pr, Itens i
	where pe.vendedor = f.codigo 
	and i.pedido = pe.codigo 
	and i.produto = pr.codigo 
	and f.naturalidade = ci.codigo
	and pr.nome = 'Liquidificador'
	
-- g) Exiba nome e tipo dos clientes que foram atendidos por funcionários que NÃO moram no Bessa nem em
-- Manaíra.
select 
	cl.nome as 'Nome Cliente', 
	cl.tipo as 'Tipo Cliente', 
	f.nome as 'Nome Funcionário',
	f.bairro as 'Bairro Funcionário'
from Cliente cl, Pedido pe, Funcionario f 
	where cl.codigo = pe.cliente 
	and f.codigo = pe.vendedor 
	and f.bairro not in ('Bessa', 'Manaíra')
	
	
-- h) Mostre os nomes dos funcionários que realizaram algum pedido para clientes que moram no Rio de
-- Janeiro.
select f.nome, ci.nome as 'Cidade Cliente' from Funcionario f, Cliente cl, Cidade ci, Pedido pe
	where pe.cliente = cl.codigo 
	and pe.vendedor = f.codigo 
	and cl.cidade = ci.codigo 
	and ci.nome = 'Rio de Janeiro'
	
	
-- i) Mostre nome, descrição e data da compra dos produtos comprados entre 2020 e 2022. Ordene pela
-- data em ordem descendente.
select pr.nome, pr.descricao, pe.dataPedido from Produto pr, Pedido pe, Itens i 
	where i.produto = pr.codigo 
	and i.pedido = pe.codigo 
	and pe.dataPedido between '2020-01-01' and '2022-12-31'
	
	
-- j) Mostre para cada funcionário o seu nome e a quantidade de vendas realizadas.
select f.nome, count(*) 'Vendas feitas'from Funcionario f, Pedido p
	where p.vendedor = f.codigo 
	group by f.nome
	
-- k) Mostre o nome do produto, o seu valor de venda, a quantidade vendida e a soma dos preços de venda
-- destes produtos comprados, que possuem quantidade em estoque entre 10 e 100 itens, apenas para
-- os produtos cuja esta soma seja maior do que R$2000,00.
select pr.nome , pr.venda, count(*) as 'Quantidade vendida', SUM(pr.venda) as 'Soma preços de venda', pr.quantest 'Quantidade Estoque'
	from Produto pr, Itens i 
	where i.produto = pr.codigo 
	and pr.quantest between 10 and 100
	group by pr.nome, pr.venda, pr.quantest
	having SUM(pr.venda) > 2000
	
-- l) Exibir o código do produto e a quantidade de pedidos feitos para os produtos que foram pedidos mais
-- do que 30 vezes.
select pr.codigo, COUNT(*) from Produto pr, Pedido pe, Itens i
	where i.pedido = pe.codigo 
	and i.produto = pr.codigo 
	group by pr.codigo
	having COUNT(*) > 30
	

	
	
