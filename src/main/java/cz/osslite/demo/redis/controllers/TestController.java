package cz.osslite.demo.redis.controllers;

import cz.osslite.demo.redis.external.mq.MessageQueueAdapter;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitMessagingTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
class TestController {
    private final MessageQueueAdapter mq;
    private final RabbitMessagingTemplate amqpTemplate;

    @PostMapping
    void sendMessage(@RequestBody String body) {
        mq.sendChat(body);
    }

    @PostMapping("topic")
    void sendTopic(@RequestBody String body) {
        mq.sendTopic(body);
    }

    @PostMapping("queue")
    void sendMessageQueue(@RequestBody String body) {
        mq.sendMessage(body);
    }

    @PostMapping("amqp-test/{exchange}")
    void amqpSend(@PathVariable String exchange,
                  @RequestBody String body) {
        amqpTemplate.convertAndSend(exchange, "", body);
    }
}