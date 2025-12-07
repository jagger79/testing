package cz.osslite.demo.soap.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;

@Configuration
@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
@Slf4j
public class SoapClientConfiguration {
}
