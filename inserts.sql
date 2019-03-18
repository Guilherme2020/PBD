--select inserir_mes('Fevereiro');
--
--select  inserir_mes('Marco');
--
--select inserir_mes(22);

select inserir_prato_generico('prato_principal','carne assada','s',15,5);

select inserir_prato_generico('prato_principal','lasanha','s',15,3);

select inserir_prato_generico('acompanhamento','arroz a appetit','s',5,5);

select inserir_prato_generico('acompanhamento','arroz a grega','s',2.01,2);

select inserir_prato_generico('complemento','macarrao ao molho','s',3,4);

select inserir_prato_generico('complemento','batata frita','s',3.02,6);

select inserir_prato_dia(10,'2018-01-15', 1, 1, 2, 1, 2);

select * from prato_principal_prato_do_dia;

select adicionar_item('prato_dia',10,'1');
select * from prato_do_dia;

select abrir_pedido('2018-02-15',1,1,3);

select * from pedido;
select fechar_pedido(10);


select * from prato_do_dia;
select * from prato_principal;

select * from acompanhamento;

select * from complemento;
--select * from 

select abrir_pedido('2018-02-15',1,1,2);
select * from pedido;

select adicionar_item('acompanhamento',15,'6');
select * from acompanhamento;
select adicionar_item('acompanhamento',11,'2');
--select adicionar_item('prato_principal',9,'2','3');
select adicionar_item('prato_principal',15,'8','1');
select * from prato_principal;

select * from complemento;
select adicionar_item('complemento',15,'1','1');
select * from item_prato_principal;
select * from item_complemento;
select fechar_pedido(15);
select * from pedido;

select abrir_pedido('2018-02-15',1,1,3);


select adicionar_item('prato_dia',12,'3');
select * from prato_do_dia;
select fechar_pedido(12);
select * from pedido;


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
insert into tipo_pagamento values(3,'cartao visa');
insert into tipo_pagamento values(4,'a vista');
--insert into prato_do_dia values(1,15.05,'2018-12-12',2);
--insert into prato_do_dia values(1,15.05,'2018-12-12',2);


select * from cliente;

select * from funcionario;


select inserir_funcionario('marlysson',2500);
select inserir_funcionario('pereira',2000);
select inserir_cliente('guilherme','grodrigues.simeao');
select inserir_cliente('tiago','tiagoeliass@gmail.com');
select inserir_cliente(221,'grodrigues.simeao');
select inserir_cliente('rondinele','rondinele@gmail.com');
select inserir_cliente('maria vitoria','maria@gmail.com');





ALTER TABLE public.funcionario ALTER COLUMN funcionario_id TYPE serial USING funcionario_id::int4 ;

drop table funcionario;

select * from funcionario;

   
