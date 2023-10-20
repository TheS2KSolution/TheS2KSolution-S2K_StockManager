package com.eschool.backend.Notification;

import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
@Component
public class NotificationBuilder {
    private final TemplateEngine templateEngine;

    public NotificationBuilder(TemplateEngine templateEngine) {
        this.templateEngine = templateEngine;
    }

    public String build(String code, String emailTemplate) {
        Context context = new Context();
        context.setVariable("code", code);
        return templateEngine.process(emailTemplate, context);
    }
}
