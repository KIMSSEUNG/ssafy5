<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 목록</title>
  <link href="/css/product/product-list.css" rel="stylesheet" />
</head>
<body>

<h1>상품 목록</h1>

<div class="product-list">
  <c:forEach var="product" items="${products}">
    <a href="/product/detail?id=${product.id}" class="product-card">
      <img src="${product.imageUrl}" alt="상품 이미지">
      <div class="product-name">${product.name}</div>
      <div class="product-price">₩${product.price}</div>
    </a>
  </c:forEach>
</div>

</body>
</html>
