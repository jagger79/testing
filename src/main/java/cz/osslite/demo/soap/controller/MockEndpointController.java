package cz.osslite.demo.soap.controller;

import com.mycompany.hr.schemas.HolidayRequest;
import com.mycompany.hr.schemas.HolidayResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import java.math.BigInteger;

@Endpoint
@RequiredArgsConstructor
@Slf4j
class MockEndpointController {
    public static final Integer THOUSAND_MILLIS = 1000;
    public static final long HALF_SECOND = 500;
    public static final String QNAME_REQ = "http://mycompany.com/hr/schemas";

    @PayloadRoot(namespace = QNAME_REQ, localPart = "HolidayRequest")
    @ResponsePayload
    HolidayResponse holiday(@RequestPayload final HolidayRequest in) throws Exception {
        log.info("mock-soap-server,received,HolidayRequest");

        long millis = (long) (Math.random() * THOUSAND_MILLIS) + HALF_SECOND;
        Thread.sleep(millis);

        var ret = new HolidayResponse();
        ret.setNumber(BigInteger.valueOf(millis));
        return ret;
    }
}
