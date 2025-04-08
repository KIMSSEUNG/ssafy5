package com.ssafy.ssafy_5_Trip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
@Slf4j
public class BoardController {

    @GetMapping("")
    public String boardPage() {
        log.info("board GET");
        return "board"; // board.html을 반환
    }

    @PostMapping("/write")
    public String boardWrite(
        @RequestParam("title") String title,
        @RequestParam("content") String content,
        @RequestParam(name = "images" , required = false) MultipartFile[] images
    ) {
        log.info(title);
        log.info(content);
        for (MultipartFile file : images) {
            log.info("파일 이름: " + file.getOriginalFilename());
        }
        return "board"; // board.html을 반환
    }
}