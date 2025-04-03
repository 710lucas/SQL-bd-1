--quais as estadias que aconteceram nos ultimos 3 anos
select * from Estadias
	where DateDiff(yy, dataEntrada, getDate()) <= 3
	
-- armazenando valores da consulta em nova tabela	
select nome into tabtemp from Hospedes

select * from tabtemp

--views -> serve somente para ler dados, não pode alterar
-- view fica sempre sincronizada com a tabela original
create view NomeHospedes as
	select nome from Hospedes
	

	
--desafio: qual o hospede com mais estadias
drop view contagemEstadias
	
create view contagemEstadias as
	select h.nome, count(*) 'qtd' from Estadias e
		join Hospedes h on h.CPF = e.hospede
		group by h.nome
		
		
select * from contagemEstadias

select c.nome from contagemEstadias c	
	where c.qtd = (select max(qtd) from contagemEstadias)

