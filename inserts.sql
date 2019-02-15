select inserir_mes('Fevereiro');

select  inserir_mes('Marco');

select inserir_mes(22);

select inserir_prato_generico('prato_principal','frango','s',15,2);

select inserir_prato_generico('prato_principal','lasanha','s',15,2);

select inserir_prato_generico('acompanhamento','arroz estranho','s',5,2);

select inserir_prato_generico('acompanhamento','arroz a grega','s',2.01,2);

select inserir_prato_generico('complemento','macarrao','s',3,1);

select inserir_prato_generico('complemento','batata frita','s',3.02,1);

select inserir_prato_dia(10.01,'2018-01-01', 1, 1, 2, 1, 2);

select * from prato_do_dia;
select * from prato_principal;

select * from acompanhamento;

select * from complemento;
--select * from 




select abrir_pedido('2016-02-02',1,1,2);

select adicionar_item('acompanhamento',1,'3');

select adicionar_item('prato_dia',1,'1');

select adicionar_item('prato_principal',1,'2','2');
select adicionar_item('complemento',1,'2','5');

select * from pedido;
select fechar_pedido(1); 


select * from funcionario;
select * from calcular_salario_funcionario(1);

select * from item_prato_principal;
select * from item_complemento;
select * from pedido;
select * from tipo_pagamento;
insert into tipo_pagamento values(1,'boleto');
insert into tipo_pagamento values(2,'cartao nubank');
insert into prato_do_dia values(1,15.05,'2018-12-12',2);
insert into prato_do_dia values(1,15.05,'2018-12-12',2);

select * from  mes;

select * from cliente;

select * from funcionario;


select inserir_funcionario('marlysson',2500);
select inserir_funcionario('pereira',2000);
select inserir_cliente('guilherme','grodrigues.simeao');
select inserir_cliente(221,'grodrigues.simeao');
select inserir_cliente('rondinele','rondinele@gmail.com');
select inserir_cliente('maria vitoria','maria@gmail.com');


insert into funcionario ('marlysson',2500);
--insert into funcionario ('pereira',2000);


ALTER TABLE public.funcionario ALTER COLUMN funcionario_id TYPE serial USING funcionario_id::int4 ;

delete  from mes;
drop table funcionario;

select * from funcionario;

