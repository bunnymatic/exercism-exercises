import com.sun.tools.javac.util.ArrayUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static java.util.stream.Collectors.toList;

public class Pangrams {

    private static final String LETTERS = "abcdefghijklmnopqrstuvwxyz";

    public static boolean isPangram(String phrase) {
        Character[] chars = stringToCharacterArray(stripNonLetters(phrase));
        Map<Character, Integer> histogram = (new Histogram(chars)).histogram;

        Set<Character> keys = histogram.keySet();
        if (LETTERS.length() != keys.size()) {
            return false;
        }
        String allCharacters = "";
        for (Character c: keys) {
            allCharacters = allCharacters.concat(c.toString());
        }
        if (!allCharacters.equals(LETTERS)) {
            return false;
        }
        return true;
    }

    private static Character[] stringToCharacterArray(String s) {
        return s.chars().mapToObj(c -> (char)c).toArray(Character[]::new);
    }


    private static String stripNonLetters(String phrase) {
        return phrase.toLowerCase().replaceAll("[^\\w]", "");
    }

    public static class Histogram<T> {

        private Map<T, Integer> histogram;

        public Histogram( T[] items ) {
            compute(items);
        }

        public Map<T, Integer> compute( T[] items ) {
            this.histogram = new HashMap();

            for ( T item : items ) {
                this.histogram.put(item, this.histogram.getOrDefault(item, 0) + 1);
            }
            return this.histogram;
        }

    }
}