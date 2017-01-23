import java.util.ArrayList;
import java.util.List;

public class PigLatin {
    public static String translate(String wordString) {
        String[] words = wordString.toLowerCase().split("\\s+");
        List<String> encodedWords = new ArrayList<>();
        for (String word: words) {
            encodedWords.add(encodeWord(word));
        }
        return String.join(" ", encodedWords);
    }

    private static final String VOWEL_SOUND_REGEX_REPLACE = "^((yt.*|xr)?[aeiou].*)$";
    private static final String CONSANANT_REGEX_REPLACE = "^(.*?)(s?qu)?([aeiou].*)$";

    private static String encodeWord(String word) {
        if (word.matches(VOWEL_SOUND_REGEX_REPLACE)) {
            return word.replaceAll(VOWEL_SOUND_REGEX_REPLACE, "$1ay");
        }
        else {
            return word.replaceAll(CONSANANT_REGEX_REPLACE, "$3$2$1ay").trim();
        }
    }
}