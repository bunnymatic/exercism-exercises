import java.util.HashMap;
import java.util.Map;

public class DNA {

    private String dna;
    private HashMap<Character, Integer> tally;

    private static char[] NUCLEOTIDES = new char[] {'A', 'C', 'G', 'T'};

    DNA(String s) {
        this.dna = (s == null) ? "" : s;
        this.tally = buildMap();
    }

    public Integer count(Character nucleotide) {
        if (!contains(NUCLEOTIDES, nucleotide)) {
            String msg = String.format("%s is not a nucleotide", nucleotide);
            throw new IllegalArgumentException(msg);
        }
        return tally.get(nucleotide);
    }

    public Map<Character, Integer> nucleotideCounts() {
        return tally;
    }

    private HashMap<Character, Integer> buildMap() {
        HashMap<Character, Integer> map = new HashMap<>();
        for (char n : NUCLEOTIDES) {
            map.put(n, 0);
        }
        for (char nuc : this.dna.toCharArray()) {
            Integer val = map.get(nuc);
            map.put(nuc, val + 1);
        }
        return map;
    }

    private boolean contains(char[] chars, char ch) {
        for (char c : chars) {
            if (c == ch) { return true; }
        }
        return false;
    }
}