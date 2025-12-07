package cz.osslite.demo.activemq;

import org.apache.activemq.ActiveMQConnectionFactory;

import jakarta.jms.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

public class MessageListenerExample {

    public static void main(final String[] args) throws Exception {
        Connection connection = null;
        try {

            ConnectionFactory cf = new ActiveMQConnectionFactory();

            connection = cf.createConnection();

            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            Queue queue = session.createQueue("exampleQueue");

            int nMessages = 1000;

            CountDownLatch latch = new CountDownLatch(nMessages);
            MessageConsumer messageConsumer = session.createConsumer(queue);
            messageConsumer.setMessageListener(new LocalListener(latch));

            connection.start();

            MessageProducer producer = session.createProducer(queue);

            for (int i = 0; i < 1000; i++) {
                TextMessage message = session.createTextMessage("This is a text message " + i);

                System.out.println("Sent message: " + message.getText());

                producer.send(message);
            }

            if (!latch.await(5, TimeUnit.SECONDS)) {
                throw new RuntimeException("listener didn't receive all the messages");
            }

            System.out.println("Finished ok!");

        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    private static class LocalListener implements MessageListener {

        CountDownLatch latch;

        LocalListener(CountDownLatch latch) {
            this.latch = latch;
        }

        @Override
        public void onMessage(Message message) {
            latch.countDown();
            try {
                System.out.println("Received " + ((TextMessage) message).getText());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}