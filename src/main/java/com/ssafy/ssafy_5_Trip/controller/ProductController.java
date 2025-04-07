package com.ssafy.ssafy_5_Trip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {

    @GetMapping("/list")
    public String productList() {
        return "/product-list"; // -> /WEB-INF/views/product-list.jsp 로 forward 됨
    }
}
