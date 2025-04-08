package com.ssafy.ssafy_5_Trip.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;


@Entity
@Table(name = "payment")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Payment {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY) @JoinColumn(name = "order_id")
    private Order order;

    private String impUid;      // 아임포트 거래 ID

    private String merchantUid; // 고유 주문번호

    private int paidAmount;

    private String payMethod;

    private String status; // 예: paid, cancelled

    private LocalDateTime paidAt;

    @PrePersist
    public void onPay() {
        this.paidAt = LocalDateTime.now();
    }
}
