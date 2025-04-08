package com.ssafy.ssafy_5_Trip.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;


@Entity
@Table(name = "orders")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Order {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "user_id")
    private User user;

    private String recipient;

    private String phone;

    private String address;

    private int totalAmount;

    private String payMethod;

    private String status; // 예: PAYMENT_PENDING, COMPLETE 등

    private LocalDateTime orderedAt;

    @PrePersist
    public void onOrder() {
        this.orderedAt = LocalDateTime.now();
    }
}
