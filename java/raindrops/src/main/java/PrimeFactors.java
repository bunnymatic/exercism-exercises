import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PrimeFactors {

    public static class Prime {
        private long current = 2;

        private long next() {
            long val = this.current;
            while (!isPrime(val)) {
                val += 1;
            }
            this.current = val + 1;
            return val;
        };

        public boolean isPrime(long val)
        {
            val = Math.abs(val);
            if (val < 3) {
                return true;
            }
            long upper = (long) Math.ceil(Math.sqrt((double) val));
            long x;
            for (x = 2; x < upper; ++x) {
                if ((val % x) == 0) {
                    return false;
                }
            }
            return true;
        }
    }

    public final static List<Long> primeNumbers;
    static {
        primeNumbers = new ArrayList<>();
        Prime primeGenerator = new Prime();
        long prime;
        while( (prime = primeGenerator.next()) < 900000L ) {
            primeNumbers.add(prime);
        }
    }

    public static List<Long> getForNumber(long input) {
        List<Long> result = new ArrayList<>();
        factor(input, result);
        Collections.sort(result);
        return result;
    }

    private static void factor(long input, List<Long> factors) {
        long prime;
        int primeIndex = 0;
        while( (prime = primeNumbers.get(primeIndex)) <= input ) {
            if ((input % prime) == 0) {
                factors.add(prime);
                factor(input / prime, factors);
                break;
            }
            primeIndex += 1;
        }
    }
}