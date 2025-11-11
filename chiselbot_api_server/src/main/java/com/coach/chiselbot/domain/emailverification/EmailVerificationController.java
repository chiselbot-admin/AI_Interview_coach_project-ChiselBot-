package com.coach.chiselbot.domain.emailverification;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.dto.CommonResponseDto;
import com.coach.chiselbot.domain.user.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class EmailVerificationController {

    private final EmailVerificationService service;
    private final UserJpaRepository userJpaRepository;


    @PostMapping("/email/send")
    public ResponseEntity<CommonResponseDto<?>> send(@RequestBody Map<String, String> body) {
        String email = body.get("email");
        if (email == null || email.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(CommonResponseDto.error(Define.EMAIL_REQUIRED));
        }
        String normalized = email.trim().toLowerCase();
        if (userJpaRepository.existsByEmail(normalized)) {

            return ResponseEntity.status(409).body(CommonResponseDto.error(Define.EMAIL_ALREADY_REGISTED));
        }
        service.sendCode(normalized);
        return ResponseEntity.ok(CommonResponseDto.success(null, Define.EMAIL_CODE_SEND));
    }

    @PostMapping("/email/verify")
    public ResponseEntity<CommonResponseDto<?>> verify(@RequestBody Map<String, String> body) {
        String email = body.get("email");
        String code = body.get("code");
        if (email == null || code == null) {
            return ResponseEntity.badRequest().body(CommonResponseDto.error(Define.EMAIL_AND_CODE_REQUIRED));
        }
        boolean ok = service.verifyCode(email, code);
        if (!ok) {
            return ResponseEntity.badRequest().body(CommonResponseDto.error(Define.EMAIL_AUTH_FAIL));
        }
        return ResponseEntity.ok(CommonResponseDto.success(null, Define.EMAIL_AUTH_SUCCESS));
    }
}
