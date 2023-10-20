package com.eschool.backend.Notification;

import com.eschool.backend.validation.Validation;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class MailSender {
    private final JavaMailSender emailSender ;

    private final SpringTemplateEngine templateEngine ;
    private final NotificationBuilder notificationBuilder ;

    @Value("${spring.mail.username}")
    private String username;


    public void sendMessage(String email,String code,String emailTemplate) throws MessagingException {
        String content = notificationBuilder.build(code,emailTemplate);
        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message,
                MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                StandardCharsets.UTF_8.name());
        Map<String, Object> properties = new HashMap<>();
        properties.put("code", code);
        Context context = new Context();
        context.setVariables(properties);
        helper.setFrom(username);
        helper.setTo(email);
        helper.setSubject("Création du Compte");
        helper.setText(content,true);
       // ClassPathResource resource = new ClassPathResource("/static/images/logo.png");
        //helper.addInline("logo", resource);
        //String html = templateEngine.process("activation-email.html",context);
        //helper.setText(html, true);
        emailSender.send(message);
    }
}
