import java.util.ArrayList;
import java.util.List;

public class Crypto {

    private String input;

    private String normalizedPlaintext;

    public Crypto(String input) {
        this.input = input;
    }

    public String getNormalizedPlaintext() {
        return this.normalizedPlaintext = clean(input);
    }

    public int getSquareSize() {
        return (int)Math.ceil(Math.sqrt((double)getNormalizedPlaintext().length()));
    }

    public List<String> getPlaintextSegments() {
        List<String> segments = new ArrayList<>();
        int start = 0;
        int end = start;
        int len = getNormalizedPlaintext().length();
        while(true) {
            end += getSquareSize();
            if (end >= len)  { end = len; }
            segments.add(getNormalizedPlaintext().substring(start, end));
            start += getSquareSize();
            if (start >= len) { break; }
        }
        return segments;
    }

    public String getCipherText() {
        return clean(getNormalizedCipherText()).trim();
    }

    public String getNormalizedCipherText() {
        List<String> segments = getPlaintextSegments();
        StringBuilder builder = new StringBuilder();
        for (int j = 0; j < getSquareSize(); j++) {
            for (String segment: segments) {
                if (j < segment.length()) {
                    builder.append(segment.charAt(j));
                }
            }
            builder.append(' ');
        }
        return builder.toString().trim();
    }

    private String clean(String input) {
        return input.toLowerCase().replaceAll("[\\s\\p{Punct}]+", "");
    }
}