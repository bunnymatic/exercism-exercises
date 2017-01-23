import java.util.List;
import java.util.function.Predicate;

import static java.util.stream.Collectors.toList;

public class Strain {

    public static <T> List<T> keep(List<T> in, Predicate<T> filter) {
        return in.stream().filter(filter).collect(toList());
    }

    public static <T> List<T> discard(List<T> in, Predicate<T> filter) {
        return in.stream().filter(filter.negate()).collect(toList());
    }
}