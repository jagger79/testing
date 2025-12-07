package cz.osslite.demo.oauth2.server.domain.customer;

import java.time.LocalDate;

public record CustomerCreate(
        String firstName,
        String middleName,
        String lastName,
        String email,
        String phoneNumber,
        LocalDate birthDate
) {
}