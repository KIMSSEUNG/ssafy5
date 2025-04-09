document.querySelector(".btn-cart").addEventListener("click", () => {
    const quantity = document.querySelector(".quantity").value;
    const productId = "${product.id}";

    fetch("/wishlist/add", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ productId, quantity })
    })
        .then(res => {
            if (res.ok) {
                alert("장바구니에 담겼습니다!");
            } else if (res.status === 409) {
                alert("이미 장바구니에 담긴 상품입니다.");
            } else {
                alert("장바구니 담기 실패");
            }
        });
});