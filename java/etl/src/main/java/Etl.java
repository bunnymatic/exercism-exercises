import java.util.AbstractMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Etl {
    public Map<String, Integer> transform(Map<Integer, List<String>> old) {

        HashMap<String, Integer> mapByLetter = new HashMap<String, Integer>();
        old.forEach( (score, letters) ->
            letters.stream().forEach(letter -> mapByLetter.put(letter.toLowerCase(), score) )
        );
        return mapByLetter;
    }
}