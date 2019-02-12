


select inserir_mes('Fevereiro');
select  inserir_mes('Marco');
select inserir_mes(22);

select * from  mes;
select inserir_funcionario('marlysson',2500);
select inserir_funcionario('pereira',2000);
select inserir_cliente('guilherme','grodrigues.simeao');
select inserir_cliente(221,'grodrigues.simeao');
select inserir_cliente('rondinele','rondinele@gmail.com');
select inserir_cliente('maria vitoria','maria@gmail.com');
select * from cliente;
select * from funcionario;
insert into funcionario ('marlysson',2500);
--insert into funcionario ('pereira',2000);


ALTER TABLE public.funcionario ALTER COLUMN funcionario_id TYPE serial USING funcionario_id::int4 ;

delete  from mes;
drop table funcionario;

select * from funcionario;

