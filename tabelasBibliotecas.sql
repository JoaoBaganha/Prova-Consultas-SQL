	CREATE TABLE Departamentos (
    departamento_id SERIAL PRIMARY KEY,
    nome_departamento VARCHAR(50) NOT NULL
);

INSERT INTO Departamentos (nome_departamento) VALUES
('Administração'),
('TI'),
('Biblioteca'),
('Financeiro');

CREATE TABLE Funcionarios (
    funcionario_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_contratacao TIMESTAMP NOT NULL,
    departamento_id INT REFERENCES Departamentos(departamento_id)
);

INSERT INTO Funcionarios (nome, cargo, salario, data_contratacao, departamento_id) VALUES
('João Pereira', 'Bibliotecário', 3500.00, '2020-01-15', 3),
('Ana Paula', 'Técnico em TI', 4000.00, '2021-06-23', 2),
('Carlos Souza', 'Auxiliar de Biblioteca', 2500.00, '2019-03-01', 3),
('Maria Lima', 'Gerente Administrativo', 6000.00, '2020-12-01', 1),
('Rafael Dias', 'Assistente Administrativo', 3000.00, '2021-09-12', 1),
('Fernanda Santos', 'Técnico em TI', 4200.00, '2022-02-21', 2),
('Joana Moura', 'Bibliotecária', 3700.00, '2018-05-10', 3),
('Felipe Gomes', 'Auxiliar de TI', 2800.00, '2022-07-20', 2),
('Beatriz Silva', 'Contadora', 5300.00, '2019-10-30', 4),
('Roberto Lima', 'Assistente de Finanças', 3200.00, '2020-04-12', 4);

CREATE TABLE Autores (
    autor_id SERIAL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL
);

INSERT INTO Autores (nome_autor) VALUES
('Paulo Coelho'),
('Machado de Assis'),
('George Orwell'),
('J.R.R. Tolkien'),
('Jane Austen'),
('J.K. Rowling'),
('Gabriel García Márquez'),
('Victor Hugo'),
('Franz Kafka'),
('Ernest Hemingway');

CREATE TABLE Livros (
    livro_id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_publicacao INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    autor_id INT REFERENCES Autores(autor_id)
);

INSERT INTO Livros (titulo, ano_publicacao, preco, autor_id) VALUES
('O Alquimista', 1988, 39.90, 1),
('Dom Casmurro', 1899, 29.90, 2),
('1984', 1949, 45.00, 3),
('O Senhor dos Anéis', 1954, 99.90, 4),
('Orgulho e Preconceito', 1813, 49.90, 5),
('Harry Potter e a Pedra Filosofal', 1997, 59.90, 6),
('Cem Anos de Solidão', 1967, 42.90, 7),
('Os Miseráveis', 1862, 79.90, 8),
('O Processo', 1925, 39.50, 9),
('O Velho e o Mar', 1952, 29.50, 10);

CREATE TABLE Fornecedores (
    fornecedor_id SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(100)
);

INSERT INTO Fornecedores (nome_fornecedor, cnpj, telefone, endereco) VALUES
('Editora Brasil', '12.345.678/0001-99', '11-99999-9999', 'Rua das Letras, 100'),
('Distribuidora Alpha', '98.765.432/0001-88', '21-98765-5555', 'Av. Livros, 500'),
('Editora Global', '34.567.890/0001-77', '31-99999-9999', 'Rua Machado, 200'),
('Editora Cultura', '45.678.901/0001-66', '11-99988-7777', 'Av. Livraria, 800'),
('Editora TecBooks', '56.789.012/0001-55', '41-98877-4444', 'Rua Tecnologia, 900');

CREATE TABLE LivrosFornecedores (
    livro_id INT REFERENCES Livros(livro_id),
    fornecedor_id INT REFERENCES Fornecedores(fornecedor_id),
    PRIMARY KEY (livro_id, fornecedor_id)
);

INSERT INTO LivrosFornecedores (livro_id, fornecedor_id) VALUES
(1, 1), (1, 2), (2, 1), (2, 3), (3, 2), (3, 4),
(4, 3), (4, 5), (5, 1), (5, 4), (6, 2), (6, 5),
(7, 1), (7, 3), (8, 2), (8, 4), (9, 3), (9, 5),
(10, 2), (10, 1);

CREATE TABLE Emprestimos (
    emprestimo_id SERIAL PRIMARY KEY,
    livro_id INT REFERENCES Livros(livro_id),
    funcionario_id INT REFERENCES Funcionarios(funcionario_id),
    data_emprestimo TIMESTAMP NOT NULL,
    data_devolucao TIMESTAMP
);

INSERT INTO Emprestimos (livro_id, funcionario_id, data_emprestimo, data_devolucao) VALUES
(1, 1, '2023-02-10', '2023-02-20'),
(2, 2, '2023-03-05', '2023-03-15'),
(3, 3, '2023-04-12', '2023-04-22'),
(4, 4, '2023-05-17', '2023-05-27'),
(5, 5, '2023-06-10', '2023-06-20'),
(6, 6, '2023-07-01', '2023-07-11'),
(7, 7, '2023-08-05', '2023-08-15'),
(8, 8, '2023-09-01', '2023-09-10'),
(9, 9, '2023-09-15', '2023-09-25'),
(10, 10, '2023-10-01', '2023-10-11');

CREATE TABLE Compras (
    compra_id SERIAL PRIMARY KEY,
    fornecedor_id INT REFERENCES Fornecedores(fornecedor_id),
    funcionario_id INT REFERENCES Funcionarios(funcionario_id),
    data_compra TIMESTAMP NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL
);

INSERT INTO Compras (fornecedor_id, funcionario_id, data_compra, valor_total) VALUES
(1, 1, '2023-02-10', 5200.50),
(3, 1, '2023-02-18', 2500.00),
(2, 2, '2023-03-05', 7000.00),
(4, 2, '2023-04-01', 5600.90),
(3, 3, '2023-04-12', 3300.75),
(5, 3, '2023-05-20', 4700.50),
(4, 4, '2023-05-17', 5800.90),
(1, 4, '2023-06-01', 4900.30),
(5, 5, '2023-06-25', 6200.60),
(1, 6, '2023-07-14', 4200.40),
(3, 7, '2023-08-22', 5500.20),
(4, 8, '2023-09-30', 4950.85),
(5, 9, '2023-10-04', 5200.10),
(2, 10, '2023-11-15', 4800.75);

CREATE TABLE Vendas (
    venda_id SERIAL PRIMARY KEY,
    funcionario_id INT REFERENCES Funcionarios(funcionario_id),
    data_venda TIMESTAMP NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL
);

INSERT INTO Vendas (funcionario_id, data_venda, valor_total) VALUES
(1, '2023-02-11', 12000.50),
(1, '2023-02-25', 8500.75),
(1, '2023-03-15', 10500.00),
(2, '2023-03-06', 14500.00),
(2, '2023-04-10', 7800.90),
(2, '2023-05-22', 9900.40),
(3, '2023-04-13', 7500.75),
(3, '2023-05-18', 12000.90),
(3, '2023-07-20', 11200.25),
(4, '2023-05-18', 12500.90),
(4, '2023-06-05', 13000.60),
(4, '2023-06-15', 7500.50),
(4, '2023-07-01', 9400.00),
(5, '2023-06-26', 8600.60),
(5, '2023-07-10', 5400.00),
(5, '2023-08-03', 6200.85),
(6, '2023-07-15', 9300.40),
(6, '2023-09-20', 10200.15),
(7, '2023-08-23', 11000.20),
(7, '2023-10-05', 8500.30),
(8, '2023-09-01', 11500.85),
(8, '2023-11-15', 9800.40),
(9, '2023-10-05', 9000.10),
(9, '2023-10-28', 10800.75),
(10, '2023-11-16', 9300.75),
(10, '2023-12-01', 7000.25);