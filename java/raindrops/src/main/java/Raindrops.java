import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Raindrops {

    private static final Map<Long, String> RESPONSES;
    static {
        RESPONSES = new HashMap<>();
        RESPONSES.put(3L, "Pling");
        RESPONSES.put(5L, "Plang");
        RESPONSES.put(7L, "Plong");
    }

    public static String convert(int input) {
        List<Long> factors = PrimeFactors.getForNumber(input);
        String response = factors.stream()
                .distinct()
                .map( factor -> RESPONSES.getOrDefault(factor, "") )
                .collect(Collectors.joining(""));
        if (response.isEmpty()) {
            return Integer.toString(input);
        } else {
            return response;
        }
    }
}