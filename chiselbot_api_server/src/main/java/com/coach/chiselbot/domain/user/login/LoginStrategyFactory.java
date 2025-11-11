package com.coach.chiselbot.domain.user.login;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.errors.exception.Exception400;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@RequiredArgsConstructor
@Component
public class LoginStrategyFactory {

    private final List<LoginStrategy> strategies;

    public LoginStrategy findStrategy(String type) {

        for(LoginStrategy strategy : strategies) {
            if (strategy.supports(type)) {
                return strategy;
            }
        }

        throw new Exception400(Define.NOT_SUPPORT_LOGIN_TYPE);

    }
}
