package com.ssafy.ssafy_5_Trip.controller;

import com.ssafy.ssafy_5_Trip.domain.entity.Product;
import com.ssafy.ssafy_5_Trip.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
    private final ProductService productService;

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

    @GetMapping("/ordersummary")
    public String orderSummary(Model model) {
        model.addAttribute("impCode", impCode);
        return "product/order-summary";
    }

    @GetMapping("/detail")
    public String productDetail(@RequestParam("id") Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product/product-detail";
    }

    @PostMapping("/pay")
    public String pay() {
        return "product/order-summary";
    }
}
