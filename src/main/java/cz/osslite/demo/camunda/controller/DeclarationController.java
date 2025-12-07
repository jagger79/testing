package cz.osslite.demo.camunda.controller;

import cz.osslite.demo.camunda.camunda.DeclarationProcessInput;
import io.camunda.client.CamundaClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@Slf4j
@RequiredArgsConstructor
public class DeclarationController {
    private final CamundaClient zeebeClient;

    @PostMapping("camunda/{processId}")
    public ResponseEntity<Object> createProcessInstance(@PathVariable final String processId,
                                                        @RequestBody final DeclarationProcessInput in) {
        final String bpmnProcessId = processId == null ? "create-declaration" : processId;
        final Map<String, Object> variables = in.getVariables();

        var process = zeebeClient.newCreateInstanceCommand()
                .bpmnProcessId(bpmnProcessId)
                .latestVersion()
                .variables(variables);

        if (in.isSync()) {
            final var result = process.withResult().send().join();
            log.info("finished process,{}", result.getBpmnProcessId());
            return ResponseEntity.ok(result.getVariablesAsMap());
        }
        final var event = process.send().join();
        log.info("started process instance,bpmnProcessId={},id={}", event.getBpmnProcessId(),
                event.getProcessInstanceKey());
        return ResponseEntity.ok("{}");
    }
}
