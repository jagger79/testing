package cz.osslite.demo.oauth2.server.domain.common;

import java.util.NoSuchElementException;
import java.util.function.Consumer;

public class Nullable<T> {
    private static final Nullable<?> UNDEFINED = new Nullable<>(null, false);

    private final T value;
    private final boolean isPresent;

    private Nullable(T value, boolean isPresent) {
        this.value = value;
        this.isPresent = isPresent;
    }

    public static <T> Nullable<T> undefined() {
        @SuppressWarnings("unchecked")
        Nullable<T> t = (Nullable<T>) UNDEFINED;
        return t;
    }

    public static <T> Nullable<T> of(T value) {
        return new Nullable<>(value, true);
    }

    public T get() {
        if (!isPresent) {
            throw new NoSuchElementException("Value is undefined");
        }
        return value;
    }

    public boolean isPresent() {
        return isPresent;
    }

    public boolean isNotPresent() {
        return !isPresent();
    }

    public boolean isPresentAndSet() {
        return isPresent() && value != null;
    }

    public void ifPresentAndSet(Consumer<? super T> action) {
        if (isPresent() && value != null) {
            action.accept(value);
        }
    }

    public boolean isPresentAndNull() {
        return isPresent() && value == null;
    }
}
