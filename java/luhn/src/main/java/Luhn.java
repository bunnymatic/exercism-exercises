import java.util.ArrayList;
import java.util.List;

public class Luhn {

    private long value;
    public Luhn(long value) {
        this.value = value;
    }

    public int getCheckDigit() {
        int[] addends = getAddends();
        return addends[addends.length - 1];
    }

    public int[] getAddends() {
        List<Integer> addends = new ArrayList<>();
        long tmp = this.value;
        int index = 0;
        while (tmp > 0) {
            long val;
            if (index % 2 == 0) {
                val = tmp % 10;
            } else {
                val = (tmp % 10) * 2;
                if (val > 10) {
                    val -= 9;
                }
            }
            addends.add(0, (int)val);
            index += 1;
            tmp /= 10;
        }
        return addends.stream().mapToInt( a -> a ).toArray();
    }

    public int getCheckSum() {
        int ck = 0;
        for (int v: getAddends()) {
            ck += v;
        }
        return ck;
    }

    public boolean isValid() {
        return (getCheckSum() % 10) == 0;
    }

    public static long create(long val) {
        long testVal = val * 10;
        Luhn luhn = new Luhn(testVal);
        if (luhn.isValid()) {
            return testVal;
        }
        else {
            return testVal + (10 - (luhn.getCheckSum() % 10));
        }
    }
}