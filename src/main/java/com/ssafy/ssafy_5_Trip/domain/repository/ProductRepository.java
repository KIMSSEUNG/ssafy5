package com.ssafy.ssafy_5_Trip.domain.repository;

import com.ssafy.ssafy_5_Trip.domain.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
