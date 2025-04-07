package com.ssafy.ssafy_5_Trip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
    
    // 로그인 페이지 요청
    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }

    // 회원가입 페이지 요청
    @GetMapping("/signup")
    public String signUpForm() {
        return "user/signup";
    }
}
