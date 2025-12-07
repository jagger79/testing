package cz.osslite.demo.camunda.controller;

import lombok.extern.slf4j.Slf4j;
import org.iban4j.CountryCode;
import org.iban4j.Iban;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("iban")
@Validated
@Slf4j
class IbanGeneratorController {
    @RequestMapping("generate")
    public ResponseEntity<Object> generate() {
        log.info("Generating IBAN code...");

        Iban iban = new Iban.Builder()
                .countryCode(CountryCode.CZ)
                .accountNumber("6701002209113478")
                .bankCode("6210")
                .build();
        Map<String, Object> ibanData = Map.of("formatted", iban.toFormattedString(),
                "code", iban.toString(),
                "bban", iban.getBban(),
                "account", iban.getAccountNumber() + "/" + iban.getBankCode());
        Map<String, Object> ret = Map.of("iban", ibanData);
        return ResponseEntity.ok(ret);
    }
}
