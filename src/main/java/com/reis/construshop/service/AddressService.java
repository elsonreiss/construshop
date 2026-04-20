package com.reis.construshop.service;

import com.reis.construshop.dto.request.AddressRequest;
import com.reis.construshop.dto.response.AddressResponse;
import com.reis.construshop.entity.Address;
import com.reis.construshop.entity.User;
import com.reis.construshop.exception.ResourceNotFoundException;
import com.reis.construshop.repository.AddressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AddressService {

    private final AddressRepository addressRepository;
    private final UserService userService;

    public List<AddressResponse> findByUser(Long userId) {
        return addressRepository.findByUserId(userId).stream()
                .map(this::toResponse)
                .toList();
    }

    public AddressResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    public AddressResponse save(AddressRequest request) {
        User user = userService.findEntityById(request.getUserId());
        Address address = Address.builder()
                .street(request.getStreet())
                .number(request.getNumber())
                .complement(request.getComplement())
                .neighborhood(request.getNeighborhood())
                .city(request.getCity())
                .state(request.getState())
                .zipCode(request.getZipCode())
                .user(user)
                .build();
        return toResponse(addressRepository.save(address));
    }

    public AddressResponse update(Long id, AddressRequest request) {
        Address address = findEntityById(id);
        address.setStreet(request.getStreet());
        address.setNumber(request.getNumber());
        address.setComplement(request.getComplement());
        address.setNeighborhood(request.getNeighborhood());
        address.setCity(request.getCity());
        address.setState(request.getState());
        address.setZipCode(request.getZipCode());
        return toResponse(addressRepository.save(address));
    }

    public void delete(Long id) {
        addressRepository.delete(findEntityById(id));
    }

    public Address findEntityById(Long id) {
        return addressRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Endereço não encontrado com id: " + id));
    }

    public AddressResponse toResponse(Address a) {
        return AddressResponse.builder()
                .id(a.getId())
                .street(a.getStreet())
                .number(a.getNumber())
                .complement(a.getComplement())
                .neighborhood(a.getNeighborhood())
                .city(a.getCity())
                .state(a.getState())
                .zipCode(a.getZipCode())
                .build();
    }
}

