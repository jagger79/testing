package cz.osslite.demo.activemq.openwire;

import org.apache.activemq.ActiveMQConnectionFactory;

import jakarta.jms.*;

public class QueueExample {

    public static void main(final String[] args) throws Exception {
        Connection connection = null;
        try {

            ConnectionFactory cf = new ActiveMQConnectionFactory();

            connection = cf.createConnection();

            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            Queue queue = session.createQueue("exampleQueue");

            MessageProducer producer = session.createProducer(queue);

            TextMessage message = session.createTextMessage("This is a text message");

            System.out.println("Sent message: " + message.getText());

            producer.send(message);

            MessageConsumer messageConsumer = session.createConsumer(queue);

            connection.start();

            TextMessage messageReceived = (TextMessage) messageConsumer.receive(5000);

            System.out.println("Received message: " + messageReceived.getText());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }
}