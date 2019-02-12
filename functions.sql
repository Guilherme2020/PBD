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
	

