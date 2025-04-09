package com.ssafy.ssafy_5_Trip.service;

import com.ssafy.ssafy_5_Trip.domain.entity.Wishlist;
import com.ssafy.ssafy_5_Trip.domain.repository.WishlistRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WishlistService {
    private final WishlistRepository wishlistRepository;

    public List<Wishlist> findAllByUserId(Long userId) {
        return wishlistRepository.findByUserId(userId);
    }
}
