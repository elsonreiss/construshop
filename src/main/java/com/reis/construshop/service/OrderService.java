package com.reis.construshop.service;

import com.reis.construshop.dto.request.CheckoutRequest;
import com.reis.construshop.dto.response.OrderResponse;
import com.reis.construshop.dto.response.OrderItemResponse;
import com.reis.construshop.entity.*;
import com.reis.construshop.entity.enums.OrderStatus;
import com.reis.construshop.exception.BusinessException;
import com.reis.construshop.exception.InsufficientStockException;
import com.reis.construshop.exception.ResourceNotFoundException;
import com.reis.construshop.repository.CartItemRepository;
import com.reis.construshop.repository.OrderRepository;
import com.reis.construshop.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;
    private final UserService userService;
    private final AddressService addressService;

    public List<OrderResponse> findByUser(Long userId) {
        return orderRepository.findByUserId(userId).stream()
                .map(this::toResponse)
                .toList();
    }

    public List<OrderResponse> findAll() {
        return orderRepository.findAll().stream()
                .map(this::toResponse)
                .toList();
    }

    public OrderResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    @Transactional
    public OrderResponse checkout(CheckoutRequest request) {
        User user = userService.findEntityById(request.getUserId());
        Address address = addressService.findEntityById(request.getAddressId());

        List<CartItem> cartItems = cartItemRepository.findByUserId(request.getUserId());
        if (cartItems.isEmpty()) {
            throw new BusinessException("Carrinho está vazio. Adicione produtos antes de finalizar o pedido.");
        }

        // Validate stock and reduce
        for (CartItem cartItem : cartItems) {
            Product product = cartItem.getProduct();
            if (product.getStockQuantity() < cartItem.getQuantity()) {
                throw new InsufficientStockException(product.getName(),
                        product.getStockQuantity(), cartItem.getQuantity());
            }
            product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
            productRepository.save(product);
        }

        // Build order
        Order order = Order.builder()
                .user(user)
                .deliveryAddress(address)
                .status(OrderStatus.PENDING)
                .total(0.0)
                .build();

        List<OrderItem> orderItems = cartItems.stream().map(cartItem -> OrderItem.builder()
                .order(order)
                .product(cartItem.getProduct())
                .quantity(cartItem.getQuantity())
                .unitPrice(cartItem.getProduct().getPrice())
                .build()).toList();

        order.setItems(orderItems);
        double total = orderItems.stream().mapToDouble(OrderItem::getSubtotal).sum();
        order.setTotal(total);

        Order saved = orderRepository.save(order);
        cartItemRepository.deleteByUserId(request.getUserId());

        return toResponse(saved);
    }

    @Transactional
    public OrderResponse updateStatus(Long id, OrderStatus status) {
        Order order = findEntityById(id);
        if (order.getStatus() == OrderStatus.CANCELLED) {
            throw new BusinessException("Pedido cancelado não pode ter o status alterado.");
        }
        order.setStatus(status);
        return toResponse(orderRepository.save(order));
    }

    @Transactional
    public OrderResponse cancel(Long id) {
        Order order = findEntityById(id);
        if (order.getStatus() == OrderStatus.DELIVERED || order.getStatus() == OrderStatus.SHIPPED) {
            throw new BusinessException("Pedidos entregues ou em transporte não podem ser cancelados.");
        }
        // Restore stock
        order.getItems().forEach(item -> {
            Product product = item.getProduct();
            product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
            productRepository.save(product);
        });
        order.setStatus(OrderStatus.CANCELLED);
        return toResponse(orderRepository.save(order));
    }

    private Order findEntityById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Pedido não encontrado com id: " + id));
    }

    private OrderResponse toResponse(Order order) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
                .map(item -> OrderItemResponse.builder()
                        .id(item.getId())
                        .productId(item.getProduct().getId())
                        .productName(item.getProduct().getName())
                        .quantity(item.getQuantity())
                        .unitPrice(item.getUnitPrice())
                        .subtotal(item.getSubtotal())
                        .build())
                .toList();

        return OrderResponse.builder()
                .id(order.getId())
                .userId(order.getUser().getId())
                .userName(order.getUser().getName())
                .status(order.getStatus())
                .total(order.getTotal())
                .createdAt(order.getCreatedAt())
                .deliveryAddress(order.getDeliveryAddress() != null
                        ? addressService.toResponse(order.getDeliveryAddress()) : null)
                .items(itemResponses)
                .build();
    }
}

