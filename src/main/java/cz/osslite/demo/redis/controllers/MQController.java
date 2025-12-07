package cz.osslite.demo.redis.controllers;

import cz.osslite.demo.redis.external.mq.MessageQueueAdapter;
import cz.osslite.demo.redis.services.Receiver;
import jakarta.jms.Message;
import jakarta.jms.ObjectMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.activemq.artemis.jms.client.ActiveMQMessage;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.core.RabbitMessagingTemplate;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Controller;

import java.util.Date;

@RequiredArgsConstructor
@Controller
@Slf4j
public class MQController {//implements MessageListener {
    private final Receiver service;
    private final RabbitMessagingTemplate amqpTemplate;
    private final TopicExchange topic;
    private final AmqpAdmin amqpAdmin;

    public void receiveMessage(Object message) {
        service.receiveMessage(message);
    }

    public void handleMessage(Object message) {
        service.handleMessage(message);
    }

    @JmsListener(destination = MessageQueueAdapter.QUEUE_LEADTOOL)
    public void onMessage(Message message) throws Exception {
        ActiveMQMessage mqMessage = (ActiveMQMessage) message;
        Object body = mqMessage.getBody(Object.class);
        ObjectMessage objectMessage = null;//(ObjectMessage) mqMessage.getMessage();
        service.handleQueueMessage(body);
    }

    @JmsListener(destination = MessageQueueAdapter.QUEUE_LEADTOOL)
    public void onMessage2(Message message) throws Exception {
        ActiveMQMessage mqMessage = (ActiveMQMessage) message;
        log.info("isBodyAssignableTo={}", message.isBodyAssignableTo(Object.class));
        log.info("getJMSMessageID={}", message.getJMSMessageID());
        log.info("getJMSCorrelationID={}", message.getJMSCorrelationID());
        log.info("getJMSType={}", message.getJMSType());
        log.info("getJMSTimestamp={},getJMSTimestamp={}", message.getJMSTimestamp(), new Date(message.getJMSTimestamp()));
        log.info("getJMSExpiration={},getJMSExpiration={}", message.getJMSExpiration(), new Date(message.getJMSExpiration()));
        log.info("getJMSDeliveryMode={}", message.getJMSDeliveryMode());
        log.info("getJMSDeliveryTime={},getJMSDeliveryTime={}", message.getJMSDeliveryTime(), new Date(message.getJMSDeliveryTime()));
        log.info("getJMSDestination={}", message.getJMSDestination());
        log.info("getJMSPriority={}", message.getJMSPriority());
        log.info("getJMSRedelivered={}", message.getJMSRedelivered());
        log.info("getJMSReplyTo={}", message.getJMSReplyTo());
        log.info("getType={}", ((ActiveMQMessage) message).getType());
        log.info("getCoreMessage={}", ((ActiveMQMessage) message).getCoreMessage());
        log.info("toString={}", message);
        Object body = message.getBody(Object.class);
        service.handleQueueMessage(body);
    }

    @JmsListener(destination = MessageQueueAdapter.TOPIC_LEADTOOL)
    public void onMessageTopic(Message message) throws Exception {
        ActiveMQMessage mqMessage = (ActiveMQMessage) message;
        Object body = mqMessage.getBody(Object.class);
        service.handleMessage(body);
    }

    @JmsListener(destination = MessageQueueAdapter.TOPIC_LEADTOOL)
    public void onMessageTopic2(Message message) throws Exception {
        ActiveMQMessage mqMessage = (ActiveMQMessage) message;
        Object body = mqMessage.getBody(Object.class);
        service.handleMessage(body);
    }
}