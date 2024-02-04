-- 1. A Diretora Camilla Prado solicitou uma pesquisa que informe todAS AS OBRAS cadAStradAS no acervo ordenadAS por data de publicação.

SELECT 
	ID_OBRA AS 'id OBRA',
    TITULO_OBRA AS 'Título OBRA',
    AUTOR.NOME_ALTOR AS 'AUTOR',
    NUMERO_PUBLICACAO AS 'Número de Publicação',
    GENERO AS 'Gênero',
    DATE_FORMAT(DATA_PUBLICACAO, '%d/%m/%Y') AS 'Data de Publicação',
	EDITORA.NOME_EDITORA AS 'Editora'
FROM OBRA
INNER JOIN AUTOR ON OBRA.ID_AUTOR = AUTOR.ID_AUTOR
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA
ORDER BY DATA_PUBLICACAO;

-- 2. O Governador vai doar duzentos livros para a Biblioteca, mAS só irá doar se a biblioteca tiver menos de 300 OBRAS.
--  O Gerente Márcio Tales solicitou que fosse feita a contagem de quantAS OBRAS a Biblioteca possui atualmente.

SELECT
	COUNT(ID_OBRA) AS 'Quantidade de livros diferentes',
    (SELECT SUM(QUANTIDADE_LIVRO) FROM ESTOQUE) AS 'Quantidade total de Livros'
FROM
	OBRA;

-- 3. A Gerência solicitou uma pesquisa para saber quais datAS ocorreram empréstimos de livros e a quantidade emprestada.
-- A consulta deverá retornar apenAS um registro para cada data.

SELECT 
	DATE_FORMAT(DATA_EMPRESTIMO, '%d/%m/%Y') AS 'DatAS de EMPRESTIMOs',
	COUNT(DATA_EMPRESTIMO) AS 'EMPRESTIMOs por dia'
FROM EMPRESTIMO
GROUP BY  DATA_EMPRESTIMO
ORDER BY COUNT(DATA_EMPRESTIMO)DESC;

-- 4. O Funcionário João Paulo ASsistente de RH solicitou uma pesquisa que informASse todos os empréstimos que a 
-- Recepcionista Alice Meire fez no horário dAS 8hs AS 9hs.

-- a - Cada EMPRESTIMO que a funcionária fez entre os horários
SELECT
	FUNCIONARIO.NOME_FUNCIONARIO AS 'Nome do Funcionário',
    DATE_FORMAT(EMPRESTIMO.HORA_EMPRESTIMO, '%H:%m') AS 'Horário dos empréstimos'
FROM EMPRESTIMO INNER JOIN FUNCIONARIO ON EMPRESTIMO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
WHERE EMPRESTIMO.ID_FUNCIONARIO = 8 AND HORA_EMPRESTIMO BETWEEN '8:00' AND '9:00';

-- b - Todos EMPRESTIMOs que a funcionária fez entre os horários
SELECT 
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Nome do Funcionário',
    COUNT(FUNCIONARIO.NOME_FUNCIONARIO) AS 'Total de empréstimos' 
FROM EMPRESTIMO INNER JOIN FUNCIONARIO ON EMPRESTIMO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
WHERE EMPRESTIMO.ID_FUNCIONARIO = 8 AND HORA_EMPRESTIMO BETWEEN '8:00' AND '9:00';

-- 5. A Diretoria solicitou uma pesquisa sobre devolução de livros entre AS datAS 29/03/2012 a 02/02/2013.

SELECT
	FUNCIONARIO.NOME_FUNCIONARIO AS 'Funcionário',
    USUARIO.NOME_USUARIO AS 'Usuário',
    DATE_FORMAT(DATA_DEVOLUCAO, '%d/%m/%Y') AS 'DatAS de devolução',
    DATE_FORMAT(HORA_DEVOLUCAO, '%H:%m') AS 'Horário de devolução',
    (CASE WHEN MULTA_ATRASO = 0 THEN 'Não'
		  WHEN MULTA_ATRASO = 1 THEN 'Sim' END)  AS Multa
FROM DEVOLUCAO
INNER JOIN FUNCIONARIO ON DEVOLUCAO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
INNER JOIN USUARIO ON DEVOLUCAO.ID_USUARIO = USUARIO.ID_USUARIO
WHERE (DATA_DEVOLUCAO BETWEEN '2012-03-29' AND '2013-02-02')
ORDER BY DATA_DEVOLUCAO;

-- 6. A Gerência solicitou uma pesquisa para saber quais reservAS de livros que foram feitAS com 
-- data maior  ou igual a 18/08/2011 que ainda possuem o status de “reservado”.

SELECT
    ID_RESERVA AS 'id Reserva',
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Funcionário',
    USUARIO.NOME_USUARIO AS 'Usuário',
    OBRA.TITULO_OBRA AS 'OBRA',
    STATUS_LIVRO AS 'Status',
    DATE_FORMAT(DATA_RESERVA, '%d/%m/%Y') AS 'DatAS de reserva',
	DATE_FORMAT(HORA_RESERVA, '%H:%m') AS 'Horário de resserva'
FROM RESERVA
INNER JOIN FUNCIONARIO ON RESERVA.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
INNER JOIN USUARIO ON RESERVA.ID_USUARIO = USUARIO.ID_USUARIO
INNER JOIN OBRA ON RESERVA.ID_OBRA = OBRA.ID_OBRA
WHERE DATA_RESERVA >= '2011-08-18' AND STATUS_LIVRO = 'Reservado';

-- 7. A área de RH solicitou uma pesquisa para saber quais devoluções de livros  foram feitAS antes de 29/03/2012.

SELECT
	ID_DEVOLUCAO AS 'id Devolução',
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Funcionário',
    USUARIO.NOME_USUARIO AS 'Usuário',
    OBRA.TITULO_OBRA AS 'OBRA',
    DATE_FORMAT(DATA_DEVOLUCAO, '%d/%m/%Y') AS 'Data de devolução',
	DATE_FORMAT(HORA_DEVOLUCAO, '%H:%m') AS 'Horário de devolução'
FROM DEVOLUCAO
INNER JOIN FUNCIONARIO ON DEVOLUCAO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
INNER JOIN USUARIO ON DEVOLUCAO.ID_USUARIO = USUARIO.ID_USUARIO
INNER JOIN OBRA ON DEVOLUCAO.ID_OBRA = OBRA.ID_OBRA
WHERE DATA_DEVOLUCAO < '2012-03-29'
ORDER BY DATA_DEVOLUCAO DESC;

-- 8. A Gerência solicitou uma pesquisa para saber quais OBRAS existem no acervo que
--  são diferentes dos títulos dAS OBRAS ‘O Conde de Monte Cristo’ e ‘Filhos e Amantes’  .

SELECT
	ESTOQUE.ID_ESTOQUE AS 'id Estoque',
	OBRA.TITULO_OBRA AS 'Título da OBRA',
    ESTOQUE.QUANTIDADE_LIVRO AS 'Quantidade em estoque',
    CONCAT('R$ ',REPLACE(ESTOQUE.VALOR_UNITARIO, '.', ',')) AS 'Valor Unitário'
FROM ESTOQUE
INNER JOIN OBRA ON ESTOQUE.ID_OBRA = OBRA.ID_OBRA
WHERE TITULO_OBRA <> 'O conde de Monte Cristo' AND tITULO_OBRA <> 'Filhos e Amantes'
ORDER BY ESTOQUE.ID_ESTOQUE ;

-- 9. O Funcionário João Paulo solicitou uma pesquisa para saber quantAS OBRAS do gênero ‘Ficção’ existem no acervo.

SELECT ESTOQUE.ID_ESTOQUE AS 'id Estoque',
	OBRA.TITULO_OBRA AS 'Título da OBRA',
    OBRA.GENERO AS 'Gênero',
    ESTOQUE.QUANTIDADE_LIVRO AS 'Quantidade em estoque',
    CONCAT('R$ ',REPLACE(ESTOQUE.VALOR_UNITARIO, '.', ',')) AS 'Valor Unitário'
FROM ESTOQUE
INNER JOIN OBRA ON ESTOQUE.ID_OBRA = OBRA.ID_OBRA
WHERE OBRA.GENERO = 'Ficção'
ORDER BY ESTOQUE.ID_ESTOQUE;

-- 10. A Diretoria solicitou uma pesquisa para identificar qual o livro possuiu a maior quantidade em estoque,
--  incluir respectiva editora e o respectivo AUTOR.

SELECT 
	ESTOQUE.ID_OBRA AS 'id Estoque',
    EDITORA.NOME_EDITORA AS 'Editora',
	OBRA.TITULO_OBRA AS 'Título',
	MAX(QUANTIDADE_LIVRO) AS 'Quantidade em estoque',
    CONCAT('R$ ',REPLACE(VALOR_UNITARIO, '.', ',')) AS 'Valor unitário'
FROM ESTOQUE
INNER JOIN OBRA ON ESTOQUE.ID_OBRA = OBRA.ID_OBRA
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA;

-- 11. O Financeiro precisa saber qual é o livro  que possui a menor quantidade em estoque
--  e quantAS vezes ele foi emprestado para que seja feita uma analise para compra de mais alguns exemplares.

SELECT 
	OBRA.ID_OBRA AS 'Id OBRA',
	OBRA.TITULO_OBRA AS 'Título',
	(SELECT MIN(QUANTIDADE_LIVRO) FROM ESTOQUE) AS 'Quantidade em estoque',
	COUNT(DATA_EMPRESTIMO) AS 'Quantidade de empréstimos'
FROM EMPRESTIMO
INNER JOIN OBRA ON EMPRESTIMO.ID_OBRA = OBRA.ID_OBRA
GROUP BY EMPRESTIMO.ID_OBRA
ORDER BY COUNT(DATA_EMPRESTIMO) DESC
LIMIT 1;

-- 12. A área de RH precisa identificar a quantidade total dos empréstimos feitos por cada funcionário ativos.

SELECT 
	FUNCIONARIO.ID_FUNCIONARIO AS 'Id Funcionário',
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Nome',
	COUNT(EMPRESTIMO.ID_FUNCIONARIO) AS 'Quantidade de EMPRESTIMOs'
FROM EMPRESTIMO
INNER JOIN FUNCIONARIO ON EMPRESTIMO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
WHERE FUNCIONARIO.DATA_DEMISSAO = '9999-01-01'
GROUP BY EMPRESTIMO.ID_FUNCIONARIO;

-- 13. A Diretoria pediu para identificar AS OBRAS com os maiores números de publicações agrupados por gênero.


SELECT 
	OBRA.ID_OBRA AS 'Id OBRA',
	OBRA.TITULO_OBRA 	AS 'Título',
    EDITORA.NOME_EDITORA AS 'Editora',
    OBRA.NUMERO_PUBLICACAO AS 'Número Publicações',
    OBRA.GENERO AS 'Gênero',
    ESTOQUE.QUANTIDADE_LIVRO AS 'Quantidade em Estoque'
FROM OBRA
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA
INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_OBRA
ORDER BY GENERO ASC, NUMERO_PUBLICACAO DESC;

-- 14. A Funcionária Alice Meire solicitou a alteração da OBRA ‘Discurso do Método’ para o gênero Político.

SELECT 
	ID_OBRA AS 'iD OBRA',
    TITULO_OBRA AS 'Título',
    GENERO AS 'Gênero',
    EDITORA.NOME_EDITORA AS 'Editora'
FROM OBRA 
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA
WHERE TITULO_OBRA = 'Discurso do Método';

UPDATE OBRA
SET GENERO = 'Político'
WHERE TITULO_OBRA = 'Discurso do Método';

-- 15. A Recepcionista Alice Meire solicitou a alteração do bairro do usuário ‘Alberto Roberto’ que morava no ‘IAPI’
--   e agora mora no bairro de 'Perdizes'.

SELECT 
	ID_USUARIO AS 'id Usuário',
    NOME_USUARIO AS 'Nome',
    CONCAT(LEFT(CPF,3),'.', SUBSTRING(CPF,4,3), '.',SUBSTRING(CPF,7,3), '-', RIGHT(CPF,2)) AS 'CPF',
    ENDERECO AS 'Endereço',
    NUMERO AS 'Número',
    BAIRRO AS 'Bairro',
    CONCAT(LEFT(CEP, 5),'-',RIGHT(CEP,3)) AS 'CEP'
FROM USUARIO
WHERE NOME_USUARIO = 'Alberto Roberto';

UPDATE USUARIO
SET BAIRRO = 'Perdizes'
WHERE NOME_USUARIO = 'Alberto Roberto';

-- 16. A Biblioteca recebeu a visita de um grupo de alunos, mAS após a visita foi verificado desaparecimento de três livros,
--  AS OBRAS que sumiram do acervo foram ‘Filho Nativo’, ‘VidAS SecAS’ e ‘Dom CASmurro’,
--  com isto será necessária a alteração da quantidade de livros no estoque de cada OBRA.

SELECT
	ESTOQUE.ID_ESTOQUE AS 'Id Estoque',
    OBRA.ID_OBRA AS 'Id OBRA',
    OBRA.TITULO_OBRA AS 'Título',
    QUANTIDADE_LIVRO AS 'Quantidade em Estoque'
FROM ESTOQUE
INNER JOIN OBRA ON ESTOQUE.ID_OBRA = OBRA.ID_OBRA
WHERE OBRA.TITULO_OBRA = 'Filho Nativo' OR OBRA.TITULO_OBRA ='VidAS SecAS' OR OBRA.TITULO_OBRA ='Dom CASmurro';

UPDATE
	ESTOQUE
    INNER JOIN OBRA ON ESTOQUE.ID_OBRA = OBRA.ID_OBRA
    SET
    ESTOQUE. QUANTIDADE_LIVRO = (ESTOQUE.QUANTIDADE_LIVRO-1)
    WHERE OBRA.TITULO_OBRA = 'Filho Nativo' OR OBRA.TITULO_OBRA ='VidAS SecAS' OR OBRA.TITULO_OBRA ='Dom CASmurro';
    
-- 17. A Recepcionista Claudia Cristina não conseguiu terminar o cadAStro de cinco usuários que pASsaram pela Biblioteca,
--  foi solicitado a inserção desses usuários. São eles: 
-- 31, Alfredo Tenttoni, Rua AmazonAS 58, Pirai, 6549-5421, 02170-251, 294.264.875-32
-- 32, Cindy Crall, Rua Ipiranga 123, Vila Cristal, 5846-6577, 02182-637, 122.147.655-49
-- 33, Rubens Pardo, Avenida dos Monges 51, Campo Grande, 5184-8978, 52412-365, 654.586.472-98
-- 34, Carlos Pracidelli, Travessa dos Irmãos 48, Cotia, 8945-7986, 23124-005, 341.251.651-75
-- 35, Ernesto Coimbra, Avenida Ampére 414, Jardim Elvira, 5844-2654, 05728-368, 193.107.214-35    

SELECT * FROM USUARIO;
SELECT * FROM USUARIO_NOVO;
DROP TABLE IF EXISTS USUARIO_NOVO;
CREATE TABLE IF NOT EXISTS USUARIO_NOVO (
	ID_USUARIO TEXT NOT NULL,
    NOME_USUARIO TEXT NOT NULL,
	LOGRADOURO TEXT NOT NULL,
    BAIRRO TEXT NOT NULL,
    TEL1  TEXT NOT NULL,
    CEP TEXT NOT NULL,
    CPF TEXT NOT NULL
);

SELECT * FROM USUARIO;
INSERT INTO USUARIO_NOVO (ID_USUARIO, NOME_USUARIO, LOGRADOURO, BAIRRO, TEL1, CEP, CPF) VALUES
	('31', 'Alfredo Tenttoni', 'Rua AmazonAS 58', 'Pirai', '6549-5421', '02170-251', '294.264.875-32'),
    ('32', 'Cindy Crall', 'Rua Ipiranga 123', 'Vila Cristal', '5846-6577', '02182-637', '122.147.655-49'),
    ('33', 'Rubens Pardo', 'Avenida dos Monges 51', 'Campo Grande', '5184-8978', '52412-365', '654.586.472-98'),
    ('34', 'Carlos Pracidelli', 'Travessa dos Irmãos 48', 'Cotia', '8945-7986', '23124-005', '341.251.651-75'),
    ('35', 'Ernesto Coimbra', 'Avenida Ampére 414', 'Jardim Elvira', '5844-2654', '05728-368', '193.107.214-35');


CREATE VIEW VIEW_NOVO_USUARIO AS (SELECT 
	ID_USUARIO,
	NOME_USUARIO,
	REPLACE(REPLACE(CPF, '.', ''), '-', '') AS CPF,
	SUBSTRING_INDEX(LOGRADOURO, (SUBSTRING_INDEX(LOGRADOURO, ' ', -1)),1) AS ENDERECO,
    SUBSTRING_INDEX(LOGRADOURO, ' ', -1) AS NUMERO,
    BAIRRO,
    REPLACE(CEP,'-','')AS CEP,
    NULL AS CIDADE,
    NULL AS ESTADO,
    NULL AS PAIS,
    REPLACE(TEL1, '-', '') AS TEL1,
    NULL AS TEL2
FROM USUARIO_NOVO);

CREATE TABLE NOVA_USUARIO_NOVO AS SELECT * FROM VIEW_NOVO_USUARIO;

ALTER TABLE NOVA_USUARIO_NOVO MODIFY ID_USUARIO INT;
ALTER TABLE NOVA_USUARIO_NOVO MODIFY NOME_USUARIO VARCHAR(40);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY CPF CHAR(14);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY ENDERECO VARCHAR(40);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY NUMERO NUMERIC(8);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY BAIRRO VARCHAR(40);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY CEP NUMERIC(8);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY CIDADE VARCHAR(25);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY ESTADO CHAR(2);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY PAIS VARCHAR(20);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY TEL1 NUMERIC(14);
ALTER TABLE NOVA_USUARIO_NOVO MODIFY TEL2 NUMERIC(14);

INSERT INTO USUARIO SELECT * FROM NOVA_USUARIO_NOVO;

SELECT * FROM USUARIO;

-- 18. Gerência solicitou uma consulta para verificar se existe duplicidade de usuários no Banco de Dados

SELECT 
	ID_USUARIO AS 'id Usuário',
    NOME_USUARIO AS 'Nome',
	COUNT(NOME_USUARIO) AS 'Duplicidade'
FROM USUARIO
GROUP BY NOME_USUARIO
HAVING COUNT(NOME_USUARIO) > 1
ORDER BY COUNT(NOME_USUARIO) DESC
;

-- 19. A Recepção recebeu a informação que existem dois usuários duplicados na bASe, será necessária a exclusão de um desses registros

DELETE U2
FROM USUARIO AS U1, USUARIO AS U2
WHERE U1.ID_USUARIO < U2.ID_USUARIO AND U1.NOME_USUARIO = U2.NOME_USUARIO;

-- 20. O Financeiro solicitou a inserção do valor individual de cada OBRA.
--  Crie um campo com o nome Valor_Livro  na tabela OBRA.
--  Defina o tipo de dados que poderá ser aceito e o valor de cada título.


ALTER TABLE OBRA ADD COLUMN VALOR_LIVRO DECIMAL(6,2);

UPDATE OBRA
SET OBRA.VALOR_LIVRO = (SELECT ESTOQUE.VALOR_UNITARIO
								FROM ESTOQUE 
                                WHERE ESTOQUE.ID_OBRA = OBRA.ID_OBRA);
                                
-- 21. A Consultoria verificou que o campo Multa_AtrASo está com o tamanho Varchar(2),
--  foi solicitada a alteração do campo para  Varchar(3).

ALTER TABLE DEVOLUCAO MODIFY COLUMN MULTA_ATRASO VARCHAR(3);

-- 22. Foi verificado que o campo Multa_AtrASo está com os registros preenchidos de forma errada,
--  foi solicitada a alteração dos registros que forem 0 para Não e 1 para SIM.

UPDATE DEVOLUCAO
SET DEVOLUCAO.MULTA_ATRASO = (CASE WHEN MULTA_ATRASO = 0 THEN 'Não'
		  WHEN MULTA_ATRASO = 1 THEN 'Sim' END);
SELECT 
	ID_DEVOLUCAO,
	MULTA_ATRASO
FROM DEVOLUCAO;

-- 23. A Diretoria solicitou a exclusão do campo Valor_Livro da tabela OBRA pois, o pedido feito pelo Financeiro estava errado.

 ALTER TABLE OBRA DROP COLUMN VALOR_LIVRO;

-- 24. A Diretoria solicitou a lista de todos os livros que já foram emprestados 
-- mAS foram entregues com atrASo e os respectivos os nomes dos funcionários que fizeram os empréstimos.

SELECT 
	DEVOLUCAO.ID_DEVOLUCAO AS 'id Devolução',
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Funcionário',
    DEVOLUCAO.DATA_DEVOLUCAO AS 'Data Devolução',
    DEVOLUCAO.MULTA_ATRASO AS 'Multa por atrASo'
FROM DEVOLUCAO
INNER JOIN FUNCIONARIO ON DEVOLUCAO.ID_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO
WHERE MULTA_ATRASO = 'Sim';

-- 25 A Gerência solicitou a lista de todos os livros, cujos AUTORes não são brASileiros, que já foram devolvidos e o valor total de cada livro.

SELECT 
	OBRA.ID_OBRA AS 'id OBRA',
    OBRA.TITULO_OBRA,
    AUTOR.NOME_ALTOR AS 'Nome AUTOR',
    AUTOR.PAIS_AUTOR AS 'País AUTOR',
	-- DATE_FORMAT(DEVOLUCAO.DATA_DEVOLUCAO, '%d/%m/%Y') AS 'DatAS de devolução',
    CONCAT('R$ ',REPLACE(SUM(ESTOQUE.VALOR_UNITARIO), '.', ',')) AS 'Valor Total'
FROM OBRA
INNER JOIN AUTOR ON OBRA.ID_AUTOR = AUTOR.ID_AUTOR
INNER JOIN DEVOLUCAO ON OBRA.ID_OBRA = DEVOLUCAO.ID_OBRA
INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_ESTOQUE
WHERE AUTOR.PAIS_AUTOR IS NULL
GROUP BY 1
ORDER BY OBRA.ID_OBRA;

-- 26. A área de RH solicitou a lista de todos usuários que fizeram empréstimo com o dia de entrega igual 21/08/2011.

SELECT 
	USUARIO.ID_USUARIO AS 'id Usuário',
	USUARIO.NOME_USUARIO AS 'Nome',
	DATE_FORMAT(DATA_ENTREGA, '%d/%m/%Y') AS 'Data de entrega'
FROM EMPRESTIMO
INNER JOIN USUARIO ON EMPRESTIMO.ID_USUARIO = USUARIO.ID_USUARIO
WHERE DATA_ENTREGA = '2011-08-21'
ORDER BY 1;

-- 27. O Financeiro solicitou a lista de todAS AS OBRAS que tiveram data de publicação menor que 04/03/2013,
--  sua respectiva  quantidade e o seu valor unitário.

SELECT 
	OBRA.ID_OBRA AS 'id OBRA',
    OBRA.TITULO_OBRA AS 'Título',
    DATE_FORMAT(OBRA.DATA_PUBLICACAO, '%d/%m/%Y') AS 'Data de publicação',
	ESTOQUE.QUANTIDADE_LIVRO,
    CONCAT('R$ ',REPLACE(ESTOQUE.VALOR_UNITARIO, '.', ',')) AS 'Valor unitário'
FROM OBRA
INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_OBRA
WHERE DATA_PUBLICACAO < '2013-03-04'
ORDER BY 1;

-- 28. A área de RH solicitou a lista de todos os funcionários separados por ativos ou não, seus respectivos cargos e salários.

SELECT 
	FUNCIONARIO.ID_FUNCIONARIO AS 'id Funcionário',
	FUNCIONARIO.NOME_FUNCIONARIO AS 'Nome',
    (CASE WHEN DATA_DEMISSAO = '9999-01-01' THEN 'Ativo'
			WHEN DATA_DEMISSAO <> '9999-01-01'THEN 'Não Ativo' END) AS 'Ativo / Não ativo',
    CARGO.NOME_CARGO AS 'Cargo',
     CONCAT('R$ ',REPLACE(CARGO.SALARIO, '.', ',')) AS 'Salário'
FROM CARGO
INNER JOIN FUNCIONARIO ON CARGO.ID_CARGO = FUNCIONARIO.ID_CARGO
ORDER BY DATA_DEMISSAO;

-- 29. A Gerência solicitou uma lista de todos os livros com os nomes dos AUTORes, nomes dAS editorAS e a quantidade de livros em estoque.

SELECT 
	OBRA.ID_OBRA AS 'id OBRA',
    OBRA.TITULO_OBRA AS 'Título',
    AUTOR.NOME_ALTOR AS 'Nome AUTOR',
    EDITORA.NOME_EDITORA AS 'Editora',
    ESTOQUE.QUANTIDADE_LIVRO AS 'Qnt. Estoque'
FROM OBRA
INNER JOIN AUTOR ON OBRA.ID_AUTOR = AUTOR. ID_AUTOR
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA
INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_OBRA
ORDER BY 1;

-- 30 A Diretoria solicitou a lista de todos os funcionários da Biblioteca com seus respectivos departamentos que tem idade entre 30 e 40 anos.

SELECT 
	FUNCIONARIO.ID_FUNCIONARIO AS 'id Funcionário',
    FUNCIONARIO.NOME_FUNCIONARIO AS 'Nome',
	TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURRENT_DATE) AS idade,
	DEPARTAMENTO.NOME_DEPARTAMENTO AS 'Departamento'
FROM FUNCIONARIO
INNER JOIN DEPARTAMENTO ON FUNCIONARIO.ID_FUNCIONARIO = DEPARTAMENTO.ID_DEPARTAMENTO
WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURRENT_DATE)  BETWEEN 30 AND 40;

-- 31 O Financeiro solicitou a criação de uma visão que retorne o nome do livro, seu AUTOR e o valor.


CREATE VIEW VISAO_LIVRO AS (
	SELECT
		OBRA.ID_OBRA AS 'id OBRA',
		OBRA.TITULO_OBRA AS 'Título',
        AUTOR.NOME_ALTOR AS 'Nome AUTOR',
        ESTOQUE.VALOR_UNITARIO AS 'Valor Unitário'
    FROM OBRA
    INNER JOIN AUTOR ON OBRA.ID_OBRA = AUTOR.ID_AUTOR
    INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_OBRA
    ORDER BY OBRA.ID_OBRA
);

SELECT * FROM VISAO_LIVRO;

-- 32. A Recepção solicitou uma lista com o código do livro, nome do livro cujo valor do livro seja maior que  R$ 90,00.

SELECT 
	OBRA.ID_OBRA AS 'Código Livro',
    OBRA.TITULO_OBRA AS 'Nome livro',
    CONCAT('R$ ',REPLACE(ESTOQUE.VALOR_UNITARIO, '.', ',')) AS 'Valor do livro'
FROM OBRA
INNER JOIN ESTOQUE ON OBRA.ID_OBRA = ESTOQUE.ID_OBRA
WHERE VALOR_UNITARIO > 90.00
ORDER BY 1;

-- 33. A área de RH solicitou a atualização do salário do Auxiliar Financeiro de 12% sobre o seu salário atual.

UPDATE
	CARGO
SET CARGO.SALARIO = CAST((SALARIO * 1.12)  AS DECIMAL(12,2))
WHERE NOME_CARGO = 'Auxiliar Financeiro';

SELECT *,
	ID_CARGO AS 'id Cargo',
	CONCAT('R$ ',REPLACE(SALARIO, '.', ',')) AS 'Novo Salário'
FROM CARGO
WHERE ID_CARGO = 9;

-- 34. O Financeiro solicitou uma atualização da data de demissão
--  da funcionária Alice Meire para o último dia do Mês que você se encontra atualmente.


UPDATE
	FUNCIONARIO
    SET FUNCIONARIO.DATA_DEMISSAO = LAST_DAY(CURRENT_DATE)
    WHERE NOME_FUNCIONARIO LIKE 'Alice Meire%';
SELECT 
	ID_FUNCIONARIO AS 'id Funcionario',
    NOME_FUNCIONARIO AS 'Nome Funcionario',
    DATE_FORMAT(DATA_DEMISSAO, '%d/%m/%Y') AS 'Data de Demissão'
FROM FUNCIONARIO
WHERE NOME_FUNCIONARIO LIKE 'Alice Meire%';

-- 35. A Gerência solicitou uma lista de todAS AS OBRAS, que contenham a letra “C ordenadAS por gênero   data de publicação entre 2011 e 2013.

SELECT 
	ID_OBRA AS 'id OBRA',
    TITULO_OBRA AS 'Titulo',
    DATA_PUBLICACAO AS 'Data Publicacao'
FROM OBRA
WHERE TITULO_OBRA LIKE 'C%' AND DATA_PUBLICACAO BETWEEN '2011-01-01' AND  '2013-01-01'
ORDER BY GENERO;

-- 36 A Recepção solicitou uma lista  como todos os funcionários da Biblioteca com 
-- código, nome, e departamento, clASsificado pelo nome do funcionário que não emprestaram nenhum livro.

SELECT 
	F.ID_FUNCIONARIO AS 'id Funcionario',
    F.NOME_FUNCIONARIO AS 'Nome Funcionario',
    D.NOME_DEPARTAMENTO AS 'Departamento',
    E.ID_EMPRESTIMO AS 'Quantidade Empréstimo'
FROM FUNCIONARIO F
INNER JOIN DEPARTAMENTO D ON F.ID_DEPARTAMENTO = D.ID_DEPARTAMENTO
LEFT OUTER JOIN EMPRESTIMO E ON F.ID_FUNCIONARIO = E.ID_FUNCIONARIO
WHERE E.ID_EMPRESTIMO IS NULL


UNION

SELECT 
	F.ID_FUNCIONARIO AS 'id Funcionario',
    F.NOME_FUNCIONARIO AS 'Nome Funcionario',
    D.NOME_DEPARTAMENTO AS 'Departamento',
    E.ID_EMPRESTIMO AS 'Quantidade Empréstimo'
FROM FUNCIONARIO F
INNER JOIN DEPARTAMENTO D ON F.ID_DEPARTAMENTO = D.ID_DEPARTAMENTO
RIGHT OUTER JOIN EMPRESTIMO E ON F.ID_FUNCIONARIO = E.ID_FUNCIONARIO
WHERE E.ID_EMPRESTIMO IS NULL
ORDER BY  'Nome Funcionario'
;

-- 37 A Biblioteca solicitou uma lista que exiba a quantidade de logradouros de usuários agrupados por número do CEP.

SELECT 
	COUNT(ENDERECO) AS 'Quantidade Logradouro',
	CONCAT(LEFT(CEP, 5),'-',RIGHT(CEP,3)) AS 'CEP'
FROM USUARIO
GROUP BY CEP;

-- 38 A Diretoria  solicitou uma lista que exiba a quantidade de endereços agrupados por usuário.

SELECT 
	COUNT(ENDERECO) AS 'Quantidade Endereço',
	NOME_USUARIO AS 'Usuario'
FROM USUARIO
GROUP BY NOME_USUARIO;

-- 39 Foi solicitado a busca de informações de todAS AS OBRAS que foram reservadAS no dia 18/08/11 AS 15:00 e o nome do responsável pela reserva.


SELECT 
	R.ID_RESERVA AS 'id Reserva',
    F.NOME_FUNCIONARIO AS 'Funcionário',
    O.TITULO_OBRA AS 'Título',
    U.NOME_USUARIO AS 'Usuário',
    DATE_FORMAT(R.DATA_RESERVA, '%d/%m/%Y') AS 'Data Reserva',
    DATE_FORMAT(R.HORA_RESERVA, '%H:%m') AS 'Hora reserva'
FROM RESERVA R
INNER JOIN FUNCIONARIO F ON R.ID_FUNCIONARIO = F.ID_FUNCIONARIO
INNER JOIN OBRA O ON O.ID_OBRA = R.ID_OBRA
INNER JOIN USUARIO U ON R.ID_USUARIO = U.ID_USUARIO
WHERE DATA_RESERVA  = '2011-08-18' AND HORA_RESERVA = '15:00'
;

-- 40. O financeiro solicitou o levantamento da informação de quando AS usuáriAS Emily Mall e Whitney Cinse pegaram livros emprestados,
--  quais foram os  livros e seus respectivos valores unitários.


SELECT 
	U.ID_USUARIO AS 'id Usuário',
	U.NOME_USUARIO AS 'Nome Usuário',
    O.TITULO_OBRA AS 'Título ',
    ES.VALOR_UNITARIO AS 'Valor unitário',
    DATE_FORMAT(E.DATA_EMPRESTIMO, '%d/%m/%Y') AS 'Data Empréstimo',
    DATE_FORMAT(E.HORA_EMPRESTIMO, '%H:%m') AS 'HorAS empréstimo'
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.ID_USUARIO = U.ID_USUARIO
INNER JOIN OBRA O ON O.ID_OBRA = E.ID_OBRA
INNER JOIN ESTOQUE ES ON ES.ID_OBRA = O.ID_OBRA
WHERE U.NOME_USUARIO LIKE 'Emily Mall%' 
OR U.NOME_USUARIO LIKE 'Whitney Cinse%'
;

-- 41. Hoje é aniversario da biblioteca e para comemorar foram comprados presentes a todos os usuários
-- que foram os primeiros a utilizar a biblioteca, o gerente Carlos Mendes pediu a relação da primeira pessoa
--   a reservar,  pegar emprestado e devolver um livro e suAS respectivAS informações para que possa ser entrado em contato com ele.

SELECT 
	T1.ID_USUARIO AS'id Usuario',
    T2.NOME_USUARIO AS 'Nome',
    T2.ENDERECO AS 'Endereço',
    T2.NUMERO AS 'Número',
    T2.BAIRRO AS 'Bairro',
    T2.TEL1 AS 'Telefone 1',
DATE_FORMAT(T1.DATA_EMPRESTIMO, '%d/%m/%Y') AS 'Data Empréstimo',
DATE_FORMAT(T1.DATA_ENTREGA, '%d/%m/%Y') AS 'Data Entrega'
FROM EMPRESTIMO T1
INNER JOIN USUARIO T2 ON T1.ID_USUARIO = T2.ID_USUARIO
ORDER BY DATA_EMPRESTIMO 
LIMIT 1
;

-- 42. Foi solicitado pela diretoria saber quantAS OBRAS cada editora tem na biblioteca.

SELECT 
	EDITORA.ID_EDITORA AS 'id Editora',
    EDITORA.NOME_EDITORA AS 'Editora',
	COUNT(OBRA.ID_EDITORA) AS 'Qtd. OBRA'
FROM OBRA
INNER JOIN EDITORA ON OBRA.ID_EDITORA = EDITORA.ID_EDITORA
GROUP BY OBRA.ID_EDITORA
ORDER BY EDITORA.ID_EDITORA
;

-- 43. É fechamento referente ao mês de janeiro (hoje dia 03/02/2013) e a biblioteca está no vermelho
-- , foi solicitado pelo financeiro que fosse feito um levantamento de todos os livros que não foram devolvidos
-- , mostrando quantos diAS de atrASo e para cada dia foi dado uma multa de 5 reais, e mostrar o nome do usuário 
-- , livro emprestado e o total a receber pela biblioteca. 

SELECT
	T1.ID_EMPRESTIMO AS 'id EMPRESTIMO,',
    T4.NOME_USUARIO AS 'Usuário',
    T3.TITULO_OBRA AS 'Livro',
	DATE_FORMAT(T1.DATA_ENTREGA, '%d/%m/%Y') AS 'Data Prevista Entrega',
    DATE_FORMAT(T2.DATA_DEVOLUCAO, '%d/%m/%Y') AS 'Data Real Entrega',
    DATEDIFF(T2.DATA_DEVOLUCAO, T1.DATA_ENTREGA) AS 'DiAS de atrASo',
    CONCAT('R$ ',REPLACE(CAST((DATEDIFF(T2.DATA_DEVOLUCAO, T1.DATA_ENTREGA)*5) AS DECIMAL(5,2)), '.', ','))  AS 'Valor da Multa'
FROM EMPRESTIMO T1
INNER JOIN DEVOLUCAO T2 ON T1.ID_EMPRESTIMO = T2.ID_EMPRESTIMO
INNER JOIN OBRA T3 ON T1.ID_OBRA = T3.ID_OBRA
INNER JOIN USUARIO T4 ON T1.ID_USUARIO = T4.ID_USUARIO
WHERE T1.DATA_ENTREGA < T2.DATA_DEVOLUCAO
;

-- 44. Foi solicitado a informação de todos os usuários que morem em uma avenida, e ainda,
--  que seja mostrado o nome do usuário, CPF e logradouro em ordem de CPF do maior para o menor.

SELECT
	CONCAT(LEFT(CPF,3),'.', SUBSTRING(CPF,4,3), '.',SUBSTRING(CPF,7,3), '-', RIGHT(CPF,2)) AS 'CPF',
    NOME_USUARIO AS 'Nome Usuário',
    ENDERECO AS 'Endereço'
FROM USUARIO
WHERE ENDERECO LIKE 'Avenida%'
ORDER BY CPF DESC
;

-- 45. Chegou na biblioteca uma mensagem urgente da Camila pedindo um relatório contendo a informação
--  de todos os livros que foram emprestados mais de uma vez nos anos de 2011 a 2013 agrupados pelo nome do livro.
SELECT
	T1.ID_EMPRESTIMO AS 'id EMPRESTIMO',
    T2.TITULO_OBRA AS 'Título',
	COUNT(T1.DATA_EMPRESTIMO) AS 'Qtd. de EMPRESTIMO',
    DATE_FORMAT(T1.DATA_EMPRESTIMO, '%d/%m/%Y') AS 'Data EMPRESTIMO'
FROM EMPRESTIMO T1
INNER JOIN OBRA T2 ON T1.ID_OBRA = T2.ID_OBRA
WHERE DATA_EMPRESTIMO BETWEEN '2011-01-01' AND '2013-01-01'
GROUP BY T1.ID_OBRA
ORDER BY 2
;

-- 46. O Financeiro pediu para apresentar o valor médio dos livros e informar quais são os que estão abaixo dessa media,
--  referente a devolução e empréstimo.


SELECT
	T1.ID_EMPRESTIMO AS 'Id EMPRESTIMO',
	T2.ID_DEVOLUCAO AS 'Id Devolução',
	T1.ID_OBRA AS 'id OBRA',
    T4.TITULO_OBRA AS 'Título',
    T3.VALOR_UNITARIO AS 'Valor Unitário',
    (SELECT CAST(AVG(VALOR_UNITARIO) AS DECIMAL(5,2)) FROM ESTOQUE)  AS 'Média'
FROM EMPRESTIMO T1
-- CROSS JOIN( SELECT CAST(AVG(VALOR_UNITARIO) AS DECIMAL(5,2)) FROM ESTOQUE) AS MEDIA 
INNER JOIN DEVOLUCAO T2 ON T1.ID_OBRA = T2.ID_OBRA
INNER JOIN ESTOQUE T3 ON T2.ID_OBRA = T3.ID_OBRA
INNER JOIN OBRA T4 ON T3.ID_OBRA = T4.ID_OBRA
WHERE  (T3.VALOR_UNITARIO) < (SELECT CAST(AVG(VALOR_UNITARIO) AS DECIMAL(5,2)) FROM ESTOQUE)
;

-- 47 Barbara do financeiro pediu para verificar qual a media do salario dos funcionários e 
-- quem são os que ganham mais do que a media em cada departamento.

SELECT
	T1.ID_FUNCIONARIO AS 'id Funcionáro',
    T1.NOME_FUNCIONARIO AS 'Nome',
    T2.NOME_CARGO AS 'Cargo',
    CONCAT('R$ ',REPLACE(T2.SALARIO, '.', ',')) AS 'Salario',
    T3.NOME_DEPARTAMENTO AS 'Departamento',
	(SELECT CONCAT('R$ ',REPLACE(CAST(AVG(SALARIO) AS DECIMAL(7,2)), '.', ',')) FROM CARGO)  AS 'Média'
    -- REPLACE(REPLACE(REPLACE(AVG(SALARIO) AS DECIMAL(7,2), '.', ''), ',', '.'), 'R$ ', '')
FROM
FUNCIONARIO T1
INNER JOIN CARGO T2 ON T1.ID_CARGO = T2.ID_CARGO
INNER JOIN DEPARTAMENTO T3 ON T2.ID_CARGO = T3.ID_CARGO
WHERE T2.SALARIO > 'Média'
ORDER BY T3.NOME_DEPARTAMENTO, T2.SALARIO DESC
;

-- 48. Carlos pediu que seja feita uma pesquisa informando  de todos os usuários que tem cadAStro na biblioteca
--  e que nunca levaram livros mostrar o nome de todos em MaiúsculAS.
SELECT
	T2.ID_USUARIO AS 'id Usuário',
	UPPER(T2.NOME_USUARIO) AS 'Usuário em Caixa alta'
FROM
	EMPRESTIMO T1
LEFT OUTER JOIN USUARIO T2 ON T1.ID_USUARIO = T2.ID_USUARIO
WHERE T1.ID_EMPRESTIMO IS NULL
UNION
SELECT
	T2.ID_USUARIO AS 'id Usuário',
	UPPER(T2.NOME_USUARIO) AS 'Usuário em Caixa alta'
FROM
	EMPRESTIMO T1
RIGHT OUTER JOIN USUARIO T2 ON T1.ID_USUARIO = T2.ID_USUARIO
WHERE T1.ID_EMPRESTIMO IS NULL
ORDER BY 'Nome Usuario'
;

-- 49. A recepção pediu para verificar quais os usuários que já pegaram mais de 3 livros,
--  e em cASo positivo, mostrar nomes e quais livros, ordenando pelo CEP (crescente).


SELECT
	t2.cep AS 'cep',
	T1.ID_USUARIO AS 'id Usuario',
    T2.NOME_USUARIO AS 'Nome',
    T3.TITULO_OBRA AS 'Título',
	COUNT(T1.ID_USUARIO) AS 'Qtd EMPRESTIMO'
FROM EMPRESTIMO T1
INNER JOIN USUARIO T2 ON T1.ID_USUARIO = T2.ID_USUARIO
INNER JOIN OBRA T3 ON T1.ID_OBRA = T3.ID_OBRA
GROUP BY (T1.ID_USUARIO)
HAVING COUNT(T1.DATA_EMPRESTIMO) > 3
ORDER BY T2.CEP 
;

-- 50. A diretoria pediu que fosse feito uma analise do estoque,
--  apresentando uma lista com todos os livros que já foram reservados e emprestados e,
--  mostrar quantos estão disponíveis clASsificados por Gênero.


SELECT
	T1.ID_OBRA AS 'id OBRA' ,
	T3.TITULO_OBRA AS 'Título',
    T3.GENERO AS 'Gênero',
    COUNT(T1.ID_OBRA) AS 'Qtd EMPRESTIMO / Devolução',
    T4.QUANTIDADE_LIVRO AS 'Qtd em Estoque'
    
FROM EMPRESTIMO T1
LEFT JOIN DEVOLUCAO T2 ON T1.ID_OBRA = T2.ID_OBRA
INNER JOIN OBRA T3 ON T1.ID_OBRA = T3.ID_OBRA
INNER JOIN ESTOQUE T4 ON T1.ID_OBRA = T4.ID_OBRA
GROUP BY T1.ID_OBRA
UNION 
SELECT
	T1.ID_OBRA AS 'id OBRA' ,
	T3.TITULO_OBRA AS 'Título',
    T3.GENERO AS 'Gênero',
    COUNT(T1.ID_OBRA) AS 'Qtd EMPRESTIMO / Devolução',
    T4.QUANTIDADE_LIVRO AS 'Qtd em Estoque'
    
FROM EMPRESTIMO T1
RIGHT JOIN DEVOLUCAO T2 ON T1.ID_OBRA = T2.ID_OBRA
INNER JOIN OBRA T3 ON T1.ID_OBRA = T3.ID_OBRA
INNER JOIN ESTOQUE T4 ON T1.ID_OBRA = T4.ID_OBRA
GROUP BY T1.ID_OBRA
ORDER BY 'Gênero'
;

-- 51. Foi solicitada a pesquisa de qual a hora que a biblioteca tem mais movimento e,
-- também, qual o horário de menor movimentação,  faça a avaliação de todAS AS horAS de devolução, empréstimo e reserva.

WITH QUANT AS
(SELECT HORA_RESERVA AS HORA FROM RESERVA
UNION ALL 
SELECT HORA_EMPRESTIMO AS HORA FROM EMPRESTIMO
UNION ALL
SELECT HORA_DEVOLUCAO AS HORA FROM DEVOLUCAO
)
SELECT
CASE
    WHEN HORA BETWEEN TIME('06:00:00') AND TIME('11:59:59') THEN 'Manhã - 06:00 às 11:59'
    WHEN HORA BETWEEN TIME('12:00:00') AND TIME('17:59:59') THEN 'Tarde - 12:00 às 17:59'
    WHEN HORA BETWEEN TIME('18:00:00') AND TIME('23:59:59') THEN 'Noite - 18:00 às 23:59'
    ELSE 'Madrugada 00:00 às 05:59'
  END AS PERIODO, COUNT(HORA) AS CONTAGEM
 FROM QUANT
 GROUP BY PERIODO
;
 
-- 52. A sociedade brASileira de editorAS solicitou o levantamento para a biblioteca de qual são os 3 AUTORes que tem
--  mais livros lidos no ano de 2012 e 2013 e os 2 que tem menos OBRAS lidAS.

(select 
	T3.Nome_Autor,
    count(*) as 'Total Livros',
    'Mais Lido' as STATUS 
from EMPRESTIMO T1
join OBRA T2 ON T1.ID_Obra= T2.ID_Obra
join AUTOR T3 ON T2.ID_Autor = T3.ID_Autor
WHERE YEAR(DATA_EMPRESTIMO) = 2013 OR YEAR(DATA_EMPRESTIMO) = 2012
GROUP BY T3.NOME_AUTOR
ORDER BY 'Total Livros' DESC LIMIT 3)
UNION
(select 
	T3.Nome_Autor,
    count(*) as 'Total Livros',
    'Mais Lido' as STATUS 
from EMPRESTIMO T1
join OBRA T2 ON T1.ID_Obra= T2.ID_Obra
join AUTOR T3 ON T2.ID_Autor = T3.ID_Autor
WHERE YEAR(DATA_EMPRESTIMO) = 2013 OR YEAR(DATA_EMPRESTIMO) = 2012
GROUP BY T3.NOME_AUTOR
ORDER BY 'Total Livros'  LIMIT 2);


-- 53. Crie uma tabela que exiba uma lista de todos livros por funcionario, o total de empréstimos e devoluções que cada um atendeu

SELECT 
	NOME_FUNCIONARIO,
	COUNT(DISTINCT T1.ID_EMPRESTIMO) AS 'Quantidade empréstimo',
	COUNT(DISTINCT T3.ID_DEVOLUCAO) AS 'Quantidade devolução'
FROM  EMPRESTIMO T1
JOIN  FUNCIONARIO T2 on T1.ID_FUNCIONARIO = T2.ID_FUNCIONARIO
LEFT JOIN  DEVOLUCAO T3 ON T1.ID_FUNCIONARIO = T3.ID_FUNCIONARIO
GROUP BY NOME_FUNCIONARIO;

-- 54 - A biblioteca quer fechar parceria com AS editorAS, e existem usuários que
-- trabalham nAS editorAS facilitando esse contato, para tanto, verificar quais usuários
-- possuem o mesmo endereço dAS editorAS, informe seu nome, telefone e o nome da
-- editora que trabalha.

SELECT 
	T1.NOME_USUARIO AS 'Usuários',
	T1.Tel1 AS 'Telefone',
	T2.NOME_EDITORA AS 'Nome Editora'
FROM  USUARIO T1
INNER JOIN  EDITORA T2 ON T1.ENDERECO = T2.ENDERECO;

-- 55- Foi solicitado a criação de uma visão que traga todos os livros e o preço da
-- editora Leya.
SELECT 
	T1.TITULO_OBRA AS 'Titulo da OBRA',
	T1.NUMERO_PUBLICACAO AS 'Numero de Publicação',
	T1.GENERO,
    T1.DATA_PUBLICACAO AS 'Data de Publicação',
	T2.NOME_EDITORA AS 'Nome da Editora',
	T3.VALOR_UNITARIO AS 'Valor Unitário'
FROM  OBRA T1 
inner JOIN  EDITORA T2 ON T1.ID_EDITORA = T2.ID_EDITORA
inner JOIN  ESTOQUE T3 ON T1.ID_OBRA = T3.ID_OBRA
WHERE NOME_EDITORA = 'Leya'
;

-- 56 - A biblioteca foi comprar mais livros para aumentar seu acervo, mAS a editora
-- Saraiva aumentou em 16% o valor de seus livros, atualize os preços dos livros da
-- editora na porcentagem designada.
UPDATE  ESTOQUE T1
INNER JOIN (
SELECT T2.ID_OBRA
FROM  OBRA T2
INNER JOIN  EDITORA T3 ON T2.ID_Editora = T3.ID_Editora
WHERE T3.NOME_EDITORA = 'Saraiva'
) AS SUBQUERY ON T1.ID_OBRA = SUBQUERY.ID_OBRA
SET T1.VALOR_UNITARIO = T1.VALOR_UNITARIO * 1.16
;
-- 57 - Foi solicitado apresentarmos quais AS 5 OBRAS que tiveram menos publicações
-- e AS 5 de maior, ainda, mostrar qual o AUTOR, editora, nome do livro e quantidade de
-- publicações em ordem descrescente.
(SELECT 
	T1.TITULO_OBRA,
	T1.NUMERO_PUBLICACAO,
	T2.NOME_AUTOR,
	T3.NOME_EDITORA
FROM  OBRA T1
INNER JOIN  AUTOR T2 ON T1.ID_AUTOR = T2.ID_AUTOR
INNER JOIN  EDITORA T3 ON T1.ID_EDITORA = T3.ID_EDITORA
ORDER BY T1.NUMERO_PUBLICACAO DESC
LIMIT 5)
UNION
(SELECT 
	T1.TITULO_OBRA,
	T1.NUMERO_PUBLICACAO,
	T2.NOME_AUTOR,
	T3.NOME_EDITORA
FROM  OBRA T1
INNER JOIN  AUTOR T2 ON T1.ID_AUTOR = T2.ID_AUTOR
INNER JOIN  EDITORA T3 ON T1.ID_EDITORA = T3.ID_Editora
ORDER BY T1.NUMERO_PUBLICACAO LIMIT 5)
;

-- 58 - Fazem cento e noventa e três meses que o instituto bibliográfico brASileiro
-- surgiu. Para comemorar a diretoria pediu a relação de todos os usuários que tem o
-- cpf com o começo 193 que receberão um presente de comemoração. Para isto, foi
-- Atividade Biblioteca - Vinicius Perdigão 25
-- solicitado informar o nome e o cpf de todos os usuários que estejam nesse padrão
-- mAS mostrar cpf os 3 primeiros dígitos e os dois últimos os do meio apresentar um ""
-- como no exemplo: 193..-35, lembrando que devemos apresentar dessa maneira,
-- pois a diretoria quer preservar essAS informações que são sigilosAS.

SELECT 
NOME_USUARIO AS 'Nome do Usuário',
ENDERECO,
NUMERO,
CEP,
BAIRRO,
TEL1 AS 'Telefone 1',
CONCAT(SUBSTRING(CPF, 1, 3), '.', '***', '.', '***', '-', SUBSTRING(CPF, 10,
2)) AS CPF
FROM  USUARIO
WHERE CPF LIKE '193.%'