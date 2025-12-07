package cz.osslite.demo.mail.service;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.ByteArrayOutputStream;
import java.util.Map;
import java.util.function.Supplier;

@Service
@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PdfService {
    TemplateEngine templateEngine;
    Supplier<ITextRenderer> rendererSupplier;

    public byte[] generate(Map<String, Object> params) {
        final var ctx = new Context();
        ctx.setVariable("message", "Hello World");

        final String html = templateEngine.process("template", ctx);

        Document doc = Jsoup.parse(html);
        doc.outputSettings().syntax(Document.OutputSettings.Syntax.xml);
        final String xhtml = doc.html();

        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var renderer = rendererSupplier.get();
            renderer.setDocumentFromString(xhtml);
            renderer.layout();
            renderer.createPDF(out);
            return out.toByteArray();
        } catch (Exception e) {
            //
        }
        return null;
    }
}
