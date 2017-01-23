import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.IntStream;

import static java.util.stream.Collectors.toList;

public class Anagram {

    private String word;
    private int[] charsPresent;

    public Anagram(String word) {
        this.word = word.toLowerCase();
        this.charsPresent = charsInWord(word);
    }

    private int[] charsInWord(String word) {
        return word.toLowerCase().chars().sorted().toArray();
    }

    public List<String> match(List<String> candidates) {
        return candidates
                .stream()
                .filter( c -> !c.toLowerCase().equals(word)
                                        && Arrays.equals(charsInWord(c),charsPresent) )
                .collect(toList());
    }
}