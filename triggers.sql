
--
--
--
---- Checar Usuário Tentando Manipular o Banco
--
--CREATE OR REPLACE FUNCTION ChecarSeVendedor()
--RETURNS TRIGGER AS $$
--DECLARE
--    usuario_atual TEXT;
--BEGIN
--    SELECT USER INTO usuario_atual;
--
--    IF usuario_atual <> 'funcionario' THEN
--        RAISE EXCEPTION 'Só um funcionario pode realizar essa operação.'
--    END IF;
--END;
--$$ LANGUAGE plpgsql;
--
--
--
--
--
---- Checar horario do pedido
--
--CREATE OR REPLACE FUNCTION ChecarHoraDoPedido()
--RETURNS TRIGGER AS $ChecarHoraDoPedido$
--DECLARE
--	horario_pedido TIME;
--begin      
--	horario_pedido :=  select CURRENT_TIME;
----	select into horario_pedido  data_pedido from pedido where id = new.id;
--    IF horario_pedido > "10:00" THEN
--        RAISE EXCEPTION 'Perdão, um pedido só pode ser realizado até as 10:00 Am';
--    END IF;
--END;
--$$ LANGUAGE plpgsql;
-----
CREATE OR REPLACE FUNCTION ChecarQuantidadeComplemento()
RETURNS TRIGGER AS $ChecarQuantidadeComplemento$
DECLARE
	quantidade_item int;
	quantidade_total int;
begin      
	if TG_OP = 'INSERT' then
		select into quantidade_item quantidade from complemento where id = new.complemento_id;
		raise notice 'Quantidade %', quantidade_item;	
		select into quantidade_total SUM(quantidade) from item_complemento where complemento_id = new.complemento_id and pedido_id = new.pedido_id;
		raise notice 'Quantidade de itens %', quantidade_item;
		if new.quantidade > 10 or quantidade_total > 10 then 
			raise exception 'Maximo de 10 complementos permitidos';
		end if;
		if quantidade_item - new.quantidade < 0 then
			raise exception 'Quantidade de complementos insuficientes';
		else 
			update complemento set quantidade = quantidade_item - new.quantidade where id = new.complemento_id;
		end if;
		return new;
	end if;
	if TG_OP = 'DELETE' then
		select into quantidade_item quantidade from complemento where id = old.complemento_id;
		raise notice 'Quantidade delete %', quantidade_item;
		update complemento set quantidade = quantidade_item + old.quantidade where id = old.complemento_id;
		return old;
	end if;
	return new;
END;
$ChecarQuantidadeComplemento$ LANGUAGE plpgsql;

DROP TRIGGER ChecarQuantidadeComplementoDelete ON item_complemento;

create trigger ChecarQuantidadeComplementoDelete before insert or delete  on item_complemento 
for each row execute procedure ChecarQuantidadeComplemento();
---
CREATE OR REPLACE FUNCTION ChecarQuantidadePratoPrincipal()
RETURNS TRIGGER AS $ChecarQuantidadePratoPrincipal$
DECLARE
	quantidade_item int;
	quantidade_total int;
begin      
	if TG_OP = 'INSERT' then
		select into quantidade_item quantidade from prato_principal where id = new.prato_principal_id;
		raise notice 'Quantidade %', quantidade_item;	
		select into quantidade_total SUM(quantidade) from item_prato_principal where prato_principal_id = new.prato_principal_id and pedido_id = new.pedido_id;
		raise notice 'Quantidade de itens %', quantidade_item;
		if new.quantidade > 2 or quantidade_total > 2 then 
			raise exception 'Maximo de 2 pratos principais permitidos';
		end if;
		if quantidade_item - new.quantidade < 0 then
			raise exception 'Quantidade de pratos principais insuficientes';
		else 
			update prato_principal set quantidade = quantidade_item - new.quantidade where id = new.prato_principal_id;
		end if;
		return new;
	end if;
	if TG_OP = 'DELETE' then
		select into quantidade_item quantidade from prato_principal where id = old.prato_principal_id;
		raise notice 'Quantidade delete %', quantidade_item;
		update prato_principal set quantidade = quantidade_item + old.quantidade where id = old.prato_principal_id;
		return old;
	end if;
	return new;
END;
$ChecarQuantidadePratoPrincipal$ LANGUAGE plpgsql;

DROP TRIGGER ChecarQuantidadePratoPrincipalDelete ON item_prato_principal;

create trigger ChecarQuantidadePratoPrincipalDelete before insert or delete  on item_prato_principal 
for each row execute procedure ChecarQuantidadePratoPrincipal();

--
CREATE OR REPLACE FUNCTION ChecarQuantidadeAcompanhamento()
RETURNS TRIGGER AS $ChecarQuantidadeAcompanhamento$
DECLARE
	quantidade_item int;
begin   
	
	if TG_OP = 'INSERT' then
		select into quantidade_item quantidade from acompanhamento where id = new.acompanhamento_id;
		raise notice '%', quantidade_item;
		if not quantidade_item > 0 then 
			raise exception 'nao tem acompanhamento disponivel';
		else 
			update acompanhamento set quantidade = quantidade_item - 1 where id = new.acompanhamento_id;
--			update acompanhamento set quantidade = quantidade_item + 1 where id = old.acompanhamento_id and new.acompanhamento_id <> old.acompanhamento_id;
		end if;
		return new;
	end if;
	if TG_OP = 'UPDATE' then
		select into quantidade_item quantidade from acompanhamento where id = new.acompanhamento_id;
		raise notice '%', quantidade_item;
		if not quantidade_item > 0 then 
			raise exception 'nao tem acompanhamento disponivel';
		else 
			update acompanhamento set quantidade = quantidade_item - 1 where id = new.acompanhamento_id;
			update acompanhamento set quantidade = quantidade_item + 1 where id = old.acompanhamento_id and new.acompanhamento_id <> old.acompanhamento_id;
		end if;
		return new;
	end if;
	if TG_OP = 'DELETE' then
		select into quantidade_item quantidade from acompanhamento where id = old.acompanhamento_id;
		raise notice '%', quantidade_item;
		update acompanhamento set quantidade = quantidade_item + 1 where id = old.acompanhamento_id;
		return old;
	end if;
	return new;
END;
$ChecarQuantidadeAcompanhamento$ LANGUAGE plpgsql;

DROP TRIGGER ChecarQuantidadeAcompanhamentoDelete ON pedido;

create trigger ChecarQuantidadeAcompanhamentoDelete before update or delete  on pedido 
for each row execute procedure ChecarQuantidadeAcompanhamento();

