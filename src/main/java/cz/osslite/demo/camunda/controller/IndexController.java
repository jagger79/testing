package cz.osslite.demo.camunda.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("${api.base-path.prefix}")
@Validated
@Slf4j
class IndexController {
    @RequestMapping("/**")
    public ResponseEntity<Object> index() {
        return ResponseEntity.ok(Map.of("Hello", "World"));
    }
}
