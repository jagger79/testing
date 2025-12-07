package cz.osslite.demo.activemqserver.config;

import jakarta.jms.ConnectionFactory;
import lombok.extern.slf4j.Slf4j;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.artemis.jms.server.config.JMSQueueConfiguration;
import org.apache.activemq.artemis.jms.server.config.impl.JMSQueueConfigurationImpl;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.boot.artemis.autoconfigure.ArtemisConfigurationCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.config.DefaultJmsListenerContainerFactory;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.jms.core.JmsTemplate;

/**
 * @see https://medium.com/@mailshine/activemq-getting-started-with-springboot-a0c3c960356e
 * @see org.springframework.boot.autoconfigure.jms.activemq.ActiveMQAutoConfiguration
 * @see org.springframework.boot.autoconfigure.jms.artemis.ArtemisAutoConfiguration
 * @see org.springframework.boot.autoconfigure.jms.JmsAutoConfiguration
 * @see org.springframework.boot.autoconfigure.jms.artemis.ArtemisEmbeddedServerConfiguration
 * @see EnableJms
 * @see https://github.com/spring-projects/spring-amqp-samples
 * @see https://spring.io/projects/spring-amqp#overview
 * @see https://spring.io/blog/2010/06/14/understanding-amqp-the-protocol-used-by-rabbitmq/
 * @see org.springframework.boot.autoconfigure.amqp.RabbitAnnotationDrivenConfiguration
 */
@Configuration
@Slf4j
@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
@EnableJms
public class ActiveMQConfiguration {
    //    @Value("${active-mq.broker-url:localhost:}")
//    private String brokerUrl;
    private JmsTemplate template;
    private JmsMessagingTemplate msgTemplate;

    //    @Bean
    public ConnectionFactory connectionFactory() {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory();
//        activeMQConnectionFactory.setBrokerURL(brokerUrl);
//        activeMQConnectionFactory.setTrustedPackages(List.of("com.mailshine.springbootstandaloneactivemq"));
        return activeMQConnectionFactory;
    }

    //    @Bean
    public JmsTemplate jmsTemplate(ConnectionFactory cf) {
        JmsTemplate jmsTemplate = new JmsTemplate();
        jmsTemplate.setConnectionFactory(cf);
//        jmsTemplate.setPubSubDomain(true);  // enable for Pub Sub to topic. Not Required for Queue.
        return jmsTemplate;
    }

    //    @Bean
    public JMSQueueConfiguration queueLeadtool(ConnectionFactory cf) {
        return new JMSQueueConfigurationImpl().setName("MessageQueueAdapter.QUEUE_LEADTOOL");
    }

    @Bean
    public ArtemisConfigurationCustomizer customize() {
        return configuration -> {
            log.info("{}", configuration);
            try {
                configuration.addAcceptorConfiguration("core",
//                        "tcp://localhost:61616?protocols=CORE,AMQP,MQTT;saslMechanisms=SCRAM-SHA-256;saslLoginConfigScope=amqp-sasl-scram",
                        "tcp://0.0.0.0:61616" +
                                "?tcpSendBufferSize=1048576;tcpReceiveBufferSize=1048576;amqpMinLargeMessageSize=102400;protocols=CORE,AMQP;useEpoll=true;amqpCredits=1000;amqpLowCredits=300;amqpDuplicateDetection=true");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        };
    }

    //    @Bean
    public JMSQueueConfiguration queueTest(ConnectionFactory cf) {
        return new JMSQueueConfigurationImpl().setName("test");
    }

    //    @Bean
    public DefaultJmsListenerContainerFactory jmsListenerContainerFactory(ConnectionFactory cf) {
        DefaultJmsListenerContainerFactory factory = new DefaultJmsListenerContainerFactory();
        factory.setConnectionFactory(cf);
        factory.setPubSubDomain(true);
        return factory;
    }

    @Bean
    public DefaultJmsListenerContainerFactory jmsListenerContainerFactoryQueue(ConnectionFactory cf) {
        DefaultJmsListenerContainerFactory factory = new DefaultJmsListenerContainerFactory();
        factory.setConnectionFactory(cf);
        return factory;
    }
}