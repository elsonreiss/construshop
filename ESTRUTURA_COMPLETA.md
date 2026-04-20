# 🏗️ ConstruShop E-commerce - Estrutura Completa Implementada

## 📋 Resumo do Projeto

**ConstruShop** é uma aplicação Spring Boot 3.4.1 completa para gerenciar um e-commerce de materiais de construção. O projeto foi estruturado seguindo as melhores práticas de desenvolvimento Java e implementa uma arquitetura robusta em camadas.

---

## 📂 Estrutura de Diretórios Criada

```
construshop/
├── src/
│   ├── main/
│   │   ├── java/com/reis/construshop/
│   │   │   ├── ConstrushopApplication.java
│   │   │   ├── controller/
│   │   │   │   ├── ProductController.java      ✅ CRUD Produtos
│   │   │   │   ├── CategoryController.java     ✅ CRUD Categorias
│   │   │   │   ├── UserController.java         ✅ CRUD Usuários
│   │   │   │   ├── AddressController.java      ✅ CRUD Endereços
│   │   │   │   ├── CartController.java         ✅ Gerenciamento Carrinho
│   │   │   │   └── OrderController.java        ✅ Gerenciamento Pedidos
│   │   │   │
│   │   │   ├── service/
│   │   │   │   ├── ProductService.java         ✅ Lógica Produtos
│   │   │   │   ├── CategoryService.java        ✅ Lógica Categorias
│   │   │   │   ├── UserService.java            ✅ Lógica Usuários
│   │   │   │   ├── AddressService.java         ✅ Lógica Endereços
│   │   │   │   ├── CartService.java            ✅ Lógica Carrinho
│   │   │   │   └── OrderService.java           ✅ Lógica Pedidos (Checkout, Cancelamento, Estoque)
│   │   │   │
│   │   │   ├── repository/
│   │   │   │   ├── ProductRepository.java      ✅ Queries: findByCategoryId, findByNameContaining
│   │   │   │   ├── CategoryRepository.java     ✅ Queries: existsByName
│   │   │   │   ├── UserRepository.java         ✅ Queries: findByEmail, existsByEmail
│   │   │   │   ├── AddressRepository.java      ✅ Queries: findByUserId
│   │   │   │   ├── CartItemRepository.java     ✅ Queries: findByUserId, findByUserAndProduct
│   │   │   │   └── OrderRepository.java        ✅ Queries: findByUserId, findByStatus
│   │   │   │
│   │   │   ├── entity/
│   │   │   │   ├── Product.java                ✅ ManyToOne Category
│   │   │   │   ├── Category.java               ✅ OneToMany Products
│   │   │   │   ├── User.java                   ✅ OneToMany Orders, Addresses, CartItems
│   │   │   │   ├── Address.java                ✅ ManyToOne User
│   │   │   │   ├── Order.java                  ✅ ManyToOne User & Address, OneToMany OrderItems
│   │   │   │   ├── OrderItem.java              ✅ ManyToOne Order & Product
│   │   │   │   ├── CartItem.java               ✅ ManyToOne User & Product
│   │   │   │   └── enums/
│   │   │   │       ├── UserRole.java           ✅ ADMIN, CUSTOMER
│   │   │   │       └── OrderStatus.java        ✅ PENDING, PAID, SHIPPED, DELIVERED, CANCELLED
│   │   │   │
│   │   │   ├── dto/
│   │   │   │   ├── request/
│   │   │   │   │   ├── ProductRequest.java     ✅ Validações: NotBlank, NotNull, Positive
│   │   │   │   │   ├── CategoryRequest.java    ✅ Validações: NotBlank
│   │   │   │   │   ├── UserRequest.java        ✅ Validações: Email, NotBlank, Role
│   │   │   │   │   ├── AddressRequest.java     ✅ Validações: EndereçoCompleto
│   │   │   │   │   ├── CartItemRequest.java    ✅ Validações: Positive
│   │   │   │   │   └── CheckoutRequest.java    ✅ Validações: UserId, AddressId
│   │   │   │   │
│   │   │   │   └── response/
│   │   │   │       ├── ProductResponse.java
│   │   │   │       ├── CategoryResponse.java
│   │   │   │       ├── UserResponse.java
│   │   │   │       ├── AddressResponse.java
│   │   │   │       ├── CartItemResponse.java
│   │   │   │       ├── CartResponse.java
│   │   │   │       ├── OrderResponse.java
│   │   │   │       └── OrderItemResponse.java
│   │   │   │
│   │   │   └── exception/
│   │   │       ├── ResourceNotFoundException.java    ✅ 404
│   │   │       ├── InsufficientStockException.java   ✅ 422
│   │   │       ├── BusinessException.java            ✅ 400
│   │   │       └── GlobalExceptionHandler.java       ✅ Centralizado
│   │   │
│   │   └── resources/
│   │       ├── application.properties           ✅ H2 + Seed Data
│   │       ├── application-prod.properties      ✅ PostgreSQL
│   │       ├── application-test.properties      ✅ H2 para Testes
│   │       └── data.sql                         ✅ 8 Categorias, 12 Produtos, 3 Usuários, 2 Endereços
│   │
│   └── test/
│       └── java/com/reis/construshop/
│           └── ConstrushopApplicationTests.java
│
├── pom.xml                                       ✅ Maven - Spring Boot 3.4.1, Java 21
├── README.md                                     ✅ Documentação Completa da API
├── ARQUITETURA.md                               ✅ Padrões de Design e Boas Práticas
├── POSTMAN_COLLECTION.json                      ✅ 30+ Endpoints Testáveis
├── API_EXAMPLES.sh                              ✅ Exemplos cURL
├── Dockerfile                                   ✅ Build Multi-stage
├── docker-compose.yml                           ✅ App + PostgreSQL
├── mvnw e mvnw.cmd                              ✅ Maven Wrapper
└── .gitignore                                   ✅ Gitignore Padrão
```

---

## ✨ Funcionalidades Implementadas

### 1️⃣ **Gestão de Categorias**
- ✅ Listar, criar, atualizar, deletar categorias
- ✅ Validação de nome único
- ✅ Relacionamento OneToMany com Produtos

### 2️⃣ **Gestão de Produtos**
- ✅ CRUD completo
- ✅ Filtro por categoria
- ✅ Busca por nome (case-insensitive)
- ✅ Validação de preço positivo
- ✅ Controle de estoque
- ✅ Imagem URL

### 3️⃣ **Gestão de Usuários**
- ✅ Registro de novos usuários
- ✅ CRUD completo
- ✅ Email único
- ✅ Roles: ADMIN e CUSTOMER
- ✅ Telefone opcional

### 4️⃣ **Gestão de Endereços**
- ✅ Múltiplos endereços por usuário
- ✅ Validação de endereço completo
- ✅ CRUD

### 5️⃣ **Carrinho de Compras**
- ✅ Adicionar produtos ao carrinho
- ✅ Atualizar quantidade
- ✅ Remover itens
- ✅ Limpar carrinho
- ✅ Cálculo automático de total

### 6️⃣ **Gestão de Pedidos**
- ✅ Checkout com validação de estoque
- ✅ Criação automática de OrderItems
- ✅ Redução de estoque
- ✅ Limpeza automática do carrinho
- ✅ Atualização de status (PENDING → PAID → SHIPPED → DELIVERED)
- ✅ Cancelamento de pedido com restauração de estoque
- ✅ Listagem por usuário
- ✅ Relacionamento com Endereço de Entrega

### 7️⃣ **Tratamento de Erros**
- ✅ GlobalExceptionHandler centralizado
- ✅ Validação de entrada (DTOs)
- ✅ Mensagens de erro customizadas
- ✅ HTTP Status apropriados (404, 400, 422, 500)

---

## 🛠️ Tecnologias Utilizadas

| Categoria | Tecnologia | Versão |
|-----------|-----------|--------|
| Framework | Spring Boot | 3.4.1 |
| Linguagem | Java | 21 |
| ORM | Hibernate/JPA | (via Spring Data) |
| Validação | Jakarta Validation | (incluído no Spring) |
| Banco Dev | H2 | In-Memory |
| Banco Prod | PostgreSQL | 15+ |
| Build | Maven | 3.6+ |
| Utilitário | Lombok | (latest) |
| Containerização | Docker | + Docker Compose |

---

## 📡 Endpoints REST Implementados

### Categorias (5 endpoints)
- `GET /api/categories` - Listar
- `GET /api/categories/{id}` - Detalhe
- `POST /api/categories` - Criar
- `PUT /api/categories/{id}` - Atualizar
- `DELETE /api/categories/{id}` - Deletar

### Produtos (5 endpoints)
- `GET /api/products` - Listar (com filtros)
- `GET /api/products/{id}` - Detalhe
- `POST /api/products` - Criar
- `PUT /api/products/{id}` - Atualizar
- `DELETE /api/products/{id}` - Deletar

### Usuários (5 endpoints)
- `GET /api/users` - Listar
- `GET /api/users/{id}` - Detalhe
- `POST /api/users` - Criar
- `PUT /api/users/{id}` - Atualizar
- `DELETE /api/users/{id}` - Deletar

### Endereços (5 endpoints)
- `GET /api/addresses/user/{userId}` - Listar por usuário
- `GET /api/addresses/{id}` - Detalhe
- `POST /api/addresses` - Criar
- `PUT /api/addresses/{id}` - Atualizar
- `DELETE /api/addresses/{id}` - Deletar

### Carrinho (5 endpoints)
- `GET /api/cart/{userId}` - Obter carrinho
- `POST /api/cart` - Adicionar item
- `PUT /api/cart/items/{id}` - Atualizar quantidade
- `DELETE /api/cart/items/{id}` - Remover item
- `DELETE /api/cart/{userId}/clear` - Limpar carrinho

### Pedidos (6 endpoints)
- `GET /api/orders` - Listar todos
- `GET /api/orders/{id}` - Detalhe
- `GET /api/orders/user/{userId}` - Pedidos do usuário
- `POST /api/orders/checkout` - Finalizar compra
- `PATCH /api/orders/{id}/status` - Atualizar status
- `PATCH /api/orders/{id}/cancel` - Cancelar pedido

**Total: 36 Endpoints REST**

---

## 🔄 Fluxo de Negócio - Checkout Completo

```
1. Usuário cria conta
   POST /api/users → User criado

2. Usuário adiciona endereço
   POST /api/addresses → Address criado

3. Usuário navega e adiciona produtos ao carrinho
   POST /api/cart → CartItem adicionado
   POST /api/cart → CartItem adicionado

4. Usuário visualiza carrinho
   GET /api/cart/{userId} → CartResponse com total

5. Usuário finaliza compra
   POST /api/orders/checkout → Validações:
   ├─ Carrinho não está vazio?
   ├─ Estoque disponível?
   ├─ Usuário e endereço existem?
   └─ Se SUCESSO: Ordem criada, estoque reduzido, carrinho limpo

6. Admin acompanha pedido
   GET /api/orders/user/{userId} → Lista de Orders
   
7. Admin atualiza status
   PATCH /api/orders/{id}/status?status=PAID
   PATCH /api/orders/{id}/status?status=SHIPPED
   PATCH /api/orders/{id}/status?status=DELIVERED

8. Usuário pode cancelar (se ainda não enviado)
   PATCH /api/orders/{id}/cancel → Estoque restaurado
```

---

## 📊 Dados Iniciais (Seed Data)

### Categorias (8)
1. Cimento e Argamassa
2. Tintas e Vernizes
3. Ferramentas
4. Hidráulica
5. Elétrica
6. Pisos e Revestimentos
7. Madeiras e Divisórias
8. Segurança e EPI

### Produtos (12)
- 2 em Cimento
- 2 em Tintas
- 2 em Ferramentas
- 2 em Hidráulica
- 1 em Elétrica
- 1 em Pisos
- 0 em Madeiras
- 2 em EPI

### Usuários (3)
- Admin ConstruShop (ADMIN)
- João da Silva (CUSTOMER)
- Maria Oliveira (CUSTOMER)

### Endereços (2)
- São Paulo - João
- Rio de Janeiro - Maria

---

## 🚀 Como Executar

### Desenvolvimento
```bash
cd C:\Users\elson\Downloads\construshop
.\mvnw.cmd clean spring-boot:run --no-transfer-progress
```
Acesso: `http://localhost:8080`
H2 Console: `http://localhost:8080/h2-console`

### Docker
```bash
docker-compose up -d
```

### Produção
```bash
.\mvnw.cmd clean package -DskipTests
java -jar target/construshop-*.jar --spring.profiles.active=prod
```

---

## 📚 Documentação Adicional

- **README.md** - Guia completo de uso da API
- **ARQUITETURA.md** - Padrões, design patterns e boas práticas
- **POSTMAN_COLLECTION.json** - Importar no Postman para testar todos os endpoints
- **API_EXAMPLES.sh** - Scripts cURL para testar

---

## ✅ Checklist de Implementação

- ✅ Entidades JPA com relacionamentos
- ✅ Enums para tipos
- ✅ DTOs com validação
- ✅ Repositories com queries
- ✅ Services com lógica de negócio
- ✅ Controllers REST com validação
- ✅ Tratamento global de exceções
- ✅ Dados iniciais (data.sql)
- ✅ Transações atômicas (@Transactional)
- ✅ Relacionamentos com cascata apropriada
- ✅ Profiles de configuração (dev, prod, test)
- ✅ Dockerfile e docker-compose
- ✅ Documentação completa
- ✅ Exemplos de requisições (Postman + cURL)

---

## 🔮 Melhorias Futuras

- [ ] Spring Security + JWT Authentication
- [ ] Swagger/OpenAPI Documentation
- [ ] Unit e Integration Tests
- [ ] Cache com Redis
- [ ] Upload de Imagens (S3)
- [ ] Gateway de Pagamento (Stripe, PayPal)
- [ ] Notificações (Email/SMS)
- [ ] Logs com ELK Stack
- [ ] CI/CD (GitHub Actions)
- [ ] GraphQL API
- [ ] Rate Limiting
- [ ] API Versioning

---

## 📞 Informações de Contato

**Projeto**: ConstruShop E-commerce  
**Versão**: 0.0.1-SNAPSHOT  
**Data**: 2026-04-19  
**Status**: ✅ Pronto para Desenvolvimento  

---

**A estrutura está completa e pronta para ser utilizada!** 🎉

