import java.util.Random;

public class Robot {

    private static final char[] LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();

    private String name;
    private Random rnd;

    public Robot() {
        this.rnd = new Random();
        reset();
    }
    public String getName() {
        return name;
    }

    public void reset() {
        this.name = generateName();
    }

    private String generateName() {
        return String.format("%c%c%03d", randomLetter(), randomLetter(), randomNumber());
    }

    private char randomLetter() {
        return LETTERS[rnd.nextInt(26)];
    }

    private int randomNumber() {
        return rnd.nextInt(1000);
    }

}