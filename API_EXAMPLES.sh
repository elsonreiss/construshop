#!/bin/bash
# ConstruShop API - Exemplos cURL
# Base URL: http://localhost:8080

echo "=== ConstruShop E-commerce API - Exemplos cURL ==="
echo ""

# ============================================================
# 1. CATEGORIAS
# ============================================================
echo "--- 1. CATEGORIAS ---"
echo ""

echo "1.1 - Listar todas as categorias"
curl -X GET "http://localhost:8080/api/categories" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "1.2 - Obter categoria por ID (ID: 1)"
curl -X GET "http://localhost:8080/api/categories/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "1.3 - Criar nova categoria"
curl -X POST "http://localhost:8080/api/categories" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Louças Sanitárias",
    "description": "Pias, vasos e produtos sanitários"
  }'
echo ""
echo ""

echo "1.4 - Atualizar categoria (ID: 1)"
curl -X PUT "http://localhost:8080/api/categories/1" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Cimento e Argamassa (Premium)",
    "description": "Cimentos premium para obras de alta qualidade"
  }'
echo ""
echo ""

echo "1.5 - Deletar categoria (ID: 1)"
curl -X DELETE "http://localhost:8080/api/categories/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

# ============================================================
# 2. PRODUTOS
# ============================================================
echo "--- 2. PRODUTOS ---"
echo ""

echo "2.1 - Listar todos os produtos"
curl -X GET "http://localhost:8080/api/products" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "2.2 - Filtrar produtos por categoria (categoryId: 1)"
curl -X GET "http://localhost:8080/api/products?categoryId=1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "2.3 - Buscar produtos por nome (name: cimento)"
curl -X GET "http://localhost:8080/api/products?name=cimento" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "2.4 - Obter produto por ID (ID: 1)"
curl -X GET "http://localhost:8080/api/products/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "2.5 - Criar novo produto"
curl -X POST "http://localhost:8080/api/products" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Bloco de Concreto 14x19x39",
    "description": "Bloco de concreto para alvenaria",
    "price": 5.50,
    "stockQuantity": 1000,
    "imageUrl": null,
    "categoryId": 1
  }'
echo ""
echo ""

echo "2.6 - Atualizar produto (ID: 1)"
curl -X PUT "http://localhost:8080/api/products/1" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Cimento CP II 50kg (Premium)",
    "description": "Cimento Portland CP II - saco de 50kg - PROMOÇÃO",
    "price": 35.90,
    "stockQuantity": 600,
    "imageUrl": null,
    "categoryId": 1
  }'
echo ""
echo ""

echo "2.7 - Deletar produto (ID: 1)"
curl -X DELETE "http://localhost:8080/api/products/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

# ============================================================
# 3. USUÁRIOS
# ============================================================
echo "--- 3. USUÁRIOS ---"
echo ""

echo "3.1 - Listar todos os usuários"
curl -X GET "http://localhost:8080/api/users" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "3.2 - Obter usuário por ID (ID: 1)"
curl -X GET "http://localhost:8080/api/users/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "3.3 - Registrar novo usuário"
curl -X POST "http://localhost:8080/api/users" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Pedro Santos",
    "email": "pedro@email.com",
    "password": "senha123",
    "phone": "(11) 96666-7890",
    "role": "CUSTOMER"
  }'
echo ""
echo ""

echo "3.4 - Atualizar usuário (ID: 2)"
curl -X PUT "http://localhost:8080/api/users/2" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "João da Silva (Atualizado)",
    "email": "joao@email.com",
    "password": "nova_senha",
    "phone": "(11) 98888-9999",
    "role": "CUSTOMER"
  }'
echo ""
echo ""

echo "3.5 - Deletar usuário (ID: 2)"
curl -X DELETE "http://localhost:8080/api/users/2" \
  -H "Content-Type: application/json"
echo ""
echo ""

# ============================================================
# 4. ENDEREÇOS
# ============================================================
echo "--- 4. ENDEREÇOS ---"
echo ""

echo "4.1 - Listar endereços do usuário (userID: 2)"
curl -X GET "http://localhost:8080/api/addresses/user/2" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "4.2 - Obter endereço por ID (ID: 1)"
curl -X GET "http://localhost:8080/api/addresses/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "4.3 - Adicionar novo endereço"
curl -X POST "http://localhost:8080/api/addresses" \
  -H "Content-Type: application/json" \
  -d '{
    "street": "Av. Paulista",
    "number": "1000",
    "complement": "Sala 200",
    "neighborhood": "Bela Vista",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01311-100",
    "userId": 2
  }'
echo ""
echo ""

echo "4.4 - Atualizar endereço (ID: 1)"
curl -X PUT "http://localhost:8080/api/addresses/1" \
  -H "Content-Type: application/json" \
  -d '{
    "street": "Av. Paulista",
    "number": "1200",
    "complement": "Sala 300",
    "neighborhood": "Bela Vista",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01311-100",
    "userId": 2
  }'
echo ""
echo ""

echo "4.5 - Deletar endereço (ID: 1)"
curl -X DELETE "http://localhost:8080/api/addresses/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

# ============================================================
# 5. CARRINHO
# ============================================================
echo "--- 5. CARRINHO ---"
echo ""

echo "5.1 - Obter carrinho do usuário (userID: 2)"
curl -X GET "http://localhost:8080/api/cart/2" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "5.2 - Adicionar item ao carrinho"
curl -X POST "http://localhost:8080/api/cart" \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 2,
    "productId": 1,
    "quantity": 2
  }'
echo ""
echo ""

echo "5.3 - Atualizar quantidade de item (cartItemID: 1, quantity: 5)"
curl -X PUT "http://localhost:8080/api/cart/items/1?quantity=5" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "5.4 - Remover item do carrinho (cartItemID: 1)"
curl -X DELETE "http://localhost:8080/api/cart/items/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "5.5 - Limpar carrinho (userID: 2)"
curl -X DELETE "http://localhost:8080/api/cart/2/clear" \
  -H "Content-Type: application/json"
echo ""
echo ""

# ============================================================
# 6. PEDIDOS
# ============================================================
echo "--- 6. PEDIDOS ---"
echo ""

echo "6.1 - Listar todos os pedidos (Admin)"
curl -X GET "http://localhost:8080/api/orders" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "6.2 - Obter pedido por ID (ID: 1)"
curl -X GET "http://localhost:8080/api/orders/1" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "6.3 - Listar pedidos do usuário (userID: 2)"
curl -X GET "http://localhost:8080/api/orders/user/2" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "6.4 - Finalizar compra (Checkout)"
curl -X POST "http://localhost:8080/api/orders/checkout" \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 2,
    "addressId": 1
  }'
echo ""
echo ""

echo "6.5 - Atualizar status do pedido (ID: 1, status: PAID)"
curl -X PATCH "http://localhost:8080/api/orders/1/status?status=PAID" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "6.6 - Cancelar pedido (ID: 1)"
curl -X PATCH "http://localhost:8080/api/orders/1/cancel" \
  -H "Content-Type: application/json"
echo ""
echo ""

echo "=== FIM DOS EXEMPLOS ==="

