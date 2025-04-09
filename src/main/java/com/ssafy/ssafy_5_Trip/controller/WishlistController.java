package com.ssafy.ssafy_5_Trip.controller;

import com.ssafy.ssafy_5_Trip.domain.entity.Product;
import com.ssafy.ssafy_5_Trip.domain.entity.User;
import com.ssafy.ssafy_5_Trip.domain.entity.Wishlist;
import com.ssafy.ssafy_5_Trip.domain.repository.ProductRepository;
import com.ssafy.ssafy_5_Trip.domain.repository.WishlistRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/wishlist")
@RequiredArgsConstructor
public class WishlistController {
    private final WishlistRepository wishlistRepository;
    private final ProductRepository productRepository;

    @PostMapping("/add")
    public ResponseEntity<?> addToWishlist(HttpServletRequest request, @RequestBody Map<String, Object> payload) {
        // 로그인 유저 가져오기
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 필요");
        }

        // JSON 파라미터에서 값 꺼내기
        Long productId = Long.valueOf(payload.get("productId").toString());
        int quantity = Integer.parseInt(payload.get("quantity").toString());

        Product product = productRepository.findById(productId).orElse(null);
        if (product == null) {
            return ResponseEntity.badRequest().body("상품이 존재하지 않습니다.");
        }

        // 이미 담겨 있으면 중복 방지
        if (wishlistRepository.existsByUserAndProduct(loginUser, product)) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 장바구니에 담긴 상품입니다.");
        }

        Wishlist wishlist = Wishlist.builder()
                .user(loginUser)
                .product(product)
                .quantity(quantity)
                .build();

        wishlistRepository.save(wishlist);
        return ResponseEntity.ok("장바구니에 담겼습니다.");
    }

}
