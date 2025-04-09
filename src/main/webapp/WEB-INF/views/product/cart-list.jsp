<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/product/cart-list.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- 전체 선택 -->
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="selectAll">
        <label class="form-check-label fw-bold" for="selectAll">전체 선택</label>
        <button class="btn btn-link btn-sm text-decoration-none text-secondary float-end">선택삭제</button>
    </div>

    <!-- 위시리스트 항목 -->
    <c:forEach var="item" items="${wishlists}">
        <div class="bg-white p-3 rounded shadow-sm mb-4">
            <div class="form-check d-flex align-items-start">
                <input class="form-check-input mt-1 me-3 itemCheckbox"
                       type="checkbox"
                       data-productid="${item.product.id}"
                       data-name="${item.product.name}"
                       data-price="${item.product.price}"
                       data-quantity="${item.quantity}">

                <div class="d-flex w-100">
                    <img src="${item.product.imageUrl}" class="product-img me-3" alt="${item.product.name}">

                    <div class="flex-grow-1">
                        <div class="fw-bold">${item.product.name}</div>
                        <div class="text-muted">${item.product.description}</div>
                        <div class="mt-2 small">
                            수량: <strong>${item.quantity}개</strong> |
                            <a href="#" class="option-link">옵션/수량 변경</a>
                        </div>
                    </div>

                    <div class="text-end">
                        <div class="fw-bold fs-5 text-dark">
                                ${item.product.price}원
                        </div>
                        <button class="btn btn-outline-dark btn-sm mt-2">바로구매</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- 금액 요약 -->
    <div class="bg-white p-3 rounded shadow-sm mb-5">
        <div class="mb-2">💳 결제 예정 금액</div>
        <div class="d-flex justify-content-between small text-muted">
            <div>총 상품금액</div><div id="totalPrice">0원</div>
        </div>
        <hr>
        <div class="d-flex justify-content-between fs-5 fw-bold">
            <div>최종 결제 금액</div>
            <div class="text-primary" id="finalAmount">0원</div>
        </div>
    </div>
</div>

<!-- 하단 고정 주문 바 -->
<div class="fixed-bottom-bar">
    <div>총 <span id="selectedCount">0</span>개 <strong id="selectedTotal">0원</strong></div>
    <button class="btn btn-light text-dark fw-bold px-4" onclick="proceedToOrder()">주문하기</button>
</div>

<form id="orderSubmitForm" method="post" action="${pageContext.request.contextPath}/product/summary">
    <input type="hidden" name="orderItemsJson" id="selectedItemsJson">
    <input type="hidden" name="totalPrice" id="totalPriceHidden">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function updateTotal() {
        let totalPrice = 0;
        let totalQuantity = 0;

        $(".itemCheckbox:checked").each(function () {
            const price = parseInt($(this).data("price")) || 0;
            const quantity = parseInt($(this).data("quantity")) || 1;

            totalPrice += price * quantity;
            totalQuantity += quantity;
        });

        $("#totalPrice").text(totalPrice.toLocaleString() + "원");
        $("#finalAmount").text(totalPrice.toLocaleString() + "원");
        $("#selectedTotal").text(totalPrice.toLocaleString() + "원");
        $("#selectedCount").text(totalQuantity);
    }

    function proceedToOrder() {
        const selectedItems = [];

        $(".itemCheckbox:checked").each(function () {
            selectedItems.push({
                productId: $(this).data("productid"),
                productName: $(this).data("name"),
                quantity: $(this).data("quantity"),
                price: $(this).data("price")
            });
        });

        if (selectedItems.length === 0) {
            alert("상품을 선택해주세요.");
            return;
        }

        const total = selectedItems.reduce((sum, item) => sum + item.price * item.quantity, 0);

        $("#selectedItemsJson").val(JSON.stringify(selectedItems));
        $("#totalPriceHidden").val(total);
        $("#orderSubmitForm").submit();
    }

    $(document).ready(function () {
        $("#selectAll").on("change", function () {
            $(".itemCheckbox").prop("checked", $(this).prop("checked"));
            updateTotal();
        });

        $(".itemCheckbox").on("change", function () {
            const allChecked = $(".itemCheckbox").length === $(".itemCheckbox:checked").length;
            $("#selectAll").prop("checked", allChecked);
            updateTotal();
        });

        updateTotal(); // 초기 상태 업데이트
    });
</script>

</body>
</html>
