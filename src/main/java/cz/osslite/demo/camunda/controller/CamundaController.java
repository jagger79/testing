package cz.osslite.demo.camunda.controller;

import cz.osslite.demo.camunda.camunda.*;
import io.camunda.client.annotation.JobWorker;
import io.camunda.client.annotation.VariablesAsType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

//@Component
@Slf4j
@RequiredArgsConstructor
public class CamundaController {
    @JobWorker(type = "get-questionnaire")
    public Object getQuestionnaire(@VariablesAsType GetQuestionnaireInput in) {
        log.info("get questionnaire,in={}", in);

        return Map.of("questionnaire", Questionnaire.builder()
                .risk(in.getRisk())
                .countryCode(in.getCountryCode())
                .description("some accident")
                .wasHospitalized(true)
                .hasDoctor(false)
                .startDate(LocalDate.parse("2023-12-12"))
                .build());
    }

    @JobWorker(type = "declaration-create")
    public Object createDeclaration(@VariablesAsType CreateDeclarationInput in) {
        log.info("create-declaration,in={}", in);

        var id = UUID.randomUUID().toString();
        return Map.of("declaration", Map.of("id", id));
    }

    @JobWorker(type = "declaration-update")
    public Object updateDeclaration(@VariablesAsType CreateDeclarationInput in) {
        log.info("update-declaration,in={}", in);

        var id = UUID.randomUUID().toString();
        var isTrue = ((int) (Math.random() * 1000)) % 2 == 0;
        isTrue = false;
        return isTrue ? Map.of() : Map.of("declaration", Map.of("id", id));
    }

    @JobWorker(type = "declaration-submit")
    public Object submitNol(@VariablesAsType SubmitDeclarationInput in) {
        log.info("submit-declaration,in={}", in);

        var id = UUID.randomUUID().toString();
        return Map.of("declaration", Map.of("id", id));
    }

    @JobWorker(type = "claim-detail")
    public Object claimDetail(@VariablesAsType ClaimDetailInput in) {
        log.info("claim-detail,in={}", in);

        var id = UUID.randomUUID().toString();
        return Map.of("claim", Map.of("id", id,
                "declarationId", in.getDeclarationId()));
    }
}
