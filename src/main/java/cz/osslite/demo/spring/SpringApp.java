package cz.osslite.demo.spring;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.jdbc.autoconfigure.DataSourceAutoConfiguration;
import org.springframework.boot.security.autoconfigure.SecurityAutoConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.WebApplicationInitializer;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class,
        SecurityAutoConfiguration.class})
public class SpringApp {
    void main(String[] args) {
        SpringApplication.run(SpringApp.class, args);
    }

    @Configuration
    @Slf4j
    public static class MyWebApplicationInitializer implements WebApplicationInitializer {
        @Override
        public void onStartup(ServletContext sc) throws ServletException {
            log.info("VirtualServerName={}", sc.getVirtualServerName());
        }
    }
}
