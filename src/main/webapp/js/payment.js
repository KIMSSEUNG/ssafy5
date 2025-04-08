function getPgValue(payMethod) {
    switch (payMethod) {
        case "카카오페이": return "kakaopay.TC0ONETIME";
        case "네이버페이": return "naverpay";
        default: return "html5_inicis.INIpayTest";
    }
}

function requestPay(totalAmount, impCode) {
    const form = document.getElementById('orderForm');
    const formData = new FormData(form);

    const payMethod = formData.get("payMethod");
    const pg = getPgValue(payMethod);

    const IMP = window.IMP;
    IMP.init(impCode);

    IMP.request_pay({
        pg: pg,
        pay_method: "card",
        merchant_uid: "order_" + new Date().getTime(),
        name: "주문 상품",
        amount: totalAmount,
        buyer_name: formData.get("recipient"),
        buyer_tel: formData.get("phone"),
        buyer_addr: formData.get("address"),
    }, function (rsp) {
        if (rsp.success) {
            const orderForm = document.createElement("form");
            orderForm.method = "POST";
            orderForm.action = "/order/pay";

            // 기존 form 데이터 복사
            for (let [key, value] of formData.entries()) {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = key;
                input.value = value;
                orderForm.appendChild(input);
            }

            // 결제 결과 정보 추가
            const impInput = document.createElement("input");
            impInput.type = "hidden";
            impInput.name = "imp_uid";
            impInput.value = rsp.imp_uid;
            orderForm.appendChild(impInput);

            const merchantInput = document.createElement("input");
            merchantInput.type = "hidden";
            merchantInput.name = "merchant_uid";
            merchantInput.value = rsp.merchant_uid;
            orderForm.appendChild(merchantInput);

            document.body.appendChild(orderForm);
            orderForm.submit();
        } else {
            alert("결제 실패: " + rsp.error_msg);
        }
    });
}
