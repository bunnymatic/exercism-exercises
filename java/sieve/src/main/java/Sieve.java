import exercism.Prime;

import java.util.ArrayList;
import java.util.List;

public class Sieve {

    private int limit;

    public Sieve(int limit) {
        this.limit = limit;
    }

    public List<Integer> getPrimes() {
        Prime primeGenerator = new Prime();
        List<Integer> primes = new ArrayList<>();
        int nextPrime;
        while ( (nextPrime = (int)primeGenerator.next()) <= limit ) {
            primes.add((int)nextPrime);
        }
        return primes;
    }
}