# Documentação Técnica - ConstruShop E-commerce

## 📐 Arquitetura em Camadas

O projeto segue o padrão **N-Tier Architecture** (Arquitetura em N camadas), garantindo separação de responsabilidades e facilidade de manutenção.

```
┌─────────────────────────────────────────────────────┐
│                   Presentation Layer                │
│              (REST Controllers - @RestController)    │
│  ProductController, CategoryController, UserController...
└─────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────┐
│                   Business Logic Layer               │
│                   (Services - @Service)              │
│  ProductService, CategoryService, OrderService...   │
└─────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────┐
│                Data Access Layer                     │
│              (Repositories - @Repository)            │
│  ProductRepository, CategoryRepository...            │
└─────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────┐
│               Database Layer (H2/PostgreSQL)         │
└─────────────────────────────────────────────────────┘
```

## 🏛️ Padrões de Design Implementados

### 1. **DTO (Data Transfer Object)**
**Propósito**: Separar a representação da entidade da sua transferência pela rede

**Implementação**:
- `ProductRequest` / `ProductResponse`
- `CategoryRequest` / `CategoryResponse`
- Reduz exposição de dados sensíveis
- Valida dados na entrada

```java
@Data
public class ProductRequest {
    @NotBlank(message = "Nome é obrigatório")
    private String name;
    
    @NotNull(message = "Preço é obrigatório")
    @Positive(message = "Preço deve ser positivo")
    private Double price;
}
```

### 2. **Service Layer Pattern**
**Propósito**: Concentrar lógica de negócio fora dos controllers

**Exemplo - OrderService**:
```java
@Service
@RequiredArgsConstructor
public class OrderService {
    
    @Transactional
    public OrderResponse checkout(CheckoutRequest request) {
        // Validar cart
        // Verificar estoque
        // Reduzir estoque
        // Criar pedido
        // Limpar carrinho
        // Retornar resposta
    }
}
```

### 3. **Repository Pattern**
**Propósito**: Abstrair acesso a dados

```java
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategoryId(Long categoryId);
    List<Product> findByNameContainingIgnoreCase(String name);
}
```

### 4. **Global Exception Handler**
**Propósito**: Tratamento centralizado de exceções

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(new ErrorResponse(ex.getMessage()));
    }
}
```

### 5. **Builder Pattern (com Lombok)**
**Propósito**: Construção fluente de objetos

```java
Product product = Product.builder()
    .name("Cimento")
    .price(39.90)
    .stockQuantity(500)
    .category(category)
    .build();
```

## 🔄 Fluxo de Requisição (Request-Response Cycle)

```
1. Cliente HTTP
   ↓
2. Spring DispatcherServlet
   ↓
3. Controller (@RestController)
   └─ Recebe requisição
   └─ Valida @RequestBody (@Valid)
   ↓
4. Service (@Service)
   └─ Lógica de negócio
   └─ Validações extras
   └─ Transações (@Transactional)
   ↓
5. Repository (JpaRepository)
   └─ Acesso a dados
   └─ Queries HQL
   ↓
6. Database
   └─ Persiste/Recupera dados
   ↓
7. Service → DTO Conversion
   └─ Entity → Response DTO
   ↓
8. Controller
   └─ Return ResponseEntity
   ↓
9. GlobalExceptionHandler (se erro)
   └─ Captura exceções
   └─ Converte em JSON
   ↓
10. Cliente recebe JSON
```

## 📊 Modelo de Dados - Relacionamentos

### Diagrama ER (Entity-Relationship)

```
┌─────────────┐         ┌───────────────┐
│ Category    │─────1──N│ Product       │
└─────────────┘         └───────────────┘
                                │
                                │1
                        ┌───────┴────────┐
                        │                 │
                    ┌───N───┐        ┌────N────┐
                    │        │        │         │
                ┌───────┐  ┌────────────┐   ┌──────────┐
                │CartItem  │OrderItem   │   │Product   │
                └─────┬─┘  └──────┬──────┘   └──────────┘
                      │          │
                      │          └─────────1────┐
                      │                         │
                   ┌──┴─────────┐            ┌──────────┐
                   │            │            │  Order   │
                ┌──────────┐   │            └──────────┘
                │  User    │───┼─────1─────┐
                └──────────┘   │            │
                               │        ┌────────────┐
                               └────1───│ Address    │
                                       └────────────┘
```

### Relacionamentos Descritos

1. **Category (1) ──→ (N) Product**
   - Cascade: ALL
   - OrphanRemoval: true
   - Uma categoria pode ter muitos produtos

2. **User (1) ──→ (N) Order**
   - Cascade: ALL
   - OrphanRemoval: true
   - Um usuário pode ter múltiplos pedidos

3. **User (1) ──→ (N) CartItem**
   - Cascade: ALL
   - OrphanRemoval: true
   - Carrinho associado ao usuário

4. **Order (1) ──→ (N) OrderItem**
   - Cascade: ALL
   - OrphanRemoval: true
   - Itens contidos em um pedido

5. **Product (1) ──→ (N) OrderItem**
   - FetchType: LAZY
   - Produto referenciado em vários pedidos

## 🛡️ Validação em Camadas

### 1. Validação no DTO (Jakarta Validation)
```java
@Data
public class ProductRequest {
    @NotBlank(message = "Nome é obrigatório")
    private String name;
    
    @NotNull
    @Positive
    private Double price;
}
```

### 2. Validação na Service
```java
@Service
public class ProductService {
    public ProductResponse save(ProductRequest request) {
        // Validar duplicata
        if (productExists(request.getName())) {
            throw new BusinessException("Produto já existe");
        }
        // Validar categoria
        Category category = categoryService.findEntityById(request.getCategoryId());
        if (category == null) {
            throw new ResourceNotFoundException("Categoria não encontrada");
        }
    }
}
```

### 3. Validação de Negócio
```java
@Transactional
public OrderResponse checkout(CheckoutRequest request) {
    // Validar carrinho
    List<CartItem> items = cartItemRepository.findByUserId(request.getUserId());
    if (items.isEmpty()) {
        throw new BusinessException("Carrinho está vazio");
    }
    
    // Validar estoque
    for (CartItem item : items) {
        if (item.getProduct().getStockQuantity() < item.getQuantity()) {
            throw new InsufficientStockException(
                item.getProduct().getName(),
                item.getProduct().getStockQuantity(),
                item.getQuantity()
            );
        }
    }
}
```

## 💾 Transações e Integridade

### @Transactional
```java
@Transactional
public OrderResponse checkout(CheckoutRequest request) {
    // Toda a operação é atômica:
    // - Se falhar em qualquer ponto, ROLLBACK
    // - Se sucesso, COMMIT
    
    // 1. Validar
    // 2. Reduzir estoque
    // 3. Criar pedido
    // 4. Limpar carrinho
    // 5. Retornar resposta
}
```

### Propagação de Transações
- `REQUIRED` (padrão): Usa transação existente ou cria nova
- `REQUIRES_NEW`: Cria sempre uma nova transação
- `SUPPORTS`: Usa existente se houver, caso contrário executa sem

```java
@Transactional(propagation = Propagation.REQUIRES_NEW)
public void updateInventory(Long productId, Integer quantity) {
    // Cria transação independente
}
```

## 🔍 Queries e Performance

### Lazy vs Eager Loading

**Lazy (Padrão)**: Carrega dados sob demanda
```java
@ManyToOne(fetch = FetchType.LAZY)
private Category category;
```

**Eager**: Carrega dados logo na consulta
```java
@OneToMany(fetch = FetchType.EAGER)
private List<OrderItem> items;
```

### Custom Queries
```java
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Derivada - gera SQL automaticamente
    List<Product> findByCategoryId(Long categoryId);
    
    // JPQL customizada
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(concat('%', ?1, '%'))")
    List<Product> searchByName(String name);
}
```

## 🚀 Performance - Melhores Práticas

### 1. Índices no Banco
```java
@Entity
@Table(name = "products", indexes = {
    @Index(name = "idx_category_id", columnList = "category_id"),
    @Index(name = "idx_product_name", columnList = "name")
})
public class Product { }
```

### 2. Paginação (Recomendado para listas grandes)
```java
// Exemplo com Spring Data Web support
@GetMapping
public ResponseEntity<Page<ProductResponse>> findAll(
    @PageableDefault(size = 20, sort = "id", direction = Sort.Direction.DESC)
    Pageable pageable) {
    return ResponseEntity.ok(productService.findAll(pageable));
}
```

### 3. Batch Processing
```java
spring.jpa.properties.hibernate.jdbc.batch_size=20
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
```

## 🔐 Segurança (Próximas Implementações)

### Spring Security + JWT
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/public/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .requestMatchers("/api/user/**").hasRole("USER")
                .anyRequest().authenticated()
            )
            .httpBasic()
            .and()
            .addFilter(new JWTAuthenticationFilter(...))
            .addFilter(new JWTAuthorizationFilter(...));
        
        return http.build();
    }
}
```

## 📝 Logging e Monitoramento

### Níveis de Log
```properties
logging.level.root=INFO
logging.level.com.reis.construshop=DEBUG
logging.level.org.springframework.web=WARN
logging.level.org.hibernate.SQL=DEBUG
```

### Exemplo de Log na Service
```java
@Service
@Slf4j
public class OrderService {
    
    public OrderResponse checkout(CheckoutRequest request) {
        log.info("Iniciando checkout para usuário: {}", request.getUserId());
        try {
            // ...
            log.info("Pedido criado com sucesso: {}", order.getId());
            return toResponse(order);
        } catch (Exception e) {
            log.error("Erro ao processar checkout: ", e);
            throw e;
        }
    }
}
```

## 🧪 Testes Recomendados

### Unit Tests (Service Layer)
```java
@ExtendWith(MockitoExtension.class)
public class ProductServiceTest {
    
    @Mock
    private ProductRepository repository;
    
    @InjectMocks
    private ProductService service;
    
    @Test
    public void testFindById_Success() {
        Product product = new Product();
        when(repository.findById(1L)).thenReturn(Optional.of(product));
        
        ProductResponse response = service.findById(1L);
        
        assertNotNull(response);
        verify(repository, times(1)).findById(1L);
    }
}
```

### Integration Tests (Controller)
```java
@SpringBootTest
@AutoConfigureMockMvc
public class ProductControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    public void testGetProducts() throws Exception {
        mockMvc.perform(get("/api/products"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(greaterThan(0))));
    }
}
```

## 📦 Dependências Maven

```xml
<!-- Spring Boot Web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- Spring Data JPA -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<!-- Jakarta Validation -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>

<!-- Lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>

<!-- H2 Database (Development) -->
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>

<!-- PostgreSQL (Production) -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

## 🎯 Checklist de Implementação Concluída

✅ Entidades JPA com relacionamentos corretos
✅ Enums para tipos (UserRole, OrderStatus)
✅ DTOs para Request e Response
✅ Repositories com queries customizadas
✅ Services com lógica de negócio
✅ Controllers REST com validação
✅ Tratamento global de exceções
✅ Dados iniciais (data.sql)
✅ Transações e cascata apropriada
✅ Validação em múltiplas camadas

## 🔮 Próximas Melhorias

- [ ] Spring Security + JWT Authentication
- [ ] Swagger/OpenAPI Documentation
- [ ] Testes unitários e de integração
- [ ] Cache com Spring Cache (Redis)
- [ ] Upload de imagens (AWS S3)
- [ ] Integração com gateway de pagamento
- [ ] Notificações (Email/SMS)
- [ ] Logs com ELK Stack
- [ ] CI/CD Pipeline
- [ ] GraphQL como alternativa REST

---

**Versão**: 1.0.0  
**Última atualização**: 2026-04-19  
**Status**: ✅ Pronto para desenvolvimento

