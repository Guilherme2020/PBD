



-- Checar Usuário Tentando Manipular o Banco

CREATE OR REPLACE FUNCTION ChecarSeVendedor()
RETURNS TRIGGER AS $$
DECLARE
    usuario_atual TEXT;
BEGIN
    SELECT USER INTO usuario_atual;

    IF usuario_atual <> 'funcionario' THEN
        RAISE EXCEPTION 'Só um funcionario pode realizar essa operação.'
    END IF;
END;
$$ LANGUAGE plpgsql;





-- Checar horario do pedido

CREATE OR REPLACE FUNCTION ChecarHoraDoPedido()
RETURNS TRIGGER AS $$
DECLARE
	horario_pedido TIME;
begin      
	horario_pedido := CURRENT_TIME(2);
--    SELECT data_pedido INTO data_pedido from pedido;

    IF horario_pedido > "10:00" THEN
        RAISE EXCEPTION 'Perdão, um pedido só pode ser realizado até as 10:00 Am';
    END IF;
END;
$$ LANGUAGE plpgsql;
