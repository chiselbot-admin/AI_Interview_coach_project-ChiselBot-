package com.coach.chiselbot.domain.notification;

import com.coach.chiselbot._global.common.Define;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class NotificationSenderFactory {

    private final List<NotificationSender> senderList;

    public NotificationSender findSender(String type) {

        for (NotificationSender sender : senderList) {
            if (sender.supports(type)) {
                return sender;
            }
        }

        throw new IllegalArgumentException(Define.NOT_SUPPORT_NOTI_TYPE +" : " + type);
    }


}
