package cz.osslite.demo.activemq.openwire;

import jakarta.jms.*;
import org.apache.activemq.ActiveMQConnectionFactory;

public class Chat implements MessageListener {

    private static final String APP_TOPIC = "jms.samples.chat";
    private static final String DEFAULT_USER = "Chatter";
    private static final String DEFAULT_BROKER_NAME = "tcp://localhost:61616";
    private static final String DEFAULT_PASSWORD = "password";

    private Connection connect = null;
    private Session pubSession = null;
    private Session subSession = null;
    private MessageProducer publisher = null;

    /**
     * Main program entry point.
     */
    public static void main(String[] argv) {
        // Is there anything to do?
        if (argv.length == 0) {
            printUsage();
            System.exit(1);
        }

        // Values to be read from parameters
        String broker = DEFAULT_BROKER_NAME;
        String username = null;
        String password = DEFAULT_PASSWORD;

        // Check parameters
        for (int i = 0; i < argv.length; i++) {
            String arg = argv[i];
            System.out.println("args::" + arg);

            if (arg.equals("-b")) {
                if (i == argv.length - 1 || argv[i + 1].startsWith("-")) {
                    System.err.println("error: missing broker name:port");
                    System.exit(1);
                }
                broker = argv[++i];
                continue;
            }

            if (arg.equals("-u")) {
                if (i == argv.length - 1 || argv[i + 1].startsWith("-")) {
                    System.err.println("error: missing user name");
                    System.exit(1);
                }
                username = argv[++i];
                continue;
            }

            if (arg.equals("-p")) {
                if (i == argv.length - 1 || argv[i + 1].startsWith("-")) {
                    System.err.println("error: missing password");
                    System.exit(1);
                }
                password = argv[++i];
                continue;
            }

            if (arg.equals("-h")) {
                printUsage();
                System.exit(1);
            }

            // Invalid argument
            System.err.println("error: unexpected argument: " + arg);
            printUsage();
            System.exit(1);
        }

        // Check values read in.
        if (username == null) {
            System.err.println("error: user name must be supplied");
            printUsage();
            System.exit(1);
        }

        // Start the JMS client for the "chat".
        Chat chat = new Chat();
        chat.chatter(broker, username, password);

    }

    /**
     * Prints the usage.
     */
    private static void printUsage() {

        StringBuffer use = new StringBuffer();
        use.append("usage: java Chat (options) ...\n\n");
        use.append("options:\n");
        use.append("  -b name:port Specify name:port of broker.\n");
        use.append("               Default broker: " + DEFAULT_BROKER_NAME + "\n");
        use.append("  -u name      Specify unique user name. (Required)\n");
        use.append("  -p password  Specify password for user.\n");
        use.append("               Default password: " + DEFAULT_PASSWORD + "\n");
        use.append("  -h           This help screen.\n");
        System.err.println(use);
    }

    /**
     * Create JMS client for publishing and subscribing to messages.
     */
    private void chatter(String broker, String username, String password) {
        // Create a connection.
        try {
            jakarta.jms.ConnectionFactory factory;
            factory = new ActiveMQConnectionFactory(username, password, broker);
            connect = factory.createConnection(username, password);
            pubSession = connect.createSession(false, Session.AUTO_ACKNOWLEDGE);
            subSession = connect.createSession(false, Session.AUTO_ACKNOWLEDGE);
        } catch (JMSException jmse) {
            System.err.println("error: Cannot connect to Broker - " + broker);
            jmse.printStackTrace();
            System.exit(1);
        }

        // Create Publisher and Subscriber to 'chat' topics
        try {
            Topic topic = pubSession.createTopic(APP_TOPIC);
            MessageConsumer subscriber = subSession.createConsumer(topic);
            subscriber.setMessageListener(this);
            publisher = pubSession.createProducer(topic);
            // Now that setup is complete, start the Connection
            connect.start();
        } catch (Exception jmse) {
            jmse.printStackTrace();
        }

        try {
            // Read all standard input and send it as a message.
            java.io.BufferedReader stdin = new java.io.BufferedReader(new java.io.InputStreamReader(System.in));
            System.out.println("\nChat application:\n" + "=================\n" + "The application user " + username + " connects to the broker at " + DEFAULT_BROKER_NAME + ".\n" + "The application will publish messages to the " + APP_TOPIC + " topic.\n" + "The application also subscribes to that topic to consume any messages published there.\n\n" + "Type some text, and then press Enter to publish it as a TextMesssage from " + username + ".\n");
            while (true) {
                String s = stdin.readLine();

                if (s == null)
                    exit();
                else if (s.length() > 0) {
                    TextMessage msg = pubSession.createTextMessage();
                    msg.setText(username + ": " + s);
                    publisher.send(msg);
                }
            }
        } catch (java.io.IOException ioe) {
            ioe.printStackTrace();
        } catch (Exception jmse) {
            jmse.printStackTrace();
        }
    }

    //
    // NOTE: the remainder of this sample deals with reading arguments
    // and does not utilize any JMS classes or code.
    //

    /**
     * Handle the message
     * (as specified in the javax.jms.MessageListener interface).
     */
    @Override
    public void onMessage(Message message) {
        try {
            // Cast the message as a text message.
            TextMessage textMessage = (TextMessage) message;

            // This handler reads a single String from the
            // message and prints it to the standard output.
            try {
                String string = textMessage.getText();
                System.out.println(string);
            } catch (Exception jmse) {
                jmse.printStackTrace();
            }
        } catch (RuntimeException rte) {
            rte.printStackTrace();
        }
    }

    /**
     * Cleanup resources and then exit.
     */
    private void exit() {
        try {
            connect.close();
        } catch (Exception jmse) {
            jmse.printStackTrace();
        }

        System.exit(0);
    }
}