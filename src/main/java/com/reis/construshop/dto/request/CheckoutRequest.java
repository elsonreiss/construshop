package com.reis.construshop.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CheckoutRequest {

    @NotNull(message = "Usuário é obrigatório")
    private Long userId;

    @NotNull(message = "Endereço de entrega é obrigatório")
    private Long addressId;
}

