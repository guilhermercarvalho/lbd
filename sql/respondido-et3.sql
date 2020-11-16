-- ET3.1 - Crie um trigger, que valide as alteração na instância de funcionario considerando a seguinte restrição:
		-- Um funcionário não pode ser supervisor dele mesmo
		-- Regras:
			-- Nome do trigger: validafuncsupervisor
			-- Nome da function: validafuncsupervisor
			-- Utilize RAISE NOTICE / EXCEPTION para incluir mensagens na sua function  

-- Definição da function

DROP FUNCTION IF EXISTS validafuncsupervisor CASCADE;
CREATE OR REPLACE FUNCTION validafuncsupervisor() RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'INSERT' AND NEW.cpf_supervisor = NEW.cpf)
		OR (TG_OP = 'UPDATE' AND ( OLD.cpf_supervisor = NEW.cpf
			OR NEW.cpf_supervisor = OLD.cpf)
			OR NEW.cpf_supervisor = NEW.cpf) THEN
		RAISE EXCEPTION 'Um funcionário não pode ser supervisor dele mesmo!';
	ELSE
		RAISE NOTICE 'Funcionário váido.';
		RETURN NEW;
		END IF;
END;
$$ LANGUAGE PLPGSQL;

-- Definição do trigger

DROP TRIGGER IF EXISTS validafuncsupervisor ON funcionario;
CREATE TRIGGER validafuncsupervisor
BEFORE INSERT OR UPDATE ON funcionario
FOR EACH ROW EXECUTE PROCEDURE validafuncsupervisor();

-- 3.2 Crie um comando SQL para remover a function e o trigger

DROP FUNCTION IF EXISTS validafuncsupervisor CASCADE;
DROP TRIGGER IF EXISTS validafuncsupervisor ON funcionario;

-- 3.3 Crie um comando SQL para testar todas as ações de seu trigger

INSERT INTO funcionario (pnome, minicial, unome, cpf, datanasc, endereco, sexo, salario, cpf_supervisor, dnr) VALUES ('Guilherme', 'R', 'Carvalho', '1112224444', '1999-4-13', '450 Stone, Biden, TIX', 'M', 11000, NULL, 1);

UPDATE funcionario SET cpf_supervisor = '1112224444' WHERE cpf = '1112224444';

DELETE FROM funcionario WHERE cpf = '1112224444';

-- Ou também

INSERT INTO funcionario (pnome, minicial, unome, cpf, datanasc, endereco, sexo, salario, cpf_supervisor, dnr) VALUES ('Guilherme', 'R', 'Carvalho', '1112224444', '1999-4-13', '450 Stone, Biden, TIX', 'M', 11000, '1112224444', 1);
