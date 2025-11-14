package com.coach.chiselbot.domain.notification;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailNotificationSender implements  NotificationSender{

    private final JavaMailSender mailSender;

    @Override
    public void send(NotifyCommand cmd) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(cmd.getTo());
        String subject = ( cmd.getSubject() != null ) ? cmd.getSubject() : "[No Subject]";
        msg.setSubject(subject);
        msg.setText(cmd.getBody());
        this.mailSender.send(msg);

    }

    @Override
    public boolean supports(String type) {
        return "EMAIL".equalsIgnoreCase(type);
    }
}