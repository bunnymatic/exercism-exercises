public class Hexadecimal {

    public static int toDecimal(String hex) {
        if (!valid(hex)) {
            return 0;
        }

        int value = 0;
        boolean negate = false;
        if (hex.charAt(0) == '-') {
            negate = true;
            hex = hex.substring(1);
        }
        int len = hex.length();
        for (int idx = 0; idx < hex.length(); ++idx) {
            int multiplier = (int)Math.pow(16.0, (double)(len - idx - 1));
            value += (charToValue(hex.charAt(idx))) * multiplier;
        }
        return value;
    }

    private final static String valueLut= "0123456789abcdef";

    private static int charToValue(char c) {
        return valueLut.indexOf(c);
    }

    private static boolean valid(String hex) {
        return hex.matches("^[\\p{Punct}\\dabcdef]+");
    }
}