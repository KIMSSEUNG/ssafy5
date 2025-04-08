package com.ssafy.ssafy_5_Trip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.List;

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
        @RequestPart("content") String content, // Blob이나 file은 part로 받아야 된다.
        @RequestParam(name = "images" , required = false) MultipartFile[] images
    ) {
        log.info(title);

        List<String> uploadedUrls = new ArrayList<>();
        System.out.println(content);

        if (images != null) {
            for (int i = 0; i < images.length; i++) {
                String dummyPath = "</dummy/uploads/image_" + i + ".png>";
                uploadedUrls.add(dummyPath);
            }
        }

        // content 내 __IMAGE_0__, __IMAGE_1__ ... 을 치환
        for (int i = 0; i < uploadedUrls.size(); i++) {
            content = content.replace("__IMAGE_" + i + "__", uploadedUrls.get(i)+"<br>");
        }

        // 결과 로그 출력
        log.info("치환된 content: {}", content);

        return "board"; // board.html을 반환
    }
}