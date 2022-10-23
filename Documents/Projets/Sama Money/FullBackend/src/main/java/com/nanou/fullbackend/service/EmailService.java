package com.nanou.fullbackend.service;

import com.sun.mail.smtp.SMTPTransport;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;

import static com.nanou.fullbackend.constant.EmailConstant.*;
import static javax.mail.Message.RecipientType.CC;
@Service
public class EmailService {
    public void  sensNewPasswordEmail(String firstName,String password,String email) throws MessagingException {
        Message message = createEmail(firstName,password,email);
        SMTPTransport smtpTransport= (SMTPTransport) getEmailSession().getTransport(SIMPLE_MAIL_TRANSFER_PROTOCOL);
        smtpTransport.connect(GMAIL_SMTP_SERVER,USERNAME,PASSWORD);
        smtpTransport.sendMessage(message,message.getAllRecipients());
        smtpTransport.close();;
    }
    private Message createEmail(String firstname,String password,String email) throws MessagingException {
        Message message = new MimeMessage(getEmailSession());
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(email,false));
        message.setRecipients(CC,InternetAddress.parse(CC_EMAIL,false));
        message.setSubject(EMAIL_SUBJECT);
        message.setText("Hello "+ firstname + ",\n\n votre nouveau mot de passe est : "+ password +"\n\n the Support Team");
        message.setSentDate(new Date());
        message.saveChanges();
        return message;
    }
    private Session getEmailSession(){
        Properties properties = System.getProperties();
        properties.put(SMTP_HOST,GMAIL_SMTP_SERVER);
        properties.put(SMTP_Auth,true);
        properties.put(SMTP_PORT,DEFAULT_PORT);
        properties.put(SMTP_STARTTLS_ENABLE,true);
        return Session.getInstance(properties,null);
    }
}
