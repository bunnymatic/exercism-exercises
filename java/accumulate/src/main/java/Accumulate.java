import java.util.List;
import java.util.function.Function;

import static java.util.stream.Collectors.toList;

public class Accumulate {

    public static<T> List<T> accumulate(List<T> items, Function<T, T> mapper) {
        return items.stream().map( mapper ).collect(toList());
    }

}