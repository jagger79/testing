package cz.osslite.demo.soap.config;

import com.mycompany.hr.schemas.ObjectFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.config.annotation.EnableWs;
import org.springframework.ws.config.annotation.WsConfigurer;
import org.springframework.ws.server.EndpointInterceptor;
import org.springframework.ws.soap.server.endpoint.interceptor.PayloadValidatingInterceptor;
import org.springframework.ws.transport.http.MessageDispatcherServlet;
import org.springframework.ws.wsdl.wsdl11.SimpleWsdl11Definition;

import java.util.List;

@EnableWs
@Configuration
@Slf4j
public class SoapServerConfiguration implements WsConfigurer {
    @Value("${cms-adapter.mock.servlet-prefix:/mock-server}")
    private String servletPrefix;

    @Bean
    public SimpleWsdl11Definition orders() {
        return new SimpleWsdl11Definition(new ClassPathResource("/soap/wsdl/spring.wsdl"));
    }

    @Bean
    public ServletRegistrationBean<MessageDispatcherServlet> wsSoapServlet(final ApplicationContext appCtx) {
        final String logMsg = "soap,server,registering,{}";

        var dispatcherServlet = new MessageDispatcherServlet();
        dispatcherServlet.setApplicationContext(appCtx);
        dispatcherServlet.setTransformWsdlLocations(true);
        dispatcherServlet.setTransformSchemaLocations(true);
        log.info(logMsg, servletPrefix);

        return new ServletRegistrationBean<>(dispatcherServlet, servletPrefix + "/*");
    }

    @Override
    public void addInterceptors(final List<EndpointInterceptor> interceptors) {
        // for now, we need this interceptor to understand every soap header wings will send to us
        // but without validating request/response because wings are not sending xsd valid messages
        var validatingInterceptor = new PayloadValidatingInterceptor();
        validatingInterceptor.setValidateRequest(false);
        validatingInterceptor.setValidateResponse(false);
        interceptors.add(validatingInterceptor);
    }

    /**
     * jaxb2 marshaller for objects of wings-pms system located under package "com.bnpparibas.assurance"
     */
    @Bean
    public Jaxb2Marshaller marshaller() {
        final Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
        marshaller.setClassesToBeBound(ObjectFactory.class);
        return marshaller;
    }
}
