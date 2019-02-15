CREATE OR REPLACE FUNCTION inserir_mes(descricao varchar)
RETURNS VOID AS $$
	DECLARE	
		  command TEXT;	
	BEGIN
		if ($1 isnull or  $1 like '') then
			raise exception 'mes não pode ser nulo';
		if ($1  == INT) then 
			raise exception 'descricao  deve ser um  texto';
		end if;
		else
			 insert into mes  VALUES (default, CAST(descricao as varchar));
		end if;
	end;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION inserir_funcionario(nome varchar,salario float )
RETURNS VOID AS $$
	DECLARE	
		  command TEXT;	
		  last_id int;
	BEGIN
		select max(id) into last_id from funcionario;  
		if(last_id is null) then
			last_id := 1;
		else
			last_id := last_id + 1;
		end if;
		IF ($1  isnull ) THEN
		 	raise exception 'Preencha o Nome do functionario';
		elsif ($2 isnull ) then
			raise exception 'Preencha o Salario';
		else
			 insert into funcionario  VALUES (cast(last_id as INT),cast(nome as varchar), cast(salario as float));
		end if;
	end;

$$ LANGUAGE plpgsql;

create or replace function inserir_cliente(nome varchar, email varchar)
returns void as $$
	declare 
		last_id int;
	begin
		select max(id) into last_id from cliente;
		if(last_id is null) then
			last_id := 1;
		else
			last_id := last_id + 1;
		end if;
		if($1 isnull) then
			raise exception  'preencha o nome do cliente';
		elsif ($2 isnull) then
			raise exception  'prrencha o email do cliente';
		else
			insert into cliente values (last_id,nome,email);
		end if;
	end ;
$$ language plpgsql;

create or replace function inserir_cliente(nome varchar, email varchar)
returns void as $$
	declare 
		last_id int;
	begin
		select max(id) into last_id from cliente;
		if(last_id is null) then
			last_id := 1;
		else
			last_id := last_id + 1;
		end if;
		if($1 isnull) then
			raise exception  'preencha o nome do cliente';
		elsif ($2 isnull) then
			raise exception  'prrencha o email do cliente';
		else
			insert into cliente values (last_id,nome,email);
		end if;
	end ;
$$ language plpgsql;


--create or replace function inserir_salario_mes(funcionario_id int, mes_id int)
--returns void as $$
--	declare
--		funcionario_id int;
--		mes_id int;
--	begin 
--			select max(id) into funcionario_id  from funcionario;
--			select max(id) into mes_id from mes;
--
--			if(funcionario_id is null and mes_id) then
--				funcionario_id  := 1;
--				mes_id := 1;
--			else
--				funcionario_id  := funcionario_id +1;
--				mes_id := mes_id + 1;
--			end if;
--			if($1 is null) then 
--				raise exception 'preencha o salario mes';
--			else
--				insert into salario_mes values(funcionario_id,mes_id,salario);
--	end 
--
--$$ language plpgsql;
create function inserir_tipo_pagamento(descricao varchar)
returns void as $$
	
	begin 
		if ($1 isnull or  $1 like '') then
			raise exception 'descricao não pode ser nulo';
		else
			insert into tipo_pagamento values (descricao);
		end if;
	end 
	
$$ language plpgsql;



--CREATE FUNCTION CALCULAR_SALARIO_FUNCIONARIO(FUNCIONARIO_ID INT , MES_ID INT ) RETURNS FLOAT AS $$
    -- PARA ESSE MÊS, CALCULAR  SALÁRIO DO FUNCIONÁRIO
            -- AQUI FAZ A VERIFICAÇÃO DO QUANTO O FUNCIONARIO VENDEU ATRAVÉS DOS PEDIDOS
        -- SELECIONAR OS PEDIDOS, VERIFICAR O PREÇO TOTAL * QUANTIDADE + SALARIO_FUNCIONARIO

create or replace function aplicar_bonificacao_para_o_vendedor_do_mes (mes_id int ) 
	returns float as $$
    DECLARE 
	
        QTD_VENDAS_FUNC  int := 0;
        SALARIO_ATUALIZADO float := 0;
		porcentagem float := 0.15;
		query float;

    BEGIN

		query :=  "select funcionario_id,valor_total from pedido  group by sum(valor_total)";
		execute query;
		SALARIO_ATUALIZADO := (SALARIO_ATUALIZADO +  query) *  porcentagem;
        RETURN SALARIO_ATUALIZADO;
    END;

$$ LANGUAGE PLPGSQL;


CREATE FUNCTION PAGAR_FUNCIONARIO(FUNCIONARIO_ID INT , MES_ID INT) RETURNS FLOAT AS $$
    
    DECLARE 

        SALARIO_ATUALIZADO float := 0;

    BEGIN

        -- PODENDO SER TANTO O SALÁRIO ORIGINAL ( CASO N TENHA VENDIDO NADA, QUANDO O INCREMENTADO )
        SALARIO_ATUALIZADO = CALCULAR_SALARIO_FUNCIONARIO(FUNCIONARIO_ID, MES_ID); 

        INSERT INTO SALARIO_MES VALUES ( FUNCIONARIO_ID, MES_ID, SALARIO_ATUALIZADO);
    END;

$$ LANGUAGE PLPGSQL;

--------
CREATE OR REPLACE FUNCTION possui_valor_nulo(VARIADIC list text[])
returns boolean
AS $$
DECLARE
    item text;
	saida boolean;
BEGIN
   	saida := false;
	FOREACH item IN ARRAY list
	LOOP 
	   if(item isnull or item = '')then
	   
	   	saida := true;
		end if;		
	END LOOP;
	return saida;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION possui_valor_negativo(VARIADIC list numeric[])
returns boolean
AS $$
DECLARE
    item numeric;
	saida boolean;
BEGIN
   	saida := false;
	FOREACH item IN ARRAY list
	LOOP 
	   	if(item < 0)then
	   		saida := true;
	 	end if;
	END LOOP;
	return saida;
END; $$
LANGUAGE plpgsql;

select possui_valor_nulo('Teste', null);

select possui_valor_negativo(1.0, -2, 3);
--------

create or replace function inserir_prato_generico(tabela TEXT, campo_um varchar,
                                                  campo_dois varchar, campo_tres float, campo_quatro int)
returns void as $inserir_prato_generico$
	declare
	
	begin
		if possui_valor_nulo(cast(campo_um as text), cast(campo_dois as text), cast(campo_tres as text), cast(campo_quatro as text)) then
	      	raise exception 'Campos obrigatórios: nome,status,preco,quantidade';
		end if;
	
		if possui_valor_negativo(cast(campo_tres as numeric), cast(campo_quatro as  numeric)) then
			raise exception 'Campos preco e quantidade nao podem ser negativos';
		end if;
		
		if tabela = 'prato_principal' then
	    	insert into prato_principal values (default,cast(campo_um as varchar), cast(campo_dois as varchar), cast(campo_tres as double precision),
	            cast(campo_quatro as int));
	  	end if;
	
	  	if tabela = 'acompanhamento' then
	    	insert into acompanhamento values (default, cast(campo_um as varchar), cast(campo_dois as varchar), cast(campo_tres as double precision),
	            cast(campo_quatro as int));
	  	end if;
	  	
		if tabela = 'complemento' then
	    	insert into complemento values (default, cast(campo_um as varchar), cast(campo_dois as varchar), cast(campo_tres as double precision),
	              cast(campo_quatro as int));
	    end if;
--	  end if;
	end

$inserir_prato_generico$ language plpgsql;


create or replace function inserir_prato_generico(tabela TEXT, campo_um varchar,
                                                  campo_dois varchar, campo_tres float, campo_quatro int)
returns void as $inserir_item_prato_generico$
	

	begin
		
	end 

$inserir_item_prato_generico$ language plpgsql;


create or replace function abrir_pedido(data_pedido date,cliente_id int, funcionario_id int,tipo_pagamento_id int)
returns void as $abrir_pedido$
	declare 
		
	begin
		if possui_valor_nulo(cast(data_pedido as text), cast(cliente_id as text), cast(funcionario_id as text), cast(tipo_pagamento_id as text)) then
	      	raise exception 'Campos obrigatórios: data do pedido,id do cliente, id do funcionario, id tipo pagamento';
		end if;
	
--		if possui_valor_negativo(cast(data_pedido as numeric), cast(campo_quatro as  numeric)) then
--			raise exception 'Campos preco e quantidade nao podem ser negativos';
--		end if;
		insert into pedido(data_pedido,cliente_id,funcionario_id,tipo_pagamento_id) values (cast(data_pedido as date),cast(cliente_id as int),cast(funcionario_id as int),cast(tipo_pagamento_id as int));
		
	end 

$abrir_pedido$ language plpgsql;


create or replace function inserir_prato_dia(preco float, diaOferta date, acompanhamento_id int, prato_principal1 int, prato_principal2 int, complemento1 int, complemento2 int)
returns void as $inserir_prato_dia$
	declare 
		last_prato int;
		valor_total_pedido float;
		valor_total_complemento float;
		valor_total_acompanhamento float;
		temp_size int;
		DESCONTO FLOAT := 0.75;
	begin
		select into temp_size count(id) from acompanhamento where id = acompanhamento_id;
			
		if temp_size > 0 then
			if possui_valor_nulo(cast(preco as text), cast(diaOferta as text), cast(acompanhamento_id as text)) then
		      	raise exception 'Campos obrigatórios: preco,dia da oferta, id do acompanhamento';
			end if;
			if possui_valor_negativo(cast(preco as numeric),cast(acompanhamento_id as numeric)) then
				raise exception 'Campos preco e ACOMPANhamento_id negativo';
			end if;

			--- Calcula Valor Total
			select into valor_total_pedido SUM(PP.preco * PP.quantidade) from prato_principal PP inner join 
			prato_principal_prato_do_dia IP on PP.id = IP.prato_principal_id;
	
			select into valor_total_complemento SUM(C.preco * C.quantidade) from complemento C inner join 
			complemento_prato_do_dia IC on C.id = IC.complemento_id;
	
			select into valor_total_acompanhamento A.quantidade from acompanhamento A inner join 
			prato_do_dia P on P.acompanhamento_id = A.id;
			--- 
			
--			insert into acompanhamento values(cast( preco as  float),cast(diaOferta as date),cast(acompanhamento_id as int)); 
			insert into prato_do_dia (diaOferta, acompanhamento_id)  values (diaOferta, acompanhamento_id); 			
			-- select into last_prato max(id) from prato_do_dia;
			SELECT into last_prato currval(pg_get_serial_sequence('prato_do_dia','id'));
			raise notice '%', last_prato;
			-- Pratos com Prato do Dia:
			insert into prato_principal_prato_do_dia (prato_principal_id, prato_do_dia_id) values (prato_principal1, last_prato);
			insert into prato_principal_prato_do_dia (prato_principal_id, prato_do_dia_id) values (prato_principal2, last_prato);
			-- Complementos
			insert into complemento_prato_do_dia (complemento_id, prato_do_dia_id, quantidade) values (complemento1, last_prato, 1);
			insert into complemento_prato_do_dia (complemento_id, prato_do_dia_id, quantidade) values (complemento2, last_prato, 1);
			
			update prato_do_dia set preco = (valor_total_pedido + valor_total_complemento + valor_total_acompanhamento) * 0.75 where id = last_prato;
		else
			raise exception 'Acompanhamento nao existe';
		end if;	
	end 
		
$inserir_prato_dia$ language plpgsql;




CREATE OR REPLACE FUNCTION adicionar_item(tabela Text,pedido_id int,VARIADIC list text[])
returns void
AS $adicionar_item$
DECLARE
    item text;
	quantidade_pedido int;
BEGIN
	select into quantidade_pedido count(*) from pedido where pago isnull and id = pedido_id;
	if quantidade_pedido > 0 then
		if tabela = 'acompanhamento' then
			update pedido  set acompanhamento_id = cast(list[1] as int) where id = pedido_id;  
		end if;
		if tabela = 'prato_dia' then 
			update pedido set acompanhamento_id = null, prato_do_dia_id = cast(list[1] as int) where id=pedido_id;
		-- Retornar todos os complementos e os pratos principais
		end if;
		if tabela = 'prato_principal' then
			
			insert into item_prato_principal(pedido_id,prato_principal_id,quantidade) values (pedido_id, cast(list[1] as int), cast(list[2] as int));
		end if;
		if tabela = 'complemento' then
			insert into item_complemento(pedido_id,complemento_id,quantidade) values (pedido_id, cast(list[1] as int), cast(list[2] as int));
		end if;
		
	end if;
	
END; 
$adicionar_item$ LANGUAGE plpgsql;

drop FUNCTION fechar_pedido(integer);

CREATE OR REPLACE FUNCTION calcular_salario_funcionario(id_funcionario int)
returns void
AS $calcular_salario_funcionario$
declare
	valor_total_vendas float;
BEGIN
	-- IF prato do dia:
	select into valor_total_vendas SUM(valor_total) from pedido where funcionario_id = id_funcionario;
	
	update funcionario set salario = 1500 + (valor_total_vendas * 0.10) where id = id_funcionario;
END; 
$calcular_salario_funcionario$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fechar_pedido(pedido_atual_id int)
returns void
AS $fechar_pedido$
declare
	is_prato_do_dia int;
    valor_total_pedido float;
	valor_total_complemento float;
	valor_total_acompanhamento float;
	quantidade_prato_principal int;
	quantidade_complemento int;
BEGIN
	-- IF prato do dia:
	select into is_prato_do_dia prato_do_dia_id from pedido where id = pedido_atual_id;
	select into valor_total_pedido preco from prato_do_dia where id = is_prato_do_dia;
	if(is_prato_do_dia > 0 and not is_prato_do_dia isnull)then
		update pedido set pago='s', valor_total = valor_total_pedido where id = pedido_atual_id;
	else
		select into valor_total_pedido SUM(PP.preco * PP.quantidade) from prato_principal PP inner join 
		item_prato_principal IP on PP.id = IP.prato_principal_id and IP.pedido_id = pedido_atual_id;

		select into valor_total_complemento SUM(C.preco * C.quantidade) from complemento C inner join 
		item_complemento IC on C.id = IC.complemento_id and IC.pedido_id = pedido_atual_id;

		select into valor_total_acompanhamento A.quantidade from acompanhamento A inner join 
		pedido P on P.acompanhamento_id = A.id and P.id = pedido_atual_id;
		
		update pedido set pago='s', valor_total = valor_total_pedido+valor_total_complemento+valor_total_acompanhamento where id = pedido_atual_id;
	end if;	
END; 
$fechar_pedido$ LANGUAGE plpgsql;


CREATE or REPLACE FUNCTION atualizar(tabela TEXT, nome TEXT, valores TEXT)
RETURNS VOID AS $$
	DECLARE
	
		tab TEXT;
		command TEXT := 'UPDATE ' || $1 || ' SET ' || $3 || ' WHERE nome = '''|| $2 ||''';';
		command_endereco TEXT := 'UPDATE ' || $1 || ' SET ' || $3 || ' WHERE  = '''|| $2 ||''';';
	BEGIN
		SELECT tabela into tab;
		IF (tab = '' OR tab = '') THEN
			EXECUTE command_endereco;
		ELSE 
			EXECUTE command;
		END IF;
	END;

$$ LANGUAGE plpgsql

CREATE or REPLACE FUNCTION deletar(tabela TEXT, nome TEXT)
RETURNS VOID AS $$
	DECLARE
		command TEXT := 'DELETE FROM ' || $1 || ' WHERE NOME = ''' || $2 ||''';';
	BEGIN
		EXECUTE command;
	END;
	
$$ LANGUAGE plpgsql;
	

