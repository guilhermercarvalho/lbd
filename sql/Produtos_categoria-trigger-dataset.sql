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

CREATE TABLE produto_avg_preco(
  id_categoria integer, 
  avg_preco numeric, 
  data_alteracao timestamp,
  tipo char(1) NOT NULL, check (tipo in ('I','U','D'))
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
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (6, 'Red Toaster',  30, 9.25,  9);
INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (7, 'Black Chair',  30, 10,  4);