-- ET4.1 - Crie um trigger, que valide as alteração na instância de trabalha_em considerando a seguinte restrição:
			-- Um funcionário não pode ter carga horária de trabalho superior a 40h
		-- Regras:
			-- Nome do trigger: valida40horas
			-- Nome da function: valida40horas
			-- Utilize RAISE NOTICE / EXCEPTION para incluir mensagens na sua function  

-- Definição da function

DROP FUNCTION IF EXISTS valida40horas CASCADE;
CREATE OR REPLACE FUNCTION valida40horas() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.horas > 40.0 THEN
		RAISE EXCEPTION 'Um funcionário não pode ter carga horária de trabalho superior a 40h!';
	ELSE
		RAISE NOTICE 'Carga horária váida.';
		RETURN NEW;
		END IF;
END;
$$ LANGUAGE PLPGSQL;

-- Definição do trigger

DROP TRIGGER IF EXISTS valida40horas ON trabalha_em;
CREATE TRIGGER valida40horas
BEFORE INSERT OR UPDATE ON trabalha_em
FOR EACH ROW EXECUTE PROCEDURE valida40horas();

-- 4.2 Crie um comando SQL para remover a function e o trigger

DROP FUNCTION IF EXISTS valida40horas CASCADE;
DROP TRIGGER IF EXISTS valida40horas ON trabalha_em;

-- 4.3 Crie um comando SQL para testar todas as ações de seu trigger

INSERT INTO trabalha_em (fcpf, pnr, horas) VALUES ('987654321', 10, 41);

-- Ou também

UPDATE trabalha_em SET horas = 40.1 WHERE fcpf = '666884444' AND pnr = 3;
