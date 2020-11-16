-- B2.1 Crie uma função para inserir um novo funcionário na tabela t_funcionario. 
-- Essa função deve receber os atributos da tabela como parâmetro e, ao final do operação, escrever uma mensagem de sucesso.
-- Nome da function: insereFuncionario

CREATE OR REPLACE FUNCTION insereFuncionario(
  _pnome varchar(255),
  _cpf varchar(255),
  _sexo character(2),
  _salario numeric,
  _cpf_supervisor varchar(11),
  _dnr integer
) RETURNS text AS $$
BEGIN
INSERT INTO t_funcionario (pnome, cpf, sexo, salario, cpf_supervisor, dnr)
values (
    _pnome,
    _cpf,
    _sexo,
    _salario,
    _cpf_supervisor,
    _dnr
  );
RETURN 'Funcionario ' || _pnome || ' inserido com sucesso!';
END;
$$ LANGUAGE PLPGSQL

-- B2.2. Faça uma chamada a função criada para inserir um novo registro

SELECT inserefuncionario('Guilherme'::varchar, '123549876'::varchar, 'M'::character, 400, '12345678'::varchar, 5);

-- B2.3. Apaga a função definida

DROP FUNCTION IF EXISTS insereFuncionario;
