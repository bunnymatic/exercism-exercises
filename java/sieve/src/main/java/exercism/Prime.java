package exercism;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Prime {
    private long current = 2;

    public long next() {
        long val = this.current;
        while (!isPrime(val)) {
            val += 1;
        }
        this.current = val + 1;
        return val;
    };

    public static boolean isPrime(long val)
    {
        val = Math.abs(val);
        if (val <= 3) {
            return true;
        }
        long upper = (long) Math.ceil(Math.sqrt((double) val));
        long x;
        for (x = 2; x <= upper; x++) {
            if ((val % x) == 0) {
                return false;
            }
        }
        return true;
    }

    public void reset() {
        this.current = 2;
    }
}