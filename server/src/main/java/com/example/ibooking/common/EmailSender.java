package com.example.ibooking.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
    private final JavaMailSender javaMailSender;

    public EmailSender(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    /**
     * 发送邮件
     *
     * @param recipient 收件人邮箱地址
     * @param subject   邮件主题
     * @param body      邮件内容
     */
    public void sendEmail(String recipient, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("ibooking7@163.com");
        message.setTo(recipient);     // 设置收件人
        message.setSubject(subject);  // 设置邮件主题
        message.setText(body);        // 设置邮件内容

        javaMailSender.send(message);  // 发送邮件
    }
}
