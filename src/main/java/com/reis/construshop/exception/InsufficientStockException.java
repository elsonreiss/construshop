package com.reis.construshop.exception;

public class InsufficientStockException extends RuntimeException {
    public InsufficientStockException(String productName, int available, int requested) {
        super(String.format("Estoque insuficiente para '%s'. Disponível: %d, Solicitado: %d",
                productName, available, requested));
    }
}

