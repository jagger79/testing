package cz.osslite.demo.mail.controller;

import cz.osslite.demo.mail.service.PdfService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("${api.base-path.prefix}pdf")
@Validated
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
class PdfController {
    PdfService pdfService;

    //@PostMapping(produces = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PostMapping(produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public void render(@RequestBody Map<String, Object> params,
                       HttpServletResponse resp) throws Exception {
        byte[] pdf = pdfService.generate(params);
        ResponseEntity.ok(Map.of("Hello", "World"));

        var out = resp.getOutputStream();
        resp.setContentType(MediaType.APPLICATION_PDF_VALUE);
        resp.setContentLength(pdf.length);
        String cd = ContentDisposition.inline().filename("test.pdf").build().toString();
        resp.setHeader(HttpHeaders.CONTENT_DISPOSITION, cd);

        out.write(pdf);
    }
}
