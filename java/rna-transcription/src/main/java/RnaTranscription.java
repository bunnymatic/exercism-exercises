import java.util.HashMap;

public class RnaTranscription {

    private final static HashMap<Character, Character> lookup = new HashMap<>();
    static {
        lookup.put('G', 'C');
        lookup.put('C', 'G');
        lookup.put('T', 'A');
        lookup.put('A', 'U');
    }
    public static String ofDna(String dna) {
        StringBuilder builder = new StringBuilder();
        dna.chars().forEach(c -> {
            builder.append(lookup.get((char)c));
        });
        return builder.toString();
    }
}