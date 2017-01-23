public class Trinary {

//    NOTE: in real life, i'd just let java (parseInt) do this for me as below
//
//    public static int toDecimal(String trinary) {
//        if (!valid(trinary)) {
//            return 0;
//        }
//        return Integer.parseInt(trinary, 3);
//    }
//

    public static int toDecimal(String trinary) {
        if (!valid(trinary)) {
            return 0;
        }

        int value = 0;
        final int zero = '0';
        boolean negate = false;
        if (trinary.charAt(0) == '-') {
            negate = true;
            trinary = trinary.substring(1);
        }
        int len = trinary.length();
        for (int idx = 0; idx < trinary.length(); ++idx) {
            int multiplier = (int)Math.pow(3.0, (double)(len - idx - 1));
            value += (trinary.charAt(idx) - zero) * multiplier;
        }
        return value;
    }

    private static boolean valid(String trinary) {
        return trinary.matches("^[012]+");
    }
}