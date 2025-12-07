package cz.osslite.demo.camunda.camunda;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.Map;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class DeclarationProcessInput {
    final Map<String, Object> variables;
    final Boolean sync;

    public boolean isSync() {
        return Boolean.TRUE.equals(getSync());
    }
}
