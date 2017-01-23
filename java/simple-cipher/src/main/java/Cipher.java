import java.util.Random;

public class Cipher {

    private String key;

    public Cipher() {
        this(RandomLetters.letters(100));
    }

    public Cipher(String key) {
        if (!valid(key)) {
            throw new IllegalArgumentException(String.format("The submitted key %s is not a valid cipher key", key));
        }
        this.key = key;
    }
    public String getKey() {
        return key;
    }

    public String encode(String input) {
        StringBuilder builder = new StringBuilder();
        int index = 0;
        for (char c: input.toCharArray()) {
            char keyLetter = key.charAt(index);
            builder.append(encodeLetter(keyLetter, c));
            index++;
        }
        return builder.toString();
    }

    private char encodeLetter(char letter, char keyLetter) {
        return (char)(((keyLetter + letter - 2*'a') % 26) + 'a');
    }

    private char decodeLetter(char letter, char keyLetter) {
        return (char)(((keyLetter - letter + 26) % 26) + 'a');
    }


    public String decode(String input) {
        StringBuilder builder = new StringBuilder();
        int index = 0;
        for (char c: input.toCharArray()) {
            char keyLetter = key.charAt(index);
            builder.append(decodeLetter(keyLetter, c));
            index++;
        }
        return builder.toString();
    }

    private boolean valid(String key) {
        if (!key.isEmpty() && (key.toLowerCase().equals(key)) && key.matches("^[a-z]+$")) {
            return true;
        }
        return false;
    }

    private static class RandomLetters {

        public static Random rand = new Random();

        public static char letter() {
            return (char) ('a' + rand.nextInt(26));
        }

        public static String letters(int num) {
            int i;
            StringBuilder builder = new StringBuilder();
            for (i = 0; i < num; i++) {
                builder.append(letter());
            }
            return builder.toString();
        }

    }
}