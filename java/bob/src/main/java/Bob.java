public class Bob {

    private final String YELLING_RESPONSE = "Whoa, chill out!";
    private final String DEFAULT_RESPONSE = "Whatever.";
    private final String SILENCE_RESPONSE = "Fine. Be that way!";
    private final String QUESTION_RESPONSE = "Sure.";

    public String hey(String sentence) {
        String trimmedSentence = sentence.trim();
        String cleanedSentence = trimmedSentence.replaceAll("[\\s\\p{Punct}]", "");
        if (trimmedSentence.isEmpty()) {
            return SILENCE_RESPONSE;
        }
        else if (isYelling(cleanedSentence)) {
            return YELLING_RESPONSE;
        }
        else if (isQuestion(sentence)) {
            return QUESTION_RESPONSE;
        }
        return DEFAULT_RESPONSE;
    }

    boolean isYelling(String cleanSentence) {
        return !cleanSentence.matches("^\\d+") && (cleanSentence.equals(cleanSentence.toUpperCase()));
    }
    boolean isQuestion(String sentence) {
        return sentence.charAt(sentence.length() - 1) == '?';
    }
}