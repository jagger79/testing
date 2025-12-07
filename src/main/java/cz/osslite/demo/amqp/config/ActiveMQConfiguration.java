package cz.osslite.demo.amqp.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.adapter.MessageListenerAdapter;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;
import org.springframework.jms.annotation.EnableJms;

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
 * @see org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration
 */
@Configuration
@Slf4j
@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
//@EnableRabbit
public class ActiveMQConfiguration {
    //    @Value("${active-mq.broker-url:localhost:}")
//    private String brokerUrl;
    private RabbitTemplate template;
    private AmqpTemplate amqpTemplate;

    //    @Bean
    public org.springframework.amqp.rabbit.connection.ConnectionFactory connectionFactory2() {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory("localhost");
        connectionFactory.setUsername("guest");
        connectionFactory.setPassword("guest");
        return connectionFactory;
    }

    // already in AutoConfiguration
//    @Bean
    public AmqpAdmin amqpAdmin(org.springframework.amqp.rabbit.connection.ConnectionFactory cf) {
        return new RabbitAdmin(cf);
    }

    //    @Bean
    public SimpleMessageListenerContainer listenerContainer(org.springframework.amqp.rabbit.connection.ConnectionFactory cf) {
        SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
        container.setConnectionFactory(cf);
        container.setQueueNames("some_queue");
        container.setMessageListener(new MessageListenerAdapter(new Object()));
        return container;
    }

    @Bean
    public Queue hello() {
        // Every queue is bound to the default direct exchange
        return new Queue("hello");
    }

    @Bean
    public Queue autoDeleteQueue1() {
        return new Queue("leadtool");
    }

    @Bean
    public Queue autoDeleteQueue2() {
        return new AnonymousQueue();
    }

    /**
     * The fanout exchange is very simple.
     * As you can probably guess from the name, it just broadcasts all the messages it receives to all the queues it knows.
     * And that's exactly what we need for fanning out our messages.
     */
    @Bean
    public FanoutExchange fanout() {
        return new FanoutExchange("tut.fanout");
    }

    @Bean
    public DirectExchange direct() {
        return new DirectExchange("tut.direct");
    }

    @Bean
    public TopicExchange topic() {
        return new TopicExchange("tut.topic");
    }

    @Bean
    public Binding binding1(FanoutExchange fanout,
                            Queue autoDeleteQueue1) {
        return BindingBuilder.bind(autoDeleteQueue1).to(fanout);
    }

    @Bean
    public Binding binding2(DirectExchange direct,
                            Queue autoDeleteQueue1) {
        String topic_leadtool = "leadtool.1";
        return BindingBuilder.bind(autoDeleteQueue1).to(direct).with(topic_leadtool);
    }

    @Bean
    public Binding binding3(TopicExchange topic,
                            Queue autoDeleteQueue1) {
        String topic_leadtool = "leadtool.cache";
        String topic_leadtool_client = "leadtool.#";

        return BindingBuilder.bind(autoDeleteQueue1).to(topic).with(topic_leadtool);
    }
}