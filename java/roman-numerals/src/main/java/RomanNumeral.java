import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.IntStream;

public class RomanNumeral {

    private Integer number;

    private static class NumeralValue {
        String numeral;
        Integer value;
        NumeralValue(String numeral, Integer value) {
            this.numeral = numeral;
            this.value = value;
        }
    }

    private static final NumeralValue[] numeralLut = new NumeralValue[] {
        new NumeralValue("M", 1000),
        new NumeralValue("CM", 900),
        new NumeralValue("D", 500),
        new NumeralValue("CD", 400),
        new NumeralValue("C", 100),
        new NumeralValue("XC", 90),
        new NumeralValue("L", 50),
        new NumeralValue("XL", 40),
        new NumeralValue("X", 10),
        new NumeralValue("IX", 9),
        new NumeralValue("V", 5),
        new NumeralValue("IV", 4),
        new NumeralValue("I", 1),
    };
    
    public RomanNumeral(int number) {
        this.number = number;
    }

    public String getRomanNumeral() {
        return getNextRomanNumeral(number);
    }

    private String getNextRomanNumeral(Integer number) {
        String result = "";
        for ( NumeralValue nv : numeralLut ) {
            while (number >= nv.value) {
                result = result + nv.numeral;
                number = number - nv.value;
            }
        }
        return result;
    }
}