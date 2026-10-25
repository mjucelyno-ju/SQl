-- database: :memory:

-- codigos utilizandos na criaçao do banco de dados da hamburgueria.

CREATE TABLE clientes (
    id_clientes INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE pedidos (
    id_pedidos INT PRIMARY KEY,
    id_clientes INT NOT NULL,
    status VARCHAR(30) NOT NULL
        CHECK (status IN ('Pendente', 'Em preparo', 'Saiu para entrega', 'Entregue', 'Cancelado')),
    valor_total DECIMAL(10,2) NOT NULL
        CHECK (valor_total >= 0),
    data_pedidos TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_de_entrega VARCHAR(30) NOT NULL
        CHECK (tipo_de_entrega IN ('Entrega', 'Retirada')),
    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);

CREATE TABLE itens_do_pedido (
    id_item INT PRIMARY KEY,
    id_pedidos INT NOT NULL,
    id_produtos INT NOT NULL,
    quantidade INT NOT NULL
        CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL
        CHECK (preco_unitario >= 0),
    subtotal DECIMAL(10,2) NOT NULL
        CHECK (subtotal >= 0),
    FOREIGN KEY (id_pedidos) REFERENCES pedidos(id_pedidos),
    FOREIGN KEY (id_produtos) REFERENCES produtos(id_produtos)
);

CREATE TABLE produtos (
    id_produtos INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
        CHECK (preco >= 0),
    categoria VARCHAR(50) NOT NULL,
    disponivel BOOLEAN NOT NULL DEFAULT 1
        CHECK (disponivel IN (0, 1))
);

CREATE TABLE produto_ingrediente (
    id_produtos INT NOT NULL,
    id_ingredientes INT NOT NULL,
    quantidade_utilizada INT NOT NULL
        CHECK (quantidade_utilizada > 0),
    PRIMARY KEY (id_produtos, id_ingredientes),
    FOREIGN KEY (id_produtos) REFERENCES produtos(id_produtos),
    FOREIGN KEY (id_ingredientes) REFERENCES ingredientes(id_ingredientes)
);

CREATE TABLE ingredientes (
    id_ingredientes INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    quantidade_estoque INT NOT NULL DEFAULT 0
        CHECK (quantidade_estoque >= 0),
    validade DATE
);

CREATE TABLE pagamentos (
    id_pagamentos INT PRIMARY KEY,
    id_pedidos INT NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL
        CHECK (forma_pagamento IN ('Dinheiro', 'Pix', 'Cartão de crédito', 'Cartão de débito')),
    status_pagamento VARCHAR(30) NOT NULL DEFAULT 'Pendente'
        CHECK (status_pagamento IN ('Pendente', 'Pago', 'Recusado', 'Estornado')),
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_pago DECIMAL(10,2) NOT NULL
        CHECK (valor_pago > 0),
    FOREIGN KEY (id_pedidos) REFERENCES pedidos(id_pedidos)
);

INSERT INTO
    clientes (id_clientes, nome, telefone)
VALUES
    (1, 'augusto silva', '(84) 99699-9967'),
    (2, 'jose santos', '(84) 94699-5567'),
    (3, 'maria souza', '(84) 94680-3517'),
    (4, 'fernando', '(84) 97699-7767'),
    (5, 'geovana', '(84) 93699-3567'),
    (6, 'pedro', '(84) 94680-2515'),
    (7, 'carlos santos', '(84) 97987-1767'),
    (8, 'silva melo', '(84) 93619-3588'),
    (9, 'mendes neto', '(84) 94651-2010'),
    (10, 'francisca', '(84) 98560-3215');






