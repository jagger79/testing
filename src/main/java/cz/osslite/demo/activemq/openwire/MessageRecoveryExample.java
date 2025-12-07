package cz.osslite.demo.activemq.openwire;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.artemis.util.ServerUtil;

import jakarta.jms.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

public class MessageRecoveryExample {

    public static void main(final String[] args) throws Exception {
        Connection connection = null;
        Process server0 = null;
        try {
            server0 = ServerUtil.startServer(args[0], MessageRecoveryExample.class.getSimpleName() + "0", 0, 5000);

            ConnectionFactory cf = new ActiveMQConnectionFactory();

            connection = cf.createConnection();

            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            Queue queue = session.createQueue("exampleQueue");

            MessageProducer producer = session.createProducer(queue);

            int nMessages = 1000;

            for (int i = 0; i < nMessages; i++) {
                TextMessage message = session.createTextMessage("This is a text message " + i);

                System.out.println("Sent message: " + message.getText());

                producer.send(message);
            }

            connection.close();

            ServerUtil.killServer(server0);

            server0 = ServerUtil.startServer(args[0], MessageRecoveryExample.class.getSimpleName() + "0", 0, 5000);

            ServerUtil.waitForServerToStart(0, 5000);

            connection = cf.createConnection();

            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            CountDownLatch latch = new CountDownLatch(nMessages);
            MessageConsumer messageConsumer = session.createConsumer(queue);
            messageConsumer.setMessageListener(new LocalListener(latch));

            connection.start();

            if (!latch.await(5, TimeUnit.SECONDS)) {
                throw new RuntimeException("listener didn't receive all the messages");
            }

            System.out.println("Finished ok!");
        } finally {
            if (connection != null) {
                connection.close();
            }

            ServerUtil.killServer(server0);
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