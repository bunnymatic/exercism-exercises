import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

public class Acronym {

    public static String generate(String phrase) {
        Pattern splitter = Pattern.compile("[\\s\\p{Punct}]+");
        Stream<String> bits = splitter.splitAsStream( phrase.replaceAll("(<?[a-z])([A-Z])", " $2") );
        return bits.reduce( "",(memo, s) -> memo.concat(s.substring(0,1).toUpperCase()) );
    }
}