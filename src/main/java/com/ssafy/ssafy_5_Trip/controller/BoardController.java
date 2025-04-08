package com.ssafy.ssafy_5_Trip.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
@Slf4j
public class BoardController {

    @Value("${file.upload.path}")
    private String uploadDir;
    @Value("${file.access.url}")
    private String accessUrl;

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

        List<String> uploadedUrls = new ArrayList<>();

        try {
            Path uploadPath = Paths.get(uploadDir);
            // uploads 폴더가 없으면 생성
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            if (images != null) {
                for (int i = 0; i < images.length; i++) {
                    MultipartFile image = images[i];
                    String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
                    Path targetPath = uploadPath.resolve(fileName); //경로 + 파일명 결합 = 실제 저장할 위치

                    image.transferTo(targetPath.toFile()); //사용자가 업로드한 이미지 파일을 해당 경로에 저장

                    String imageUrl = accessUrl + fileName;
                    uploadedUrls.add(imageUrl); // Content에 들어갈 토큰을 uploadUrls명으로 바꿔주기 위해서 저장
                }
            }

            // content의 토큰을 이미지 URL로 치환
            for (int i = 0; i < uploadedUrls.size(); i++) {
                content = content.replace("__IMAGE_" + i + "__", "<br><img src='" + uploadedUrls.get(i) + "'><br>");
            }

            return "redirect:/board";

        } catch (IOException e) {
            throw new RuntimeException("이미지 저장 실패", e);
        }

        // 결과 로그 출력


    }
}