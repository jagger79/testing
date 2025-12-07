package cz.osslite.demo.jackson;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;

@SpringBootApplication
@Slf4j
public class JacksonApplication {
    public static void main(String[] args) {
        SpringApplication.run(JacksonApplication.class, args);
    }

    @Configuration
    public static class JsonConfig {
        @Autowired
        void log(ObjectMapper om) {
//            om.registerModule(new JsonComponentModule());
//            om.registerModule(JsonMixinMod.class);
            log.info("mapper,{}", om.getRegisteredModuleIds());
        }
    }
}