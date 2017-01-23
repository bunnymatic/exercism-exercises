import org.omg.IOP.ENCODING_CDR_ENCAPS;

import java.util.stream.Collectors;

public class Atbash {

    public enum Direction {
        ENCODE, DECODE
    }

    public static String encode(String input) {
        return process(input, Direction.ENCODE);
    }

    public static String decode(String input) {
        return process(input, Direction.DECODE);
    }

    private static String process(String input, Direction direction) {
        StringBuilder builder = new StringBuilder();
        input = input.toLowerCase().replaceAll("[\\s\\p{Punct}]+", "");
        for (int ii = 0; ii < input.length(); ++ii) {
            builder.append(encodeLetter( input.charAt(ii) ));
            if ((direction == Direction.ENCODE) && ((ii+1) % 5 == 0)) {
                builder.append(' ');
            }
        }
        return builder.toString().trim();
    }

    private static final int ZZ = (int)'z';
    private static final int AA = (int)'a';

    private static boolean isALetter(char letter) {
        return letter >= AA && letter <= ZZ;
    }

    public static char encodeLetter(char letter) {
        if (isALetter(letter)) {
            return (char) (ZZ + AA - letter);
        }
        else {
            return letter;
        }
    }
}