package cz.osslite.demo.redis.config;

import cz.osslite.demo.redis.controllers.MQController;
import cz.osslite.demo.redis.external.mq.MessageQueueAdapter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.boot.data.redis.autoconfigure.LettuceClientConfigurationBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Role;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.RedisSerializer;

import java.util.Collection;

/**
 * @see https://spring.io/guides/gs/messaging-redis/
 * @see org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration
 * @see org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration
 * @see org.springframework.cloud.sleuth.autoconfig.brave.instrument.redis.BraveRedisAutoConfiguration
 */
@Configuration
@Slf4j
@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
public class RedisConfiguration {
    @Bean
    RedisMessageListenerContainer container(RedisConnectionFactory connectionFactory,
                                            Collection<MessageListenerAdapter> listenerAdapters) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
//        container.addMessageListener(listenerAdapter, PatternTopic.of("leadtool.*"));
        listenerAdapters.forEach(adapter -> container.addMessageListener(adapter, ChannelTopic.of(MessageQueueAdapter.TOPIC_LEADTOOL)));

        return container;
    }

    /**
     * @see org.springframework.cloud.sleuth.autoconfig.instrument.redis.TraceLettuceClientResourcesBeanPostProcessor#postProcessBeforeInitialization(Object, String)
     */
    @Bean
    LettuceClientConfigurationBuilderCustomizer cust(brave.Tracing tracing) {
        return clientConfigurationBuilder -> {
            // this is already done
//            log.info("{}", clientConfigurationBuilder);
//            ClientResources.Builder builder = ClientResources.builder();
//            builder.tracing(BraveTracing.create(tracing));
//            clientConfigurationBuilder.clientResources(builder.build());
        };
    }

    @Bean
    MessageListenerAdapter listenerAdapter(MQController receiver) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(receiver, "receiveMessage") {
            @Override
            protected void invokeListenerMethod(String methodName, Object[] arguments) {
                Object message = arguments[0];
                receiver.receiveMessage(message);
            }
        };
        adapter.setSerializer(RedisSerializer.json());
        return adapter;
    }

    @Bean
    MessageListenerAdapter listenerAdapter2(MQController receiver) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(receiver, "handleMessage") {
            @Override
            protected void invokeListenerMethod(String methodName, Object[] arguments) {
                Object message = arguments[0];
                receiver.handleMessage(message);
            }
        };
        adapter.setSerializer(RedisSerializer.json());
        return adapter;
    }
}