<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

< !DOCTYPE html>
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
        <img src="${product.imageUrl}" alt="${product.name}">
    </div>

    <!-- 정보 -->
    <div class="product-info">
        <div class="product-name">${product.name}</div>
        <div class="product-price">₩<c:out value="${product.price}" /></div>
        <div class="product-desc">
            ${product.description}
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
