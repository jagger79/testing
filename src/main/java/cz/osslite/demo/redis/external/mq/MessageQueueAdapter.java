package cz.osslite.demo.redis.external.mq;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class MessageQueueAdapter {
    public static final String TOPIC_LEADTOOL = "leadtool-topic";
    public static final String QUEUE_LEADTOOL = "leadtool";

    private final StringRedisTemplate template;
    private final JmsTemplate jmsTemplate;
    private final JmsMessagingTemplate messagingTemplate;

    public void sendChat(String message) {
        template.convertAndSend(TOPIC_LEADTOOL, message);
    }

    public void sendTopic(String message) {
        jmsTemplate.convertAndSend(TOPIC_LEADTOOL, message);
    }

    public void sendMessage(String message) {
        jmsTemplate.convertAndSend(QUEUE_LEADTOOL, message);
//        jmsTemplate.send(new ActiveMQTopic(QUEUE_LEADTOOL), message);
    }
}