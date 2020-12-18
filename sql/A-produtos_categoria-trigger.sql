--NOME: Guilherme Ribeiro de Carvalho
--RGA: 2018.1907.071-9

-- Envie o arquivo abaixo devidamente respondido.

-- --------------------------------------------------------
-- A1. Crie um trigger chamado atualizamediaprecoA que chame uma function com o mesmo nome.
-- Esse trigger deve ser disparado sempre que for alterado (inserido ou atualizado) o preço do produto. 
--Regras:
  -- - Sempre que houver a alteração do produto, atualize a tabela produto_avg_preco com a média de preço do produto por categoria
  -- - Caso não haja um registro do produto na tabela produto_avg_preco, inserir um novo registro considerando a média atual
    -- - Após qualquer mudança nos regitros de produto_avg_preco, imprimir uma mensagem com os novos valores
      -- produto_avg_preco INSERIDO: id_categoria:<valor_categoria>, avg_preco:<media_preco>, data_alteracao:<data_alteracao>, tipo:I
      -- produto_avg_preco ATUALIZADO: id_categoria:<valor_categoria>, avg_preco:<media_preco>, data_alteracao:<data_alteracao>, tipo:U

-- Dica: Utilize CURRENT_DATE para inserir a data atual; Considere na tabela produto_avg_preco os tipos I (Insert), U (Update) e D (delete)

-- Nome do trigger e do function: atualizamediaprecoA

DROP FUNCTION IF EXISTS atualizamediaprecoA CASCADE;
CREATE OR REPLACE FUNCTION atualizamediaprecoA() RETURNS TRIGGER AS $$
DECLARE
    avg_result NUMERIC;
    date_current TIMESTAMP;
BEGIN
  date_current := CURRENT_DATE;
  IF (TG_OP = 'INSERT') THEN
    avg_result := (SELECT ROUND(AVG(preco), 2) from produto where id_categoria=NEW.id_categoria);
    INSERT INTO produto_avg_preco(id_categoria, avg_preco, data_alteracao, tipo)
    VALUES (NEW.id_categoria, avg_result, date_current, 'I');
    
    RAISE NOTICE 'produto_avg_preco INSERIDO: id_categoria:%, avg_preco:%, data_alteracao:%, tipo:I', NEW.id_categoria, avg_result, date_current;
    
    RETURN NEW;
  ELSIF (TG_OP = 'UPDATE') THEN
    avg_result := (SELECT ROUND(AVG(preco), 2) from produto where id_categoria=NEW.id_categoria);
    UPDATE produto_avg_preco
    SET id_categoria=NEW.id_categoria,
      avg_preco=avg_result,
      data_alteracao=date_current,
      tipo='U'
    WHERE id_categoria = NEW.id_categoria;
    RAISE NOTICE 'produto_avg_preco ATUALIZADO: id_categoria:%, avg_preco:%, data_alteracao:%, tipo:U', NEW.id_categoria, avg_result, date_current;
    RETURN NEW;
  END IF;
END;
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS atualizamediaprecoA ON produto;
CREATE TRIGGER atualizamediaprecoA
AFTER INSERT OR UPDATE ON produto
FOR EACH ROW EXECUTE PROCEDURE atualizamediaprecoA();


-- --------------------------------------------------------
-- A2. Crie os comandos SQL necessários para testar todas as opções de ação do seu trigger

        INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (8, 'Glass Table',  5,  100.00, 2);
        UPDATE produto SET preco=500.00 where id=8;
				INSERT INTO produto (id, nome, quantidade, preco, id_categoria) VALUES (9, 'Glass Chair',  5,  200.00, 9);

-- --------------------------------------------------------
-- A3. Crie comandos SQL para apagar o trigger e a function (dois comandos distintos).

				DROP FUNCTION IF EXISTS atualizamediaprecoA CASCADE;
        DROP TRIGGER IF EXISTS atualizamediaprecoA ON produto;
