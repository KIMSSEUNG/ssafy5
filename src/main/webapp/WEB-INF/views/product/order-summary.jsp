<%@ page import="org.json.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String jsonStr = request.getParameter("orderItemsJson");
    int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));

    // 간단한 계산식
    int price = totalPrice;
    int discount = 0;
    int shippingFee = (price >= 50000) ? 0 : 3000;
    int total = price - discount + shippingFee;

    JSONArray orderItems = new JSONArray(jsonStr);
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

<form id="orderForm">
    <div class="container-main d-flex">
        <!-- 왼쪽 영역 -->
        <div class="left-panel flex-grow-1 me-4">
            <!-- 배송지 -->
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

        <!-- 오른쪽 영역 -->
        <div class="right-panel" style="width: 300px;">
            <div class="order-summary">
                <h5 class="mb-4">결제 예정 금액</h5>
                <div class="d-flex justify-content-between mb-2">
                    <span>총 상품금액</span>
                    <span class="price-value"><%= price %>원</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>총 할인금액</span>
                    <span class="price-value text-success">-<%= discount %>원</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>총 배송비</span>
                    <span class="price-value"><%= shippingFee %>원</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between total-row mt-3">
                    <span>최종 결제 금액</span>
                    <span class="price-value"><%= total %>원</span>
                </div>
            </div>
        </div>
    </div>

    <!-- 숨겨진 필드 -->
    <input type="hidden" name="price" value="<%= price %>">
    <input type="hidden" name="shippingFee" value="<%= shippingFee %>">
    <input type="hidden" name="discount" value="<%= discount %>">
    <input type="hidden" name="total" value="<%= total %>">
    <input type="hidden" name="orderItemsJson" value='<%= jsonStr %>'>
    <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
</form>

<!-- 하단 결제 버튼 -->
<div class="fixed-bottom-bar">
    <strong style="font-size: 1.1rem;">총 결제금액: <%= total %>원</strong>
    <button type="button" class="btn btn-checkout" onclick="requestPay(totalAmount, impCode)">결제하기</button>
</div>

<!-- 아임포트 -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
    const totalAmount = <%= total %>;
    const impCode = '${impCode}'; // impCode는 서버에서 전달되어야 합니다.
</script>
<script src="/js/payment.js"></script>

</body>
</html>
