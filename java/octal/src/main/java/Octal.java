public class Octal {

    private String octal;

    public Octal(String input) {
        this.octal = input;
    }

    public int getDecimal() {
        if (!valid()) {
            return 0;
        }

        int value = 0;
        final int zero = '0';
        boolean negate = false;
        if (octal.charAt(0) == '-') {
            negate = true;
            octal = octal.substring(1);
        }
        int len = octal.length();
        for (int idx = 0; idx < octal.length(); ++idx) {
            int multiplier = (int)Math.pow(8.0, (double)(len - idx - 1));
            value += (octal.charAt(idx) - zero) * multiplier;
        }
        return value;
    }

    private boolean valid() {
        return octal.matches("^[0-7]+$");
    }
}