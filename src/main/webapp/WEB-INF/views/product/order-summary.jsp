<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int price = 100;
    int shippingFee = 0;
    int discount = 0;
    int total = price + shippingFee - discount;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 / 결제</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/product/order-summary.css" rel="stylesheet" />
</head>
<body>

<!-- 사용자 입력 form (서버 전송은 JS에서 수행) -->
<form id="orderForm">
    <div class="container-main d-flex">
        <!-- 왼쪽 패널 -->
        <div class="left-panel flex-fill me-4">
            <!-- 배송지 정보 -->
            <div class="card mb-4">
                <div class="card-header">배송지 정보</div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label">받는 사람</label>
                        <input type="text" class="form-control" name="recipient" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" class="form-control" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">전화번호</label>
                        <input type="text" class="form-control" name="phone" required>
                    </div>
                </div>
            </div>

            <!-- 결제 수단 -->
            <div class="card mb-5">
                <div class="card-header">결제 수단</div>
                <div class="card-body">
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="payMethod" value="카카오페이" required>
                        <label class="form-check-label">카카오페이</label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="payMethod" value="네이버페이">
                        <label class="form-check-label">네이버페이</label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="payMethod" value="일반 카드결제">
                        <label class="form-check-label">일반 카드결제</label>
                    </div>
                </div>
            </div>
        </div>

        <!-- 오른쪽 패널 -->
        <div class="right-panel" style="width: 300px;">
            <div class="order-summary shadow-sm p-3">
                <h5 class="mb-3">결제 상세</h5>
                <div class="d-flex justify-content-between mb-2">
                    <span>상품 금액</span>
                    <span><%= price %>원</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>배송비</span>
                    <span><%= shippingFee %>원</span>
                </div>
                <div class="d-flex justify-content-between text-success mb-2">
                    <span>할인</span>
                    <span>-<%= discount %>원</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold">
                    <span>총 결제금액</span>
                    <span><%= total %>원</span>
                </div>
            </div>
        </div>
    </div>

    <!-- 결제 금액 관련 숨겨진 필드 -->
    <input type="hidden" name="price" value="<%= price %>">
    <input type="hidden" name="shippingFee" value="<%= shippingFee %>">
    <input type="hidden" name="discount" value="<%= discount %>">
    <input type="hidden" name="total" value="<%= total %>">
</form>

<!-- 하단 결제 버튼 -->
<div class="fixed-bottom-bar shadow-sm d-flex justify-content-between align-items-center p-3 bg-white border-top">
    <strong>총 결제금액: <%= total %>원</strong>
    <button type="button" class="btn btn-success px-4" onclick="requestPay(totalAmount, impCode)">결제하기</button>
</div>

<!-- 아임포트 스크립트 -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="/js/payment.js"></script>
<!-- 총 결제금액 및 impCode 전달 -->
<script>
    const totalAmount = <%= total %>;
    const impCode = ${impCode};
</script>

<!-- 외부 스크립트 -->


</body>
</html>
