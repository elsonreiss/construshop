package com.reis.construshop.service;

import com.reis.construshop.dto.request.CartItemRequest;
import com.reis.construshop.dto.response.CartItemResponse;
import com.reis.construshop.dto.response.CartResponse;
import com.reis.construshop.entity.CartItem;
import com.reis.construshop.entity.Product;
import com.reis.construshop.entity.User;
import com.reis.construshop.exception.ResourceNotFoundException;
import com.reis.construshop.repository.CartItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartItemRepository cartItemRepository;
    private final UserService userService;
    private final ProductService productService;

    public CartResponse getCart(Long userId) {
        userService.findEntityById(userId); // validate user exists
        List<CartItem> items = cartItemRepository.findByUserId(userId);
        List<CartItemResponse> itemResponses = items.stream().map(this::toItemResponse).toList();
        double total = itemResponses.stream().mapToDouble(CartItemResponse::getSubtotal).sum();
        return CartResponse.builder()
                .userId(userId)
                .items(itemResponses)
                .total(total)
                .build();
    }

    @Transactional
    public CartResponse addItem(CartItemRequest request) {
        User user = userService.findEntityById(request.getUserId());
        Product product = productService.findEntityById(request.getProductId());

        Optional<CartItem> existing = cartItemRepository
                .findByUserIdAndProductId(request.getUserId(), request.getProductId());

        if (existing.isPresent()) {
            CartItem item = existing.get();
            item.setQuantity(item.getQuantity() + request.getQuantity());
            cartItemRepository.save(item);
        } else {
            CartItem item = CartItem.builder()
                    .user(user)
                    .product(product)
                    .quantity(request.getQuantity())
                    .build();
            cartItemRepository.save(item);
        }
        return getCart(request.getUserId());
    }

    @Transactional
    public CartResponse updateItem(Long cartItemId, Integer quantity) {
        CartItem item = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new ResourceNotFoundException("Item do carrinho não encontrado com id: " + cartItemId));
        if (quantity <= 0) {
            cartItemRepository.delete(item);
        } else {
            item.setQuantity(quantity);
            cartItemRepository.save(item);
        }
        return getCart(item.getUser().getId());
    }

    @Transactional
    public void removeItem(Long cartItemId) {
        CartItem item = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new ResourceNotFoundException("Item do carrinho não encontrado com id: " + cartItemId));
        cartItemRepository.delete(item);
    }

    @Transactional
    public void clearCart(Long userId) {
        cartItemRepository.deleteByUserId(userId);
    }

    private CartItemResponse toItemResponse(CartItem item) {
        return CartItemResponse.builder()
                .id(item.getId())
                .productId(item.getProduct().getId())
                .productName(item.getProduct().getName())
                .unitPrice(item.getProduct().getPrice())
                .quantity(item.getQuantity())
                .subtotal(item.getSubtotal())
                .build();
    }
}

