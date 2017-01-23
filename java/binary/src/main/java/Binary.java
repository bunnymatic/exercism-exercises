public class Binary {
    private String binary;

    public Binary(String binary) {
        this.binary = binary;
    }

    public int getDecimal() {
        if (!valid()) { return 0; }

        int value = 0;
        int len = binary.length();
        char[] chars = binary.toCharArray();

        int val = 1;
        for( int pos = len-1; pos >= 0; pos-- ) {
            if (chars[pos] == '1') {
                value += val;
            }
            val <<= 1;
        }
        return value;
    }

    private boolean valid() {
        return (binary != null && binary.length() != 0 && binary.matches("^[01]*$"));
    }
}