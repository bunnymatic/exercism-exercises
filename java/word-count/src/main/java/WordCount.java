import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WordCount {

    Map<String, Integer> phrase(String thePhrase) {

        String[] words = cleanPhrase(thePhrase).split( "\\s+" );

        Histogram<String> h = new Histogram<String>(words);
        return h.histogram;
    }

    private String cleanPhrase(String phrase) {
        return phrase.toLowerCase().replaceAll("[^\\w]", " ");
    }

    public static class Histogram<T> {

        private Map<T, Integer> histogram;

        public Histogram( T[] items ) {
            this.histogram = new HashMap<T, Integer>();

            for ( T item : items ) {
                histogram.put(item, histogram.getOrDefault(item, 0) + 1);
            }
        }

    }
}