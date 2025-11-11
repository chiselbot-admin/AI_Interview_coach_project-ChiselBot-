package com.coach.chiselbot.domain.user.login;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.errors.exception.Exception400;
import com.coach.chiselbot._global.errors.exception.Exception404;
import com.coach.chiselbot.domain.user.User;
import com.coach.chiselbot.domain.user.UserJpaRepository;
import com.coach.chiselbot.domain.user.dto.UserRequestDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class LocalLoginStrategy implements LoginStrategy{

    private final UserJpaRepository userJpaRepository;
    private final PasswordEncoder passwordEncoder;


    @Override
    public User login(UserRequestDTO.Login dto) {
        User user = userJpaRepository.findByEmail(dto.getEmail())
                .orElseThrow(() -> new Exception404(Define.ADMIN_EMAIL_NOT_FOUND));

        if(!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new Exception400(Define.PASSWORD_MISMATCH);
        }

        return user;
    }

    @Override
    public boolean supports(String type) {
        return "Local".equalsIgnoreCase(type);
    }
}
