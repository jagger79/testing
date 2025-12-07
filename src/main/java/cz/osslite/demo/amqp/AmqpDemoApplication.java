package cz.osslite.demo.amqp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AmqpDemoApplication {
    public static void main(String[] args) {
        System.setProperty("spring.artemis.embedded.enabled", "false");
        SpringApplication.run(AmqpDemoApplication.class, args);
    }
}