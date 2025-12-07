package cz.osslite.demo.mail.controller;

import cz.osslite.demo.mail.service.PdfService;
import jakarta.mail.Session;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.util.ByteArrayDataSource;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.mail.autoconfigure.MailProperties;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.util.Map;

@RestController
@RequestMapping("/mail")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
@Validated
class EmailController {
    final EmailMapper mapper;
    final JavaMailSender mailSender;
    final MailProperties props;
    final PdfService pdfService;

    @Value("classpath:/coral.reef.jpg")
    public Resource logo;

    @PostMapping
    void sendReceive(@RequestBody Map<String, Object> in) throws Exception {
        byte[] pdf = pdfService.generate(in);

        MimeMessage mime = createMime(pdf);
        log.info("Sending email...");
        mailSender.send(mime);
        log.info("email sent");
    }

    MimeMessage createMime(byte[] pdf) throws Exception {
        var msg = new MimeMessage((Session) null);
        //msg.setHeader(HttpHeaders.CONTENT_TYPE, "text/html; charset=utf-8");
        msg.setHeader("X-Mailer", "roman");

        var helper = new MimeMessageHelper(msg, true, StandardCharsets.UTF_8.toString());
        helper.setFrom(new InternetAddress(props.getUsername()));
        helper.setTo("romankrejci@seznam.cz");
        helper.setCc("romankrejci79@seznam.cz");
        helper.setBcc("spamschranka@seznam.cz");
        helper.setSubject("Testing from local");
        helper.setText("<html><body>Hello world<p/><img src=\"cid:logo\" alt=\"image\"/></body></html>", true);

        try {
            var file = new ByteArrayDataSource(pdf, MediaType.APPLICATION_PDF_VALUE);
            helper.addAttachment("test.pdf", file);
        } catch (Exception e) {
            log.error("", e);
        }
        helper.addInline("logo", logo);

        var message = helper.getMimeMessage();
        message.saveChanges();
        return message;
    }
}
