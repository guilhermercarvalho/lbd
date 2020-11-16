DROP TABLE IF EXISTS produto cascade;
DROP TABLE IF EXISTS categoria cascade;
DROP TABLE IF EXISTS produto_log cascade;

CREATE TABLE categoria (
  id numeric PRIMARY KEY,
  nome varchar(255)
);

CREATE TABLE produto (
  id numeric PRIMARY KEY,
  nome varchar (255),
  quantidade numeric,
  preco numeric,
  id_categoria numeric NULL,
  FOREIGN KEY (id_categoria) REFERENCES categoria (id)
);

CREATE TABLE produto_log(
  id_produto integer, 
  preco_antigo numeric, 
  preco_novo numeric, 
  data_alteracao timestamp,
  tipo char(1) NOT NULL,
  check (tipo in ('U','D'))
);

INSERT INTO categoria (id, nome) VALUES (1, 'Superior');
INSERT INTO categoria (id, nome) VALUES (2, 'Super Luxury');
INSERT INTO categoria (id, nome) VALUES (3, 'Modern');
INSERT INTO categoria (id, nome) VALUES (4, 'Nerd');
INSERT INTO categoria (id, nome) VALUES (5, 'Infantile');
INSERT INTO categoria (id, nome) VALUES (6, 'Robust');
INSERT INTO categoria (id, nome) VALUES (9, 'Wood');

INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (1, 'Blue Chair', 30, 300.00, 9);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (2, 'Red Chair',  200,  2150.00, 2);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (3, 'Disney Wardrobe',  400,  829.50, 4);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (4, 'Blue Toaster', 20, 9.90, 3);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (5, 'Solar Panel',  30, 3000.25,  4);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (6, 'Red Toaster',  30, 9.25,  NULL);

-- 1. Crie um trigger chamado produtolog que chame uma function com o mesmo nome.
-- Esse trigger deve ser disparado sempre que for alterado o preço do produto.
-- Nesse caso, uma tupla é inserida na tabela produto_log
-- Dica: Utilize CURRENT_DATE para inserir a data atual

-- Definição da function
  
DROP FUNCTION IF EXISTS produtolog CASCADE;
CREATE OR REPLACE FUNCTION produtolog() RETURNS TRIGGER AS $$
BEGIN
IF (TG_OP IN ('INSERT', 'UPDATE')) THEN
INSERT INTO produto_log(id_produto, preco_antigo, preco_novo, data_alteracao, tipo)
values (
	NEW.id,
	OLD.preco, 
	NEW.preco, 
	CURRENT_DATE,
	'U'
);
RETURN NEW;
ELSIF (TG_OP = 'DELETE') THEN
INSERT INTO produto_log(id_produto, preco_antigo, preco_novo, data_alteracao, tipo)
values (
	OLD.id,
	OLD.preco, 
	NEW.preco, 
	CURRENT_DATE,
	'D'
);
RETURN OLD;
END IF;
END;
$$ LANGUAGE PLPGSQL;

--Definição do trigger

DROP TRIGGER IF EXISTS produtolog ON produto;
CREATE TRIGGER produtolog
AFTER INSERT OR DELETE OR UPDATE OF preco ON produto
FOR EACH ROW EXECUTE PROCEDURE produtolog();

-- 2. Crie os comandos SQL necessários para testar todas as opções de ação do seu trigger
  
UPDATE produto SET preco=5000 WHERE id=1;
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (7, 'Door',  100, 340.25,  9);
DELETE FROM produto WHERE id = 2;

-- 3. Crie comandos SQL para apagar o trigger e a function

DROP FUNCTION IF EXISTS produtolog CASCADE;
DROP TRIGGER IF EXISTS produtolog ON produto;
