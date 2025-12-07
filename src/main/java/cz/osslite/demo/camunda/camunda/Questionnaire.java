package cz.osslite.demo.camunda.camunda;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class Questionnaire {
    String risk;
    String countryCode;
    String description;
    Boolean wasHospitalized;
    Boolean hasDoctor;
    LocalDate startDate;
}
