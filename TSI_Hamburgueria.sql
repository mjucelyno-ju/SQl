-- database: :memory:

CREATE TABLE produtos (
    id_produtos INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
        CHECK (preco >= 0),
    categoria VARCHAR(50) NOT NULL,
    disponivel BOOLEAN NOT NULL DEFAULT 1
        CHECK (disponivel IN (0, 1))
);