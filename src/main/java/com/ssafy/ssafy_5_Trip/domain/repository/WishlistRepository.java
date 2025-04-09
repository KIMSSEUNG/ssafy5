package com.ssafy.ssafy_5_Trip.domain.repository;

import com.ssafy.ssafy_5_Trip.domain.entity.Product;
import com.ssafy.ssafy_5_Trip.domain.entity.User;
import com.ssafy.ssafy_5_Trip.domain.entity.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    boolean existsByUserAndProduct(User user, Product product);
    List<Wishlist> findByUserId(Long userId); // user_id 기반 조회

}
