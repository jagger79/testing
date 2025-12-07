package cz.osslite.demo.redis.services;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class Receiver {
    public void receiveMessage(Object message) {
        log.info("Receiving massage " + message);
    }

    public void handleMessage(Object message) {
        log.info("Received <" + message + ">");
    }

    public void handleQueueMessage(Object message) {
        log.info("Received queue: " + message);
    }
}