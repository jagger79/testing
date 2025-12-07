package cz.osslite.demo.fop.controllers;

import lombok.extern.slf4j.Slf4j;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

@Component
@Slf4j
class FopSupport {
    @Autowired
    FopFactory fopFactory;

    public Fop creatFop(OutputStream output) throws Exception {
        // customize userAgent
        FOUserAgent userAgent = fopFactory.newFOUserAgent();
        userAgent.setAuthor("ocp");//avoid apache fop
        userAgent.setCreator("ocp");//avoid apache fop
        userAgent.setProducer("ocp");//avoid apache fop
        userAgent.setTitle("ocp test");
        userAgent.setCreationDate(new Date());
        userAgent.setPdfUAEnabled(true);

        return fopFactory.newFop(MimeConstants.MIME_PDF, userAgent, output);
    }

    Transformer getTransformer(InputStream xslFo) throws Exception {
        var dir = getClass().getClassLoader().getResource("fop/xsl-fo/.").toURI();

        var resolver = new URIResolver() {
            public Source resolve(String href, String base)
                    throws TransformerException {
                File baseDir = new File(dir);
                StreamSource source;
                InputStream file;

                try {
                    log.info("Composing dir={},file={}", baseDir.getAbsolutePath(), href);
                    file = new FileInputStream(new File(baseDir, href));
                } catch (Exception e) {
                    log.error("", e);
                    throw new TransformerException(e);
                }
                try {
                    source = new StreamSource(file);
                } catch (Exception e) {
                    log.error("", e);
                    throw new TransformerException(e);
                }
                return source;
            }
        };
        TransformerFactory fact = TransformerFactory.newInstance();
        fact.setURIResolver(resolver);
        Transformer transformer = fact.newTransformer(new StreamSource(xslFo));
//        transformer.setParameter("versionParam", "2.0");
        return transformer;
    }
}