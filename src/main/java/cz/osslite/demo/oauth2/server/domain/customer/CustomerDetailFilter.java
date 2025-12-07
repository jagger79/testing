package cz.osslite.demo.oauth2.server.domain.customer;

import java.time.LocalDate;

public record CustomerDetailFilter(
        LocalDate birthDate) {
}