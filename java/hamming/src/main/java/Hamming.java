public class Hamming {

    public static int compute(String seq1, String seq2) {
        if (seq1.length() != seq2.length()) {
            throw new IllegalArgumentException("Strands are not the same length");
        }
        char[] chars = seq1.toCharArray();
        char[] chars2 = seq2.toCharArray();
        int len = chars.length;
        int diff = 0;
        for (int i = 0; i < len; i++ ) {
            if (chars[i] != chars2[i])
            {
                diff = diff + 1;
            }
        }
        return diff;
    }
}