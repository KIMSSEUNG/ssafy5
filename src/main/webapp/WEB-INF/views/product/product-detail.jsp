<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 상세 페이지</title>
    <link href="/css/product/product-detail.css" rel="stylesheet" />

</head>
<body>

<div class="product-container">
    <!-- 이미지 -->
    <div class="product-image">
        <img src="https://via.placeholder.com/400x300" alt="제품 이미지">
    </div>

    <!-- 정보 -->
    <div class="product-info">
        <div class="product-name">샘플 상품 A</div>
        <div class="product-price">₩19,900</div>
        <div class="product-desc">
            이 제품은 샘플로 작성된 제품입니다. 실제 데이터는 JSP와 연동 시 출력됩니다.
            다양한 기능과 깔끔한 디자인으로 구성되어 있습니다.
        </div>

        <div>
            수량:
            <input type="number" class="quantity" value="1" min="1">
        </div>

        <div class="actions">
            <button class="btn-cart">장바구니 담기</button>
            <button class="btn-buy">바로 구매</button>
        </div>
    </div>
</div>

</body>
</html>
