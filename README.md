# ConstruShop - E-commerce de Materiais de Construção

## 📋 Visão Geral

ConstruShop é uma aplicação Spring Boot desenvolvida em Java para gerenciar um e-commerce completo de materiais de construção. O projeto segue as melhores práticas de arquitetura em camadas (Entity → Repository → Service → Controller) com DTOs, validação, tratamento de exceções centralizado e relacionamentos complexos de banco de dados.

## 🏗️ Arquitetura do Projeto

```
src/main/java/com/reis/construshop/
├── ConstrushopApplication.java          # Classe principal
├── controller/                          # Camada de Controle REST
│   ├── ProductController.java
│   ├── CategoryController.java
│   ├── UserController.java
│   ├── AddressController.java
│   ├── CartController.java
│   └── OrderController.java
├── service/                             # Camada de Lógica de Negócio
│   ├── ProductService.java
│   ├── CategoryService.java
│   ├── UserService.java
│   ├── AddressService.java
│   ├── CartService.java
│   └── OrderService.java
├── repository/                          # Camada de Acesso a Dados
│   ├── ProductRepository.java
│   ├── CategoryRepository.java
│   ├── UserRepository.java
│   ├── AddressRepository.java
│   ├── CartItemRepository.java
│   └── OrderRepository.java
├── entity/                              # Entidades JPA
│   ├── Product.java
│   ├── Category.java
│   ├── User.java
│   ├── Address.java
│   ├── Order.java
│   ├── OrderItem.java
│   ├── CartItem.java
│   └── enums/
│       ├── UserRole.java                # ADMIN, CUSTOMER
│       └── OrderStatus.java             # PENDING, PAID, SHIPPED, DELIVERED, CANCELLED
├── dto/                                 # Objetos de Transferência de Dados
│   ├── request/
│   │   ├── ProductRequest.java
│   │   ├── CategoryRequest.java
│   │   ├── UserRequest.java
│   │   ├── AddressRequest.java
│   │   ├── CartItemRequest.java
│   │   └── CheckoutRequest.java
│   └── response/
│       ├── ProductResponse.java
│       ├── CategoryResponse.java
│       ├── UserResponse.java
│       ├── AddressResponse.java
│       ├── CartItemResponse.java
│       ├── CartResponse.java
│       ├── OrderResponse.java
│       └── OrderItemResponse.java
└── exception/                           # Tratamento de Exceções
    ├── ResourceNotFoundException.java
    ├── InsufficientStockException.java
    ├── BusinessException.java
    └── GlobalExceptionHandler.java
```

## 🛠️ Tecnologias Utilizadas

- **Framework**: Spring Boot 3.4.1
- **Linguagem**: Java 21
- **Banco de Dados**: H2 (em memória - desenvolvimento)
- **ORM**: Hibernate/JPA
- **Build**: Maven
- **Validação**: Jakarta Validation
- **Lombok**: Para reduzir código boilerplate
- **CrossOrigin**: Habilitado para requisições de diferentes origens

## 📊 Modelo de Dados

### Relacionamentos Principais

```
Category (1) ──── (N) Product
                     │
                     ├─── (N) CartItem
                     └─── (N) OrderItem

User (1) ──── (N) Address
   │              │
   ├─ (N) Order --┘
   ├─ (N) CartItem
   └─ Role: ADMIN | CUSTOMER

Order (1) ──── (N) OrderItem
  │
  ├─ Status: PENDING | PAID | SHIPPED | DELIVERED | CANCELLED
  └─ DeliveryAddress: Address
```

## 🚀 Como Iniciar a Aplicação

### Pré-requisitos
- Java 21+
- Maven 3.6+

### Passos

1. **Clonar/Navegar ao diretório do projeto**
   ```bash
   cd C:\Users\elson\Downloads\construshop
   ```

2. **Limpar e compilar**
   ```bash
   .\mvnw.cmd clean compile
   ```

3. **Executar a aplicação**
   ```bash
   .\mvnw.cmd spring-boot:run --no-transfer-progress
   ```

4. **Acessar a aplicação**
   - API REST: `http://localhost:8080`
   - H2 Console: `http://localhost:8080/h2-console`
     - Username: `sa`
     - Password: (vazio)
     - JDBC URL: `jdbc:h2:mem:construshop`

## 📡 Endpoints da API

### 1️⃣ **Categorias** (`/api/categories`)

#### GET - Listar todas as categorias
```bash
GET http://localhost:8080/api/categories
```

**Response (200):**
```json
[
  {
    "id": 1,
    "name": "Cimento e Argamassa",
    "description": "Cimentos, argamassas e produtos para alvenaria"
  },
  {
    "id": 2,
    "name": "Tintas e Vernizes",
    "description": "Tintas, vernizes, impermeabilizantes e acessórios"
  }
]
```

#### GET - Obter categoria por ID
```bash
GET http://localhost:8080/api/categories/1
```

#### POST - Criar nova categoria
```bash
POST http://localhost:8080/api/categories
Content-Type: application/json

{
  "name": "Louças Sanitárias",
  "description": "Pias, vasos e produtos sanitários"
}
```

**Response (201):**
```json
{
  "id": 9,
  "name": "Louças Sanitárias",
  "description": "Pias, vasos e produtos sanitários"
}
```

#### PUT - Atualizar categoria
```bash
PUT http://localhost:8080/api/categories/1
Content-Type: application/json

{
  "name": "Cimento e Argamassa (Premium)",
  "description": "Cimentos premium para obras de alta qualidade"
}
```

#### DELETE - Deletar categoria
```bash
DELETE http://localhost:8080/api/categories/1
```

---

### 2️⃣ **Produtos** (`/api/products`)

#### GET - Listar todos os produtos
```bash
GET http://localhost:8080/api/products
```

#### GET - Filtrar por categoria
```bash
GET http://localhost:8080/api/products?categoryId=1
```

#### GET - Buscar por nome
```bash
GET http://localhost:8080/api/products?name=cimento
```

#### GET - Obter produto por ID
```bash
GET http://localhost:8080/api/products/1
```

**Response (200):**
```json
{
  "id": 1,
  "name": "Cimento CP II 50kg",
  "description": "Cimento Portland CP II - saco de 50kg",
  "price": 39.90,
  "stockQuantity": 500,
  "imageUrl": null,
  "categoryName": "Cimento e Argamassa"
}
```

#### POST - Criar novo produto
```bash
POST http://localhost:8080/api/products
Content-Type: application/json

{
  "name": "Bloco de Concreto 14x19x39",
  "description": "Bloco de concreto para alvenaria",
  "price": 5.50,
  "stockQuantity": 1000,
  "imageUrl": "https://...",
  "categoryId": 1
}
```

#### PUT - Atualizar produto
```bash
PUT http://localhost:8080/api/products/1
Content-Type: application/json

{
  "name": "Cimento CP II 50kg (Atualizado)",
  "description": "Cimento Portland CP II - saco de 50kg - PROMOÇÃO",
  "price": 35.90,
  "stockQuantity": 600,
  "imageUrl": null,
  "categoryId": 1
}
```

#### DELETE - Deletar produto
```bash
DELETE http://localhost:8080/api/products/1
```

---

### 3️⃣ **Usuários** (`/api/users`)

#### GET - Listar todos os usuários
```bash
GET http://localhost:8080/api/users
```

#### GET - Obter usuário por ID
```bash
GET http://localhost:8080/api/users/1
```

#### POST - Registrar novo usuário
```bash
POST http://localhost:8080/api/users
Content-Type: application/json

{
  "name": "Pedro Santos",
  "email": "pedro@email.com",
  "password": "senha123",
  "phone": "(11) 96666-7890",
  "role": "CUSTOMER"
}
```

**Response (201):**
```json
{
  "id": 4,
  "name": "Pedro Santos",
  "email": "pedro@email.com",
  "phone": "(11) 96666-7890",
  "role": "CUSTOMER"
}
```

#### PUT - Atualizar usuário
```bash
PUT http://localhost:8080/api/users/1
Content-Type: application/json

{
  "name": "João da Silva (Atualizado)",
  "email": "joao@email.com",
  "password": "nova_senha",
  "phone": "(11) 98888-9999",
  "role": "CUSTOMER"
}
```

#### DELETE - Deletar usuário
```bash
DELETE http://localhost:8080/api/users/1
```

---

### 4️⃣ **Endereços** (`/api/addresses`)

#### GET - Listar endereços do usuário
```bash
GET http://localhost:8080/api/addresses/user/2
```

#### GET - Obter endereço por ID
```bash
GET http://localhost:8080/api/addresses/1
```

#### POST - Adicionar novo endereço
```bash
POST http://localhost:8080/api/addresses
Content-Type: application/json

{
  "street": "Av. Paulista",
  "number": "1000",
  "complement": "Sala 200",
  "neighborhood": "Bela Vista",
  "city": "São Paulo",
  "state": "SP",
  "zipCode": "01311-100",
  "userId": 2
}
```

#### PUT - Atualizar endereço
```bash
PUT http://localhost:8080/api/addresses/1
Content-Type: application/json

{
  "street": "Av. Paulista",
  "number": "1200",
  "complement": "Sala 300",
  "neighborhood": "Bela Vista",
  "city": "São Paulo",
  "state": "SP",
  "zipCode": "01311-100",
  "userId": 2
}
```

#### DELETE - Deletar endereço
```bash
DELETE http://localhost:8080/api/addresses/1
```

---

### 5️⃣ **Carrinho** (`/api/cart`)

#### GET - Obter carrinho do usuário
```bash
GET http://localhost:8080/api/cart/2
```

**Response (200):**
```json
{
  "userId": 2,
  "items": [
    {
      "id": 1,
      "productId": 1,
      "productName": "Cimento CP II 50kg",
      "unitPrice": 39.90,
      "quantity": 2,
      "subtotal": 79.80
    }
  ],
  "total": 79.80
}
```

#### POST - Adicionar item ao carrinho
```bash
POST http://localhost:8080/api/cart
Content-Type: application/json

{
  "userId": 2,
  "productId": 1,
  "quantity": 2
}
```

#### PUT - Atualizar quantidade de item
```bash
PUT http://localhost:8080/api/cart/items/1?quantity=5
```

#### DELETE - Remover item do carrinho
```bash
DELETE http://localhost:8080/api/cart/items/1
```

#### DELETE - Limpar carrinho
```bash
DELETE http://localhost:8080/api/cart/2/clear
```

---

### 6️⃣ **Pedidos** (`/api/orders`)

#### GET - Listar todos os pedidos (Admin)
```bash
GET http://localhost:8080/api/orders
```

#### GET - Obter pedido por ID
```bash
GET http://localhost:8080/api/orders/1
```

#### GET - Listar pedidos do usuário
```bash
GET http://localhost:8080/api/orders/user/2
```

**Response (200):**
```json
[
  {
    "id": 1,
    "userId": 2,
    "userName": "João da Silva",
    "status": "PENDING",
    "total": 79.80,
    "createdAt": "2026-04-19T11:50:00",
    "deliveryAddress": {
      "id": 1,
      "street": "Rua das Flores",
      "number": "123",
      "complement": "Apto 12",
      "neighborhood": "Centro",
      "city": "São Paulo",
      "state": "SP",
      "zipCode": "01001-000"
    },
    "items": [
      {
        "id": 1,
        "productId": 1,
        "productName": "Cimento CP II 50kg",
        "quantity": 2,
        "unitPrice": 39.90,
        "subtotal": 79.80
      }
    ]
  }
]
```

#### POST - Finalizar compra (Checkout)
```bash
POST http://localhost:8080/api/orders/checkout
Content-Type: application/json

{
  "userId": 2,
  "addressId": 1
}
```

**Response (201):**
```json
{
  "id": 1,
  "userId": 2,
  "userName": "João da Silva",
  "status": "PENDING",
  "total": 79.80,
  "createdAt": "2026-04-19T11:50:00",
  "deliveryAddress": { ... },
  "items": [ ... ]
}
```

#### PATCH - Atualizar status do pedido
```bash
PATCH http://localhost:8080/api/orders/1/status?status=PAID
```

**Valores válidos para status**: `PENDING`, `PAID`, `SHIPPED`, `DELIVERED`, `CANCELLED`

#### PATCH - Cancelar pedido
```bash
PATCH http://localhost:8080/api/orders/1/cancel
```

---

## 🔍 Tratamento de Erros

A API retorna respostas padronizadas com tratamento global de exceções:

### Exemplo - 404 Not Found
```json
{
  "timestamp": "2026-04-19T11:50:00",
  "status": 404,
  "message": "Produto não encontrado com id: 999"
}
```

### Exemplo - 400 Bad Request (Validação)
```json
{
  "timestamp": "2026-04-19T11:50:00",
  "status": 400,
  "errors": {
    "name": "Nome é obrigatório",
    "price": "Preço deve ser positivo",
    "categoryId": "Categoria é obrigatória"
  }
}
```

### Exemplo - 422 Unprocessable Entity (Estoque Insuficiente)
```json
{
  "timestamp": "2026-04-19T11:50:00",
  "status": 422,
  "message": "Estoque insuficiente para 'Cimento CP II 50kg'. Disponível: 10, Solicitado: 20"
}
```

---

## 💡 Exemplo de Fluxo Completo

### 1. Registrar Usuário
```bash
POST /api/users
{ "name": "Cliente Novo", "email": "cliente@email.com", "password": "123", "role": "CUSTOMER" }
```

### 2. Adicionar Endereço
```bash
POST /api/addresses
{ "userId": 4, "street": "Rua X", "number": "100", ... }
```

### 3. Adicionar Produtos ao Carrinho
```bash
POST /api/cart
{ "userId": 4, "productId": 1, "quantity": 2 }
POST /api/cart
{ "userId": 4, "productId": 3, "quantity": 1 }
```

### 4. Visualizar Carrinho
```bash
GET /api/cart/4
```

### 5. Finalizar Compra
```bash
POST /api/orders/checkout
{ "userId": 4, "addressId": 1 }
```

### 6. Acompanhar Pedido
```bash
GET /api/orders/user/4
```

---

## 🔒 Boas Práticas Implementadas

✅ **Separação de Responsabilidades** - Entity, DTO, Service, Controller bem definidos
✅ **DTOs** - Proteção de entidades e validação de entrada
✅ **Validação** - Jakarta Validation com mensagens customizadas
✅ **Tratamento de Exceções** - GlobalExceptionHandler centralizado
✅ **Transações** - @Transactional em operações críticas
✅ **Relacionamentos** - ManyToOne, OneToMany com cascade apropriado
✅ **Seed Data** - data.sql com dados iniciais de teste
✅ **CORS** - Habilitado para consumo por frontend
✅ **Lombok** - Redução de código boilerplate (@Getter, @Setter, @Builder)

---

## 📝 Dados Iniciais de Teste

A aplicação carrega automaticamente:

- **8 Categorias**: Cimento, Tintas, Ferramentas, Hidráulica, Elétrica, Pisos, Madeiras, EPI
- **12 Produtos**: Diversos produtos em diferentes categorias
- **3 Usuários**: Admin, João, Maria
- **2 Endereços**: Um para cada cliente

---

## 🚀 Próximos Passos para Produção

1. **Autenticação**: Adicionar Spring Security + JWT
2. **Banco de Dados**: Migrar para PostgreSQL/MySQL
3. **Paginação**: Implementar @PageableDefault nos endpoints
4. **Upload de Imagens**: Configurar S3/Azure Blob Storage
5. **Pagamento**: Integrar gateway de pagamento (Stripe, PayPal)
6. **Notificações**: Email e SMS para confirmação de pedidos
7. **Logging**: ELK Stack para monitoramento
8. **Testes**: Unit tests com JUnit 5 e Mockito
9. **API Documentation**: Swagger/OpenAPI
10. **CI/CD**: GitHub Actions ou Jenkins

---

## 📧 Contato

Para dúvidas ou sugestões, entre em contato com a equipe de desenvolvimento.

**Versão**: 0.0.1-SNAPSHOT  
**Data**: 2026-04-19  
**Status**: ✅ Em Desenvolvimento

