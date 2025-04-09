<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="/css/product/product-list.css" rel="stylesheet" />
</head>
<body>

<div class="container py-4">
  <h2 class="mb-4">상품 목록</h2>
  <div class="row g-4">
    <c:forEach var="product" items="${products}">
      <div class="col-6 col-md-3">
        <a href="/product/detail?id=${product.id}" class="product-card d-block">
          <div class="card h-100 border-0">
            <img src="${product.imageUrl}" class="product-image card-img-top" alt="${product.name}">
            <div class="card-body text-center">
              <div class="product-name">${product.name}</div>
              <div class="product-price">₩${product.price}</div>
              <div class="product-desc">${product.description}</div>
            </div>
          </div>
        </a>
      </div>
    </c:forEach>
  </div>
</div>

</body>
</html>
