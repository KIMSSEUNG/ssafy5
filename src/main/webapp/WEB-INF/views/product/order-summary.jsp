<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 요약</title>
    <link href="/css/product/order-summary.css" rel="stylesheet" />

</head>
<body>

<h1>주문 요약</h1>

<!-- 상품 목록 -->
<h2>주문한 상품</h2>
<table>
    <thead>
    <tr>
        <th>상품 이미지</th>
        <th>상품명</th>
        <th>수량</th>
        <th>단가</th>
        <th>총 가격</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><img src="https://via.placeholder.com/60" class="product-thumb" alt="상품 1"></td>
        <td>샘플 상품 A</td>
        <td>2</td>
        <td>₩19,900</td>
        <td>₩39,800</td>
    </tr>
    <tr>
        <td><img src="https://via.placeholder.com/60" class="product-thumb" alt="상품 2"></td>
        <td>샘플 상품 B</td>
        <td>1</td>
        <td>₩29,900</td>
        <td>₩29,900</td>
    </tr>
    </tbody>
</table>

<!-- 배송 정보 -->
<h2>배송지 정보</h2>
<div class="delivery-info">
    <div><strong>받는 분:</strong> 홍길동</div>
    <div><strong>주소:</strong> 서울특별시 강남구 테헤란로 123</div>
    <div><strong>연락처:</strong> 010-1234-5678</div>
    <div><strong>배송 요청사항:</strong> 문 앞에 놓아주세요.</div>
</div>

<!-- 금액 합계 -->
<div class="total-section">
    <div>상품 합계: ₩69,700</div>
    <div>배송비: ₩3,000</div>
    <div><strong>총 결제 금액: ₩72,700</strong></div>
</div>

<!-- 결제 버튼 -->
<form action="payment.jsp" method="POST">
    <button type="submit" class="pay-btn">결제하기</button>
</form>

</body>
</html>
