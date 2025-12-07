package cz.osslite.demo.amqp.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitMessagingTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
class TestController {
    private final RabbitMessagingTemplate amqpTemplate;

    @PostMapping("amqp-test/{exchange}")
    void amqpSend(@PathVariable String exchange,
                  @RequestBody String body) {
        amqpTemplate.convertAndSend(exchange, "", body);
    }
}