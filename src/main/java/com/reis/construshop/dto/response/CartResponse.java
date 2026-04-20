package com.reis.construshop.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class CartResponse {
    private Long userId;
    private List<CartItemResponse> items;
    private Double total;
}

