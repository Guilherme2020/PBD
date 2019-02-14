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



create or replace function inserir_prato_generico(tabela TEXT,campo_um varchar,
campo_dois varchar,campo_tres float,campo_quatro int)
	returns void as $inserir_prato_generico$
	declare 
	
	begin
		if tabela = 'prato_principal' then
			if campo_um = '' or campo_dois = '' or campo_tres = '' or campo_quatro = '' or campo_cinco = '' then
				raise exception	'Campos obrigatórios: nome,status,preco,quantidade';	
			end if;
			
			if campo_quatro > 2 then
				raise exception 'quantidade só pode ser até dois pedaços';
			end if;
			else
			
--				insert into prato_principal values (cast(campo_um as varchar),cast(campo_dois as bool),cast(campo_tres as float),cast(campo_quatro as int));
				insert into prato_principal values (cast(campo_um as varchar(255)),cast(campo_dois as varchar),cast (campo_tres as float),campo_quatro);			
		end if;	
		if tabela = 'acompanhamento' then
			if campo_um = '' or campo_dois = '' or campo_tres = '' or campo_quatro = '' or campo_cinco = '' then
				raise exception	'Campos obrigatórios: nome,status,preco,quantidade';	
			end if;
			if campo_quatro > 1 then
				raise exception 'quantidade do acompanhamento só pode ser até um tipo';
			end if;
			insert into prato_principal values (default, cast(campo_um as varchar),cast(campo_dois as bool),cast(campo_tres as float),cast(campo_quatro as int));
		end if;		
		if tabela = 'complemento' then
			if campo_um = '' or campo_dois = '' or campo_tres = '' or campo_quatro = '' or campo_cinco = '' then
				raise exception	'Campos obrigatórios: nome,status,preco,quantidade';	
			end if;
			if campo_quatro > 10 then 
				raise exception 'quantidade de complemento exagerada!';
				insert into prato_principal values (default, cast(campo_um as varchar),cast(campo_dois as bool),cast(campo_tres as float),cast(campo_quatro as int));
			end if;
		end if;	
	end 
	
$inserir_prato_generico$ language plpgsql;




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
	

