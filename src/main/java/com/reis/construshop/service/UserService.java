package com.reis.construshop.service;

import com.reis.construshop.dto.request.UserRequest;
import com.reis.construshop.dto.response.UserResponse;
import com.reis.construshop.entity.User;
import com.reis.construshop.exception.BusinessException;
import com.reis.construshop.exception.ResourceNotFoundException;
import com.reis.construshop.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public List<UserResponse> findAll() {
        return userRepository.findAll().stream()
                .map(this::toResponse)
                .toList();
    }

    public UserResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    public UserResponse save(UserRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BusinessException("E-mail '" + request.getEmail() + "' já cadastrado.");
        }
        User user = User.builder()
                .name(request.getName())
                .email(request.getEmail())
                .password(request.getPassword()) // em produção: encode com BCrypt
                .phone(request.getPhone())
                .role(request.getRole())
                .build();
        return toResponse(userRepository.save(user));
    }

    public UserResponse update(Long id, UserRequest request) {
        User user = findEntityById(id);
        user.setName(request.getName());
        user.setPhone(request.getPhone());
        user.setRole(request.getRole());
        return toResponse(userRepository.save(user));
    }

    public void delete(Long id) {
        userRepository.delete(findEntityById(id));
    }

    public User findEntityById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado com id: " + id));
    }

    private UserResponse toResponse(User u) {
        return UserResponse.builder()
                .id(u.getId())
                .name(u.getName())
                .email(u.getEmail())
                .phone(u.getPhone())
                .role(u.getRole())
                .build();
    }
}

