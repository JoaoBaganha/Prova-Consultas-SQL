-- 1. Calcular o total de compras realizadas por cada ano.
SELECT EXTRACT(YEAR FROM data_compra) AS ano_compra,
COUNT(compra_id) AS "total_compras"
FROM compras
GROUP BY ano_compra;

-- 2. Listar todos os funcionários contratados no ano de 2022.
SELECT * FROM funcionarios
WHERE EXTRACT(YEAR FROM data_contratacao) = 2022;

-- 3. Exibir o nome dos autores, o número de livros que eles publicaram, e o preço médio de seus livros.
SELECT autores.nome_autor,
COUNT(livros.livro_id) AS "livros_qtd",
AVG(livros.preco) AS "media_preco"
FROM livros
JOIN autores
ON autores.autor_id = livros.autor_id
GROUP BY autores.nome_autor;


-- 4. Listar as compras realizadas em setembro de 2023, nas quais a compradora ou foi Maria Lima ou Ana Paula ou Beatriz Silva.
SELECT * FROM compras 
WHERE EXTRACT(YEAR FROM data_compra) = 2023 
AND EXTRACT(MONTH FROM data_compra) = 09 
AND (funcionario_id = 2 OR funcionario_id = 4 OR funcionario_id = 9); 
--ANA PAULA = 2  MARIA LIMA = 4  BEATRIZ SILVA = 9

-- 5. Mostrar o funcionário responsável pela venda mais antiga, que o nome começa com A ou J
SELECT funcionarios.nome,
MIN(vendas.data_venda)
FROM vendas
JOIN funcionarios
ON vendas.funcionario_id = funcionarios.funcionario_id
WHERE funcionarios.nome LIKE'J%' OR funcionarios.nome LIKE'A%'
GROUP BY funcionarios.nome;

-- 6. Contar quantos livros estão associados a cada fornecedor, cuja a chave primária (DO LIVRO) é um número par.
SELECT * FROM livrosfornecedores
WHERE livro_id % 2 = 0;

-- 7. Mostrar o livro mais vendidos cujo título comece com a letra "C", ordenando pelo valor total das vendas e com os títulos em ordem alfabética.
SELECT livros.titulo, 
COUNT (livrosfornecedores.livro_id) AS livros_vendidos
FROM livros
JOIN livrosfornecedores ON livros.livro_id = livrosfornecedores.livro_id
WHERE livros.titulo LIKE 'C%'
GROUP BY livros.titulo
ORDER BY livros.titulo ASC; 


--8. Exibir o total de livros comprados por cada fornecedor, o nome do fornecedor e o valor total gasto por cada fornecedor.
SELECT fornecedores.nome_fornecedor,
COUNT(livrosfornecedores.livro_id) AS "total_livros_comprados",
SUM(compras.valor_total) AS "total_gasto"
FROM fornecedores
JOIN livrosfornecedores ON fornecedores.fornecedor_id = livrosfornecedores.fornecedor_id
JOIN compras ON fornecedores.fornecedor_id = compras.fornecedor_id
GROUP BY fornecedores.nome_fornecedor;


--9.  Liste a quantidade de vendas por departamento, que a terceira letra não é uma vogal.
SELECT departamentos.nome_departamento,
COUNT (vendas.venda_id) AS total_vendas
FROM departamentos
JOIN funcionarios ON departamentos.departamento_id = funcionarios.departamento_id 
JOIN vendas ON funcionarios.funcionario_id = vendas.funcionario_id
WHERE departamentos.nome_departamento NOT LIKE '__A%' 
OR departamentos.nome_departamento NOT LIKE '__E%'
OR departamentos.nome_departamento NOT LIKE '__I%'
OR departamentos.nome_departamento NOT LIKE '__O%'
OR departamentos.nome_departamento NOT LIKE '__U%'
GROUP BY departamentos.nome_departamento;