package cz.osslite.demo.fop.controllers;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.fop.apps.Fop;
import org.springframework.util.StopWatch;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import tools.jackson.dataformat.xml.XmlMapper;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.CharArrayReader;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

@RestController
@Slf4j
@AllArgsConstructor
public class FopController {
    private final XmlMapper xmlMapper = new XmlMapper();
    private final FopSupport fopSupport;

    /**
     * @see https://xmlgraphics.apache.org/fop/2.11/embedding.html
     */
    @PostMapping("generate")
    void fopTest(HttpServletResponse response,
                 @RequestBody Map<String, Object> request) throws Exception {
        StopWatch sw = new StopWatch();

        sw.start("creation");
        OutputStream output = prepareStream(response);
        Fop fop = fopSupport.creatFop(output);
        sw.stop();

        sw.start("get FO xsl");
        InputStream xslFo = getClass().getClassLoader().getResource("fop/xsl-fo/test.fo.xsl").openStream();
        sw.stop();

        sw.start("get transformer");
        Transformer transformer = fopSupport.getTransformer(xslFo);
        sw.stop();

        var o = new FakeMap();
        o.putAll(request);

        sw.start("transform");
        transform(transformer, fop, o);
        sw.stop();

        log.info("{}", sw);
        response.getOutputStream().close();
    }

    OutputStream prepareStream(HttpServletResponse response) throws Exception {
        response.setHeader("Content-Type", "application/force-download");
        response.setHeader("Content-Type", "application/x-download");
        response.setHeader("Content-Disposition", "attachment; filename=\"export.pdf\"");

        boolean isBuffered = Boolean.FALSE.equals(Boolean.valueOf("true"));
        ServletOutputStream outputStream = response.getOutputStream();
        OutputStream output = new java.io.BufferedOutputStream(outputStream);
        return isBuffered ? output : outputStream;
    }

    void transform(Transformer transformer, Fop fop, Object o) throws Exception {
        Source xmlSource = new StreamSource(new CharArrayReader(xmlMapper.writeValueAsString(o).toCharArray()));
        // Resulting SAX events (the generated FO) must be piped through to FOP
        Result outputTarget = new SAXResult(fop.getDefaultHandler());
        // outputTarget = new StreamResult(new PrintWriter(System.out))

        // Start the XSLT transformation and FOP processing
        transformer.transform(xmlSource, outputTarget);
    }

    class FakeMap extends HashMap<Object, Object> {
    }
}