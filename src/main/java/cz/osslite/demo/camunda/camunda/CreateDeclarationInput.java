package cz.osslite.demo.camunda.camunda;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateDeclarationInput {
    String risk;
    String countryCode;
    String partnerId;
    String firstName;
    String lastName;
    String birthNumber;
    Questionnaire questionnaire;
}
