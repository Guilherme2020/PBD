--creates tables
--
--
--e roda essas queries:
--
--
-- OK
--create table cliente(
--  id serial not null primary key,
--  nome varchar(255),
--  email varchar(255)
--);
--
-- OK
--create table funcionario(
--  id serial not null primary key,
--  nome varchar(255),
--  salario float
--);
--
-- OK
--create table mes(
--  id serial not null primary key,
--  descricao varchar(20)
--);
--
-- OK
--create table tipo_pagamento(
--  id serial not null primary key,
--  descricao varchar(255)
--);
--
-- OK
--create table funcionario (
--  id serial not null primary key,
--  nome varchar(255) not null,
--  salario float not null
--);
--
--create table salario_mes (
--   id serial not null primary key,
--   funcionario_id int not null,
--   mes_id int not null,
--   salario float not null,
--
--   foreign key (funcionario_id) references funcionario(id),
--   foreign key (mes_id) references mes(id)
--);
--
-- OK
--create table acompanhamento(
-- id serial not null primary key,
-- nome varchar(255) not null,
-- status boolean not null,
-- preco FLOAT not null,
-- quantidade int not null
--);
--
-- OK
--create table complemento(
-- id serial not null primary key,
-- nome varchar(255) not null,
-- status boolean not null,
-- preco float not null,
-- quantidade int not null
--);
--
--create table prato_do_dia(
-- id serial not null primary key,
-- preco float not null,
-- diaOferta date not null,
-- complemento_id int not null,
--
-- foreign key (complemento_id) references complemento(id)
--);
--
--
--create table pedido(
-- id serial not null primary key,
-- data_pedido date not null,
-- valor_total float not null,
-- pago boolean not null,
-- tipo varchar(255) not null,
--
-- cliente_id int not null,
-- funcionario_id int not null,
-- acompanhamento_id int not null,
-- tipo_pagamento_id int not null,
-- prato_do_dia_id int not null,
--
-- foreign key (cliente_id) references cliente(id),
-- foreign key (funcionario_id) references funcionario(id),
-- foreign key (acompanhamento_id) references acompanhamento(id),
-- foreign key (tipo_pagamento_id) references tipo_pagamento(id),
-- foreign key (prato_do_dia_id) references prato_do_dia(id)
--);
--
--create table item_complemento(
-- id serial not null primary key,
-- pedido_id int not null,
-- complemento_id int not null,
--
-- foreign key (pedido_id) references pedido(id),
-- foreign key (complemento_id) references complemento(id)
--);
--
--create table item_prato_principal(
-- id int not null primary key,
-- pedido_id int not null,
-- prato_principal_id int not null,
--
-- foreign key (pedido_id) references pedido(id),
-- foreign key (prato_principal_id) references prato_principal(id)
--);
--
--
--
-- OK
create table cliente(
  id serial not null primary key,
  nome varchar(255),
  email varchar(255)
);

-- OK
create table funcionario(
  id serial not null primary key,
  nome varchar(255),
  salario float
);

-- OK
create table mes(
  id serial not null primary key,
  descricao varchar(20)
);


-- OK
create table tipo_pagamento(
  id serial not null primary key,
  descricao varchar(255)
);


create table salario_mes (
   id serial not null primary key,
   funcionario_id int not null,
   mes_id int not null,
   salario float not null,

   foreign key (funcionario_id) references funcionario(id),
   foreign key (mes_id) references mes(id)
);

-- OK
create table acompanhamento(
 id serial not null primary key,
 nome varchar(255) not null,
 status varchar(255) not null,
 preco boolean not null,
 quantidade int not null
);

-- OK
create table complemento(
 id serial not null primary key,
 nome varchar(255) not null,
 status varchar(255) not null,
 preco boolean not null,
 quantidade int not null
);

-- OK
create table prato_do_dia(
 id serial not null primary key,
 preco float not null,
 diaOferta date not null,
 complemento_id int not null,

 foreign key (complemento_id) references complemento(id)
);

-- OK
create table prato_principal(
 id serial not null primary key,
 nome varchar(255) not null,
 status boolean not null,
 preco float not null,
 quantidade int not null
);

-- OK
create table complemento_prato_do_dia(
 id serial not null primary key,
 complemento_id int not null,
 prato_do_dia_id int not null,
 quantidade int not null,

 foreign key (complemento_id) references complemento(id),
 foreign key (prato_do_dia_id) references prato_do_dia(id)
);
-- OK
create table prato_principal_prato_do_dia(
 id serial not null primary key,
 prato_principal_id int not null,
 prato_do_dia_id int not null,

 foreign key (prato_principal_id) references prato_principal(id),
 foreign key (prato_do_dia_id) references prato_do_dia(id)
);
-- OK
create table complemento_prato_do_dia(
 id serial not null primary key,
 complemento_id int not null,
 prato_do_dia_id int not null,
 quantidade int not null,

 foreign key (complemento_id) references complemento(id),
 foreign key (prato_do_dia_id) references prato_do_dia(id)
);


create table pedido(
 id serial not null primary key,
 data_pedido date not null,
 valor_total float not null,
 pago boolean not null,
 tipo varchar(255) not null,

 cliente_id int not null,
 funcionario_id int not null,
 acompanhamento_id int not null,
 tipo_pagamento_id int not null,
 prato_do_dia_id int not null,

 foreign key (cliente_id) references cliente(id),
 foreign key (funcionario_id) references funcionario(id),
 foreign key (acompanhamento_id) references acompanhamento(id),
 foreign key (tipo_pagamento_id) references tipo_pagamento(id),
 foreign key (prato_do_dia_id) references prato_do_dia(id)
);

create table item_complemento(
 id serial not null primary key,
 pedido_id int not null,
 complemento_id int not null,

 foreign key (pedido_id) references pedido(id),
 foreign key (complemento_id) references complemento(id)
);

create table item_prato_principal(
 id serial not null primary key,
 pedido_id int not null,
 prato_principal_id int not null,

 foreign key (pedido_id) references pedido(id),
 foreign key (prato_principal_id) references prato_principal(id)
);


