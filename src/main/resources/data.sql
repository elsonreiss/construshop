-- ========================
-- Categorias
-- ========================
INSERT INTO categories (name, description) VALUES ('Cimento e Argamassa', 'Cimentos, argamassas e produtos para alvenaria');
INSERT INTO categories (name, description) VALUES ('Tintas e Vernizes', 'Tintas, vernizes, impermeabilizantes e acessórios');
INSERT INTO categories (name, description) VALUES ('Ferramentas', 'Ferramentas manuais e elétricas para construção');
INSERT INTO categories (name, description) VALUES ('Hidráulica', 'Tubos, conexões, torneiras e materiais hidráulicos');
INSERT INTO categories (name, description) VALUES ('Elétrica', 'Fios, disjuntores, tomadas e materiais elétricos');
INSERT INTO categories (name, description) VALUES ('Pisos e Revestimentos', 'Cerâmicas, porcelanatos, azulejos e revestimentos');
INSERT INTO categories (name, description) VALUES ('Madeiras e Divisórias', 'Madeiras, compensados, dry-wall e divisórias');
INSERT INTO categories (name, description) VALUES ('Segurança e EPI', 'Capacetes, luvas, óculos e equipamentos de proteção');

-- ========================
-- Produtos
-- ========================
INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Cimento CP II 50kg', 'Cimento Portland CP II - saco de 50kg', 39.90, 500, null, 1);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Argamassa AC-II 20kg', 'Argamassa colante para cerâmica - 20kg', 24.50, 300, null, 1);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Tinta Acrílica Branca 18L', 'Tinta acrílica premium - lata 18L', 189.90, 80, null, 2);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Rolo de Lã 23cm', 'Rolo de lã para pintura - 23cm', 12.90, 200, null, 2);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Furadeira de Impacto 650W', 'Furadeira de impacto 650W com maleta', 279.00, 40, null, 3);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Martelo Carpinteiro 27mm', 'Martelo de carpinteiro cabo de madeira', 34.90, 150, null, 3);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Tubo PVC 100mm 6m', 'Tubo PVC esgoto 100mm x 6m', 49.90, 200, null, 4);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Torneira de Cozinha Bica Alta', 'Torneira de cozinha cromada bica alta', 89.90, 60, null, 4);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Fio Elétrico 2.5mm 100m', 'Rolo fio elétrico flexível 2.5mm - 100m', 149.90, 120, null, 5);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Porcelanato 60x60 Matte (caixa)', 'Porcelanato retificado 60x60 matte - caixa com 2m²', 119.90, 90, null, 6);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Capacete de Segurança Branco', 'Capacete EPI classe A - cor branca', 18.90, 300, null, 8);

INSERT INTO products (name, description, price, stock_quantity, image_url, category_id)
VALUES ('Luva de Segurança Nitrilica', 'Par de luvas nitrilicas anti-impacto', 22.50, 250, null, 8);

-- ========================
-- Usuários
-- ========================
INSERT INTO users (name, email, password, phone, role)
VALUES ('Admin ConstruShop', 'admin@construshop.com', 'admin123', '(11) 99999-0001', 'ADMIN');

INSERT INTO users (name, email, password, phone, role)
VALUES ('João da Silva', 'joao@email.com', 'senha123', '(11) 98888-1234', 'CUSTOMER');

INSERT INTO users (name, email, password, phone, role)
VALUES ('Maria Oliveira', 'maria@email.com', 'senha123', '(21) 97777-5678', 'CUSTOMER');

-- ========================
-- Endereços
-- ========================
INSERT INTO addresses (street, number, complement, neighborhood, city, state, zip_code, user_id)
VALUES ('Rua das Flores', '123', 'Apto 12', 'Centro', 'São Paulo', 'SP', '01001-000', 2);

INSERT INTO addresses (street, number, complement, neighborhood, city, state, zip_code, user_id)
VALUES ('Av. Brasil', '500', null, 'Jardim América', 'Rio de Janeiro', 'RJ', '20040-020', 3);

