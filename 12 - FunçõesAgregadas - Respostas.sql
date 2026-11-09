
CREATE DATABASE IF NOT EXISTS materia12_db;
USE materia12_db;

-- =====================================================
-- 1. EMPRESA
-- =====================================================

DROP TABLE IF EXISTS Estoque, Produto, Filial, Fornecedor;

CREATE TABLE Fornecedor (
    cnpj_fornecedor VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Filial (
    cnpj_filial VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cnpj_fornecedor VARCHAR(20)
);

CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    cnpj_filial VARCHAR(20),
    id_produto INT,
    quantidade INT,
    preco DECIMAL(10,2)
);

INSERT INTO Fornecedor VALUES
('11.111.111/0001-11', 'Ambev');

INSERT INTO Filial VALUES
('99.111.111/0001-01', 'Filial Centro'),
('99.222.222/0001-02', 'Filial Shopping'),
('99.333.333/0001-03', 'Filial Bairro');

INSERT INTO Produto VALUES
(1, 'Refrigerante 2L', '11.111.111/0001-11'),
(2, 'Água 500ml', '11.111.111/0001-11');

INSERT INTO Estoque VALUES
(1, '99.111.111/0001-01', 1, 600, 8.00),
(2, '99.222.222/0001-02', 1, 20, 35.00),
(3, '99.333.333/0001-03', 1, 10, 10.00),
(4, '99.111.111/0001-01', 2, 15, 2.50);

-- Consultas Empresa

SELECT p.nome AS produto, COUNT(DISTINCT e.cnpj_filial) AS qtd_filiais
FROM Produto p
INNER JOIN Estoque e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT e.cnpj_filial) >= 1;

SELECT p.nome AS produto, SUM(e.quantidade) AS total_estoque
FROM Produto p
INNER JOIN Estoque e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING SUM(e.quantidade) > 100;

SELECT p.nome AS produto, AVG(e.preco) AS preco_medio
FROM Produto p
INNER JOIN Estoque e ON p.id = e.id_produto
GROUP BY p.id, p.nome
ORDER BY preco_medio DESC;

SELECT p.nome AS produto, MAX(e.preco) AS maior_preco, MIN(e.preco) AS menor_preco
FROM Produto p
INNER JOIN Estoque e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING (MAX(e.preco) - MIN(e.preco)) > 20.00;

SELECT f.nome AS filial, SUM(e.quantidade) AS total_unidades
FROM Filial f
INNER JOIN Estoque e ON f.cnpj_filial = e.cnpj_filial
GROUP BY f.cnpj_filial, f.nome
HAVING SUM(e.quantidade) > 500;

SELECT p.nome AS produto, COUNT(DISTINCT e.cnpj_filial) AS qtd_filiais
FROM Produto p
INNER JOIN Estoque e ON p.id = e.id_produto
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT e.cnpj_filial) >= 3;


-- =====================================================
-- 2. PADARIA
-- =====================================================

DROP TABLE IF EXISTS ItemPedido, Pedido, Produto, Cliente;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    data_pedido DATE,
    total DECIMAL(10,2)
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE ItemPedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT
);

INSERT INTO Cliente VALUES
(1, 'João Silva'),
(2, 'Maria Souza');

INSERT INTO Produto VALUES
(1, 'Pão de Queijo', 5.00);

INSERT INTO Pedido VALUES
(1, 1, '2026-02-01', 300.00),
(2, 1, '2026-02-01', 300.00),
(3, 1, '2026-02-01', 50.00),
(4, 1, '2026-02-01', 50.00),
(5, 1, '2026-02-01', 50.00),
(6, 1, '2026-02-01', 50.00),
(7, 1, '2026-02-01', 50.00),
(8, 1, '2026-02-01', 50.00),
(9, 1, '2026-02-01', 50.00),
(10, 1, '2026-02-01', 50.00),
(11, 1, '2026-02-01', 50.00);

INSERT INTO ItemPedido VALUES
(1, 1, 20),
(2, 1, 20);

-- Consultas Padaria

SELECT c.nome AS cliente, COUNT(p.id_pedido) AS qtd_pedidos
FROM Cliente c
INNER JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(p.id_pedido) >= 1;

SELECT c.nome AS cliente, SUM(p.total) AS total_gasto
FROM Cliente c
INNER JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(p.total) > 500.00;

SELECT pr.nome AS produto, SUM(ip.quantidade) AS total_vendido
FROM Produto pr
INNER JOIN ItemPedido ip ON pr.id_produto = ip.id_produto
GROUP BY pr.id_produto, pr.nome
HAVING SUM(ip.quantidade) > 30;

SELECT c.nome AS cliente, AVG(p.total) AS media_pedidos
FROM Cliente c
INNER JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING AVG(p.total) > 80.00;

SELECT data_pedido, COUNT(id_pedido) AS qtd_pedidos
FROM Pedido
GROUP BY data_pedido
HAVING COUNT(id_pedido) > 10;


-- =====================================================
-- 3. AGÊNCIA DE VIAGENS
-- =====================================================

DROP TABLE IF EXISTS Reserva, Destino, Cliente;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE Destino (
    id_destino INT PRIMARY KEY AUTO_INCREMENT,
    nome_destino VARCHAR(100),
    pais VARCHAR(50)
);

CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_destino INT,
    data_viagem DATE,
    valor DECIMAL(10,2)
);

INSERT INTO Cliente VALUES
(1, 'Ana Costa');

INSERT INTO Destino VALUES
(1, 'Paris', 'França');

INSERT INTO Reserva VALUES
(1, 1, 1, '2026-06-10', 2500.00),
(2, 1, 1, '2026-07-10', 1500.00),
(3, 1, 1, '2026-08-10', 1200.00),
(4, 1, 1, '2026-09-10', 1000.00),
(5, 1, 1, '2026-10-10', 1000.00);

-- Consultas Agência de Viagens

SELECT d.nome_destino, COUNT(r.id_reserva) AS qtd_reservas
FROM Destino d
INNER JOIN Reserva r ON d.id_destino = r.id_destino
GROUP BY d.id_destino, d.nome_destino
HAVING COUNT(r.id_reserva) >= 5;

SELECT d.nome_destino, SUM(r.valor) AS valor_total
FROM Destino d
INNER JOIN Reserva r ON d.id_destino = r.id_destino
GROUP BY d.id_destino, d.nome_destino
HAVING SUM(r.valor) > 5000.00;

SELECT d.pais, AVG(r.valor) AS media_valor
FROM Destino d
INNER JOIN Reserva r ON d.id_destino = r.id_destino
GROUP BY d.pais
HAVING AVG(r.valor) > 1000.00;

SELECT c.nome AS cliente, MAX(r.valor) AS reserva_mais_cara
FROM Cliente c
INNER JOIN Reserva r ON c.id_cliente = r.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING MAX(r.valor) > 2000.00;


-- =====================================================
-- 4. CLÍNICA MÉDICA
-- =====================================================

DROP TABLE IF EXISTS Consulta, Medico, Paciente;

CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE Medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    especialidade VARCHAR(50)
);

CREATE TABLE Consulta (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_medico INT,
    data_consulta DATE,
    valor DECIMAL(10,2)
);

INSERT INTO Paciente VALUES
(1, 'Roberto Alves');

INSERT INTO Medico VALUES
(1, 'Dr. Carlos', 'Cardiologia'),
(2, 'Dra. Patricia', 'Cardiologia');

-- Inserir 21 consultas para o Dr. Carlos (total > R$ 10.000 para a especialidade Cardiologia)

INSERT INTO Consulta (id_paciente, id_medico, data_consulta, valor) VALUES
(1, 1, '2026-01-01', 500.00),
(1, 1, '2026-01-02', 500.00),
(1, 1, '2026-01-03', 500.00),
(1, 1, '2026-01-04', 500.00),
(1, 1, '2026-01-05', 500.00),
(1, 1, '2026-01-06', 500.00),
(1, 1, '2026-01-07', 500.00),
(1, 1, '2026-01-08', 500.00),
(1, 1, '2026-01-09', 500.00),
(1, 1, '2026-01-10', 500.00),
(1, 1, '2026-01-11', 500.00),
(1, 1, '2026-01-12', 500.00),
(1, 1, '2026-01-13', 500.00),
(1, 1, '2026-01-14', 500.00),
(1, 1, '2026-01-15', 500.00),
(1, 1, '2026-01-16', 500.00),
(1, 1, '2026-01-17', 500.00),
(1, 1, '2026-01-18', 500.00),
(1, 1, '2026-01-19', 500.00),
(1, 1, '2026-01-20', 500.00),
(1, 1, '2026-01-21', 500.00);

-- Consultas Clínica

SELECT m.nome AS medico, COUNT(c.id_consulta) AS qtd_consultas
FROM Medico m
INNER JOIN Consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome
HAVING COUNT(c.id_consulta) > 20;

SELECT m.nome AS medico, AVG(c.valor) AS media_valor
FROM Medico m
INNER JOIN Consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome
HAVING AVG(c.valor) > 150.00;

SELECT m.especialidade, SUM(c.valor) AS arrecadacao_total
FROM Medico m
INNER JOIN Consulta c ON m.id_medico = c.id_medico
GROUP BY m.especialidade
HAVING SUM(c.valor) > 10000.00;


-- =====================================================
-- 5. FARMÁCIA
-- =====================================================

DROP TABLE IF EXISTS Compra, Fornecedor, Medicamento;

CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(50)
);

CREATE TABLE Compra (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_medicamento INT,
    id_fornecedor INT,
    quantidade INT,
    data_compra DATE
);

INSERT INTO Medicamento VALUES
(1, 'Dipirona', 5.00);

INSERT INTO Fornecedor VALUES
(1, 'EMS', 'São Paulo');

-- Inserir 11 compras para EMS (total 110 unidades de Dipirona)

INSERT INTO Compra (id_medicamento, id_fornecedor, quantidade, data_compra) VALUES
(1, 1, 10, '2026-01-01'),
(1, 1, 10, '2026-01-02'),
(1, 1, 10, '2026-01-03'),
(1, 1, 10, '2026-01-04'),
(1, 1, 10, '2026-01-05'),
(1, 1, 10, '2026-01-06'),
(1, 1, 10, '2026-01-07'),
(1, 1, 10, '2026-01-08'),
(1, 1, 10, '2026-01-09'),
(1, 1, 10, '2026-01-10'),
(1, 1, 10, '2026-01-11');

-- Consultas Farmácia

SELECT f.nome AS fornecedor, COUNT(c.id_compra) AS qtd_compras
FROM Fornecedor f
INNER JOIN Compra c ON f.id_fornecedor = c.id_fornecedor
GROUP BY f.id_fornecedor, f.nome
HAVING COUNT(c.id_compra) > 10;

SELECT m.nome AS medicamento, SUM(c.quantidade) AS total_unidades
FROM Medicamento m
INNER JOIN Compra c ON m.id_medicamento = c.id_medicamento
GROUP BY m.id_medicamento, m.nome
HAVING SUM(c.quantidade) > 100;