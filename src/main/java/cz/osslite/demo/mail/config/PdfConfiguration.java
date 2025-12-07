package cz.osslite.demo.mail.config;

import lombok.extern.slf4j.Slf4j;
import org.openpdf.text.pdf.BaseFont;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;
import org.springframework.core.io.Resource;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.IOException;
import java.util.List;
import java.util.function.Supplier;

@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
@Configuration
@Slf4j
class PdfConfiguration {
    @Value("classpath:/templates/font/*.ttf")
    List<Resource> fonts;

    @Bean
    public Supplier<ITextRenderer> rendererSupplier() {
        // to eager test it's working
        ITextRenderer r = new ITextRenderer();
        fonts.forEach(font -> {
            try {
                var name = font.getFile().getName().substring(0, font.getFile().getName().lastIndexOf('.'));
                r.getFontResolver().addFont(font.getFile().getPath(),
                        name,
                        BaseFont.IDENTITY_H,
                        BaseFont.NOT_EMBEDDED,
                        null);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });

        return () -> {
            try {
                ITextRenderer renderer = new ITextRenderer();
                fonts.forEach(font -> {
                    try {
                        var name = font.getFile().getName().substring(0, font.getFile().getName().lastIndexOf('.'));
                        r.getFontResolver().addFont(font.getFile().getPath(),
                                name,
                                BaseFont.IDENTITY_H,
                                BaseFont.NOT_EMBEDDED,
                                null);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                });
                return renderer;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        };
    }
}
