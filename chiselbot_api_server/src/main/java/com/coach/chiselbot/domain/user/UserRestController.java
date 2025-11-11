package com.coach.chiselbot.domain.user;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.config.jwt.JwtTokenProvider;
import com.coach.chiselbot._global.dto.CommonResponseDto;
import com.coach.chiselbot.domain.user.dto.UserRequestDTO;
import com.coach.chiselbot.domain.user.dto.UserResponseDTO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RequestMapping("/api/users")
@RestController
@RequiredArgsConstructor
public class UserRestController {

    private final UserService userService;
    private final JwtTokenProvider jwtTokenProvider;

    /**
     * 회원가입 API
     * POST/api/users/signup
     */
    @PostMapping("/signup")
    public ResponseEntity<CommonResponseDto<?>> signup(@Valid @RequestBody UserRequestDTO.SignUp dto) {

        userService.signUp(dto);
        return ResponseEntity.ok(CommonResponseDto.success(null, Define.USER_REGISTED));
    }

    /**
     * 로그인 API
     * POST/api/users/login/{type}
     */
    @PostMapping("/login/{type}")
    public ResponseEntity<CommonResponseDto<?>> login(@PathVariable String type,
                                                      @Valid @RequestBody UserRequestDTO.Login dto) {
        User user = userService.login(type, dto);

        String token = jwtTokenProvider.createToken(user);

        UserResponseDTO response = UserResponseDTO.builder()
                .userId(String.valueOf(user.getId())) // User 엔티티의 ID 사용
                .name(user.getName()) // User 엔티티의 Name 사용
                .token(token)
                .build();

        return ResponseEntity.ok(CommonResponseDto.success(response, Define.LOGIN_SUCCESS));
    }

    /**
     * 회원정보 수정 API
     * Patch/api/users/update
     */
    @PatchMapping("/update")
    public ResponseEntity<CommonResponseDto<?>> updateMe(
            @RequestAttribute("userEmail") String userEmail,
            @RequestBody UserRequestDTO.Update dto // @Valid 제거
    ) {
        userService.update(userEmail, dto);
        return ResponseEntity.ok(CommonResponseDto.success(null, Define.USER_INFO_MODIFY));
    }

    /**
     * 로그아웃 API
     * POST/api/users/api
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        return ResponseEntity.ok(CommonResponseDto.success(null, Define.LOGOUT_SUCCESS));
    }

    @GetMapping("/{id}")
    public ResponseEntity<CommonResponseDto<?>> findOne(@PathVariable String userEmail) {
        return ResponseEntity.ok(CommonResponseDto.success(userService.findOne(userEmail), Define.USER_INFO_SEARCH_SUCCESS));
    }

	/**
	 * 내 정보 조회 API (JWT 기반)
	 * GET /api/users/me
	 */
	@GetMapping("/me")
	public ResponseEntity<CommonResponseDto<?>> getMyProfile(
			@RequestAttribute("userEmail") String userEmail
	) {
		Map<String, Object> user = userService.findOne(userEmail);
		return ResponseEntity.ok(CommonResponseDto.success(user, Define.USER_INFO_SEARCH_SUCCESS));
	}

	/**
	 * 이메일 찾기 API (이름 기반)
	 * POST /api/users/find-email
	 */
	@PostMapping("/find-email")
	public ResponseEntity<CommonResponseDto<?>> findEmail(
			@Valid @RequestBody UserRequestDTO.FindEmail dto
	) {
		String maskedEmail = userService.findEmailByName(dto.getName());
		return ResponseEntity.ok(CommonResponseDto.success(
				Map.of("email", maskedEmail),
				Define.EMAIL_FOUND
		));
	}

	/**
	 * 비밀번호 찾기용 인증번호 발송
	 * POST /api/users/find-password
	 */
	@PostMapping("/find-password")
	public ResponseEntity<CommonResponseDto<?>> sendPasswordResetCode(
			@Valid @RequestBody UserRequestDTO.FindPassword dto
	) {
		userService.sendPasswordResetEmail(dto.getEmail());
		return ResponseEntity.ok(CommonResponseDto.success(
				null,
				Define.EMAIL_PASSWORD_RESET_AUTH_SEND
		));
	}


	/**
	 * 비밀번호 재설정 API
	 * POST /api/users/reset-password
	 */
	@PostMapping("/reset-password")
	public ResponseEntity<CommonResponseDto<?>> resetPassword(
			@Valid @RequestBody UserRequestDTO.ResetPassword dto
	) {
		userService.resetPassword(dto);
		return ResponseEntity.ok(CommonResponseDto.success(null, Define.USER_PASSWORD_MODIFY));
	}

}