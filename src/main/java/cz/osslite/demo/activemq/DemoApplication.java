package cz.osslite.demo.activemq;

import jakarta.jms.*;
import org.apache.qpid.jms.JmsConnectionFactory;

public class DemoApplication {
    public static void main(String[] args) throws Exception {
        Connection connection = null;
        ConnectionFactory connectionFactory = new JmsConnectionFactory("amqp://localhost:5672");

        try {

            // Step 1. Create an amqp qpid 1.0 connection
            connection = connectionFactory.createConnection();

            // Step 2. Create a session
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            // Step 3. Create a sender
            Queue queue = session.createQueue("exampleQueue");
            MessageProducer sender = session.createProducer(queue);

            // Step 4. send a few simple message
            sender.send(session.createTextMessage("Hello world "));

            connection.start();

            // Step 5. create a moving receiver, this means the message will be removed from the queue
            MessageConsumer consumer = session.createConsumer(queue);

            // Step 7. receive the simple message
            TextMessage m = (TextMessage) consumer.receive(5000);
            System.out.println("message = " + m.getText());

        } finally {
            if (connection != null) {
                // Step 9. close the connection
                connection.close();
            }
        }
        sendReceive("SCRAM-SHA-256", "test", "test");
    }

    // https://github.com/apache/activemq-artemis/tree/main/examples/protocols/amqp/sasl-scram
    private static void sendReceive(String method, String username, String password) throws JMSException {
        ConnectionFactory connectionFactory =
                new JmsConnectionFactory("amqp://localhost:5672?amqp.saslMechanisms=" + method);
        try (Connection connection = connectionFactory.createConnection(username, password)) {
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Queue queue = session.createQueue("exampleQueue");
            MessageProducer sender = session.createProducer(queue);
            sender.send(session.createTextMessage("Hello " + method));
            connection.start();
            MessageConsumer consumer = session.createConsumer(queue);
            TextMessage m = (TextMessage) consumer.receive(5000);
            System.out.println("message = " + m.getText());
        }
    }
}