package com.ssafy.ssafy_5_Trip.controller;

import aj.org.objectweb.asm.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.ssafy_5_Trip.domain.entity.Product;
import com.ssafy.ssafy_5_Trip.domain.entity.User;
import com.ssafy.ssafy_5_Trip.domain.entity.Wishlist;
import com.ssafy.ssafy_5_Trip.dto.OrderItemDto;
import com.ssafy.ssafy_5_Trip.service.ProductService;
import com.ssafy.ssafy_5_Trip.service.WishlistService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
    private final ProductService productService;
    private final WishlistService wishlistService;
    @Value("${imp.code}")
    private String impCode;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String apiSecret;

    @GetMapping("/list")
    public String productList(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "product/product-list";
    }

//    @PostMapping("/summary")
//    public String orderSummary(@RequestParam("orderItemsJson") String orderItemsJson,
//                               @RequestParam("totalPrice") int totalPrice,
//                               Model model) {
//        try {
//            ObjectMapper mapper = new ObjectMapper();
//            List<OrderItemDto> orderItems = mapper.readValue(orderItemsJson, new TypeReference<List<OrderItemDto>>() {});
//
//            int shippingFee = (totalPrice >= 50000) ? 0 : 3000;
//            int discount = 0;
//            int finalTotal = totalPrice - discount + shippingFee;
//
//            model.addAttribute("orderItems", orderItems);
//            model.addAttribute("totalPrice", totalPrice);
//            model.addAttribute("shippingFee", shippingFee);
//            model.addAttribute("discount", discount);
//            model.addAttribute("finalTotal", finalTotal);
//
//            return "product/order-summary";
//        } catch (JSONException e) {
//            // 오류 처리
//            model.addAttribute("error", "잘못된 주문 데이터입니다.");
//            return "error";
//        }
//    }


    @GetMapping("/detail")
    public String productDetail(HttpServletRequest request, @RequestParam("id") Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        request.getSession().setAttribute("loginUser","test");
        return "product/product-detail";
    }

    @PostMapping("/pay")
    public String pay() {
        return "product/order-summary";
    }

    @GetMapping("/cart")
    public String cart(HttpSession session, Model model) {
//        User loginUser = (User) session.getAttribute("loginUser");
        List<Wishlist> wishlists = wishlistService.findAllByUserId(Long.valueOf("1"));
        model.addAttribute("wishlists", wishlists);

        return "product/cart-list";
    }
}
