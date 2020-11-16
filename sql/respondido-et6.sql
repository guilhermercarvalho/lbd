select * from trabalha_em;
-- ET6

-- 6.1 Crie um comando SQL para alterar a tabela funcionario adicionando a coluna idadefunc (integer) 

ALTER TABLE funcionario ADD idadefunc INTEGER;

-- 6.2 Crie uma função chamada que receba como parâmetro o cpf do funcionário (varchar(11)) e retorne um inteiro com a sua idade. 
		-- Observações:
			-- Nome da function: calculaIdade
			-- Dica: para calcular a idade utilize a seguinte consulta: select extract(year from age(datanasc)) from funcionario where cpf=<parametro>;

DROP FUNCTION IF EXISTS calculaIdade;
CREATE OR REPLACE FUNCTION calculaIdade(_cpf varchar(11)) RETURNS INTEGER AS $$
BEGIN
	RETURN (SELECT EXTRACT(YEAR FROM AGE(datanasc)) FROM funcionario WHERE cpf = _cpf);
END;
$$ LANGUAGE PLPGSQL;


-- 6.3 - Utilizando a function desenvolvida em 6.2, crie um trigger chamada  com as seguintes regras:
		-- Cada vez que for inserida/atualizado uma nova tupla ou o campo datanasc calcule a idade desse funcionário a partida da sua data de nascimento (datanasc) e 
		-- atualize o campo idadefunc deste funcionário com esse valor calculado. 
		-- Ao atualizar o campo exiba uma mensagem com o nome do funcionário, sua data de nascimento e a idade calculada
		
		-- Nome do trigger: atualizaidade
		-- Nome da function: atualizaidade
		-- Utilize RAISE NOTICE / EXCEPTION para incluir mensagens na sua function  

		-- Definição da function
		
DROP FUNCTION IF EXISTS atualizaidade CASCADE;
CREATE OR REPLACE FUNCTION atualizaidade() RETURNS TRIGGER AS $$
BEGIN
	UPDATE funcionario SET idadefunc = (SELECT calculaIdade(NEW.cpf)) WHERE cpf = NEW.cpf;
	RAISE NOTICE 'Funcionário %, nacido(a) em % tem % anos.', NEW.pnome, NEW.datanasc, NEW.idade;
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

		-- Definição do trigger

DROP TRIGGER IF EXISTS atualizaidade ON funcionario;
CREATE TRIGGER atualizaidade
AFTER INSERT OR UPDATE ON funcionario
FOR EACH STATEMENT EXECUTE PROCEDURE atualizaidade();

-- 6.4 Crie um comando SQL para testar a função calculaidade

SELECT calculaIdade('888665555');

-- 6.5 Crie um comando SQL para apagar a função calculaidade

DROP FUNCTION IF EXISTS calculaIdade;

-- 6.6 Crie comandos SQL para testar todas as ações de seu trigger

UPDATE funcionario SET minicial = 'G' WHERE cpf = '888665555';
INSERT INTO funcionario (pnome, minicial, unome, cpf, datanasc, endereco, sexo, salario, cpf_supervisor, dnr)
VALUES ('Sansa', 'T', 'Stark', '888665556', '1998-08-12', '450 Stone, Winterfell, TX', 'M' , 1000000, NULL, 1);

-- 6.7 Crie um comando SQL para remover a function e o trigger

DROP FUNCTION IF EXISTS atualizaidade CASCADE;
DROP TRIGGER IF EXISTS atualizaidade ON funcionario;
