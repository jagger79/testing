package cz.osslite.demo.oauth2.server.domain.customer;

import cz.osslite.demo.oauth2.server.domain.common.Nullable;

import java.time.LocalDate;

public record CustomerPatch(
        LocalDate birthDate,
        Nullable<String> firstName,
        Nullable<String> middleName,
        Nullable<String> lastName,
        Nullable<String> email,
        Nullable<String> phoneNumber
) {
}