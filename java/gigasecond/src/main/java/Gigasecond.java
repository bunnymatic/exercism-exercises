import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Gigasecond {

    private final long GIGASECOND = (long)Math.pow(10.0, 9.0);
    private LocalDateTime date;

    Gigasecond(LocalDate date) {
        this.date = LocalDateTime.of( date, LocalTime.of(0,0));
    }

    Gigasecond(LocalDateTime date) {
        this.date = date;
    }

    public LocalDateTime getDate() {
        return date.plusSeconds( GIGASECOND );
    }
}