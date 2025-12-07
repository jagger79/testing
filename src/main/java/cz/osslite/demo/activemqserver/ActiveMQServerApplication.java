package cz.osslite.demo.activemqserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class ActiveMQServerApplication {
    public static void main(String[] args) {
        new SpringApplicationBuilder(ActiveMQServerApplication.class)
                .web(WebApplicationType.NONE)
//                .build()
                .run(args)
                ;
        //SpringApplication.run(ActiveMQServerApplication.class, args);
    }
}