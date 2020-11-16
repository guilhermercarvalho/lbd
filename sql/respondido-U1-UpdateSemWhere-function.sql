drop table if exists produto;
create table produto (
id numeric primary key,
nome varchar(50),
tipo char,
preco numeric
);

insert into produto (id, nome, tipo, preco) values (1, 'Monitor','B',0);
insert into produto (id, nome, tipo, preco) values (2, 'Headset','A',0);
insert into produto (id, nome, tipo, preco) values (3, 'PC Case','A',0);
insert into produto (id, nome, tipo, preco) values (4, 'Computer Desk','C',0);
insert into produto (id, nome, tipo, preco) values (5, 'Gaming Chair','C',0);
insert into produto (id, nome, tipo, preco) values (6, 'Mouse','A',0);
-- insert into produto (id, nome, tipo, preco) values (7, 'Teclado','D',0);
-- delete from produto where id = 7;ls

-- U1.1 Ana se encontra em uma emboscada porque fez um update sem where e acabou zerando todos os valores da coluna preco. Para sua sorte, o preco pode ser calculado novamente sabendo o tipo do produto.
-- 
-- Se o tipo do produto é igual A, o preco será 22.0
-- Se o tipo do produto é igual B, o preco será 75.0
-- Se o tipo do produto é igual C, o preco será 53.5
-- O seu trabalho é criar um function que corrige preco de todos os produtos. 
-- Nome da function: corrigeUpdateSemWhere

CREATE OR REPLACE FUNCTION corrigeUpdateSemWhere(tipo char) RETURNS NUMERIC
AS $$
BEGIN
	IF tipo = 'A' THEN
		RETURN 22.0;
	ELSIF tipo = 'B' THEN
		RETURN 75.0;
	ELSIF tipo = 'C' THEN
		RETURN 53.5;
	ELSE
		RAISE EXCEPTION 'Não parametrizado: %', tipo;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

-- U1.2 Crie um comando SQL para fazer uma chamada à function definida

SELECT id, nome, tipo, corrigeupdatesemwhere(tipo) AS preco FROM produto;

-- U1.3 Crie um comando SQL para remover a function definida

DROP FUNCTION corrigeupdatesemwhere(character)
