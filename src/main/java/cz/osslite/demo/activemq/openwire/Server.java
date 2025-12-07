package cz.osslite.demo.activemq.openwire;

import org.apache.activemq.artemis.util.ServerUtil;

import java.util.Scanner;

public class Server {

    private static Process server0;

    public static void main(final String[] args) throws Exception {
        try {
            server0 = ServerUtil.startServer(args[0], Server.class.getSimpleName(), 0, 5000);

            Scanner scanner = new Scanner(System.in);

            System.out.println("Alternatively you could start the server under ./target/server0");
            System.out.println("Press enter to stop the server:");
            scanner.nextLine();

        } finally {
            ServerUtil.killServer(server0);
        }
    }
}