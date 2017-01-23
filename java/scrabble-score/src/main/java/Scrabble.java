import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import static java.util.stream.Collectors.toList;

public class Scrabble {

    private IntStream chars;

    private final ScoreTable scoring = new ScoreTable();

    public Scrabble(String word) {
        if (word == null) {
            word = "";
        }
        this.chars = word.toLowerCase().trim().replace("[\\p{L}]+", "").chars();
    }

    public int getScore() {
        return this.chars.map( charAsInt -> scoring.getOrDefault(charAsInt, 1) ).sum();
    }

    public static class ScoreTable extends HashMap<Integer, Integer> {

        private static class Score {
            String letters;
            int score;

            public static Score of(int score, String letters) {
                return new Score(score, letters);
            }

            Score(int score, String letters){
                this.score = score;
                this.letters = letters;
            }
        }

        public ScoreTable() {
            List<Score> listOfScores = new ArrayList<>();
            listOfScores.add(Score.of(10, "QZ"));
            listOfScores.add(Score.of(8, "JX"));
            listOfScores.add(Score.of(2, "DG"));
            listOfScores.add(Score.of(3, "BCMP"));
            listOfScores.add(Score.of(4, "FHVWY"));
            listOfScores.add(Score.of(5, "K"));
            listOfScores.stream().forEach( score ->
                score.letters.toLowerCase().chars().forEach( charAsInt -> this.put(charAsInt, score.score) )
            );
        }
    }
}