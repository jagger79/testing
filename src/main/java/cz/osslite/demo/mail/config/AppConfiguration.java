package cz.osslite.demo.mail.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.boot.validation.autoconfigure.ValidationConfigurationCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;

@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
@Configuration
@Slf4j
public class AppConfiguration {
    @Bean
    ValidationConfigurationCustomizer customizer() {
        return cfg -> {
            log.info("Customizing validation configuration,{}", cfg);
        };
    }
}
