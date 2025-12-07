package cz.osslite.demo.amqp.controllers;

import jakarta.jms.Message;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitMessagingTemplate;
import org.springframework.stereotype.Controller;

@RequiredArgsConstructor
@Controller
@Slf4j
public class MQController {
    private final RabbitMessagingTemplate amqpTemplate;
    private final TopicExchange topic;
    private final AmqpAdmin amqpAdmin;

    @RabbitListener(queues = {"#{autoDeleteQueue1.name}"})
    public void on(String message) {
        log.info("amqp,received={},info={}", message,
                amqpAdmin.getQueueInfo("tut.topic"));
    }

    @RabbitListener(queues = {"#{autoDeleteQueue1.name}"})
    public void onMessage(Message message) {
        log.info("amqp,received={},info={}", message,
                amqpAdmin.getQueueInfo("tut.topic"));
    }
}