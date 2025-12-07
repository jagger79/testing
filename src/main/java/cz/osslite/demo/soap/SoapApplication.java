package cz.osslite.demo.soap;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.activemq.autoconfigure.ActiveMQAutoConfiguration;
import org.springframework.boot.amqp.autoconfigure.RabbitAutoConfiguration;
import org.springframework.boot.artemis.autoconfigure.ArtemisAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.data.redis.autoconfigure.DataRedisAutoConfiguration;
import org.springframework.boot.jdbc.autoconfigure.DataSourceAutoConfiguration;
import org.springframework.boot.micrometer.metrics.autoconfigure.export.elastic.ElasticMetricsExportAutoConfiguration;
import org.springframework.cloud.vault.config.VaultAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;

@Slf4j
@SpringBootApplication(exclude = {
        DataSourceAutoConfiguration.class,
        RabbitAutoConfiguration.class,
        ArtemisAutoConfiguration.class,
        ElasticMetricsExportAutoConfiguration.class,
        DataRedisAutoConfiguration.class,
        ActiveMQAutoConfiguration.class,
        VaultAutoConfiguration.class
})
public class SoapApplication {
    void main(String[] args) {
        SpringApplication.run(SoapApplication.class, args);
    }

    @Bean
    SecurityFilterChain security(HttpSecurity http) {
        return http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(matcher -> matcher
                        .anyRequest()
                        .permitAll()
                )
                .build();
    }
}