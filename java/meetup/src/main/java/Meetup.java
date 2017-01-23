import org.joda.time.DateTime;

public class Meetup {

    private int month;
    private int year;
    private DateTime firstDayOfTheMonth;

    public Meetup(int month, int year) {
        this.month = month;
        this.year = year;
    }

    public DateTime day(int dayOfWeek, MeetupSchedule repeat) {
        DateTime date = new DateTime(year, month, 1, 0, 0);
        while( dayOfWeek != date.getDayOfWeek() ) {
            date = date.plusDays(1);
        }
        switch( repeat ) {
            case SECOND:
                date = date.plusWeeks(1);
                break;
            case THIRD:
                date = date.plusWeeks(2);
                break;
            case FOURTH:
                date = date.plusWeeks(3);
                break;
            case LAST:
                date = date.plusWeeks(3);
                if (date.plusWeeks(1).getMonthOfYear() == month) {
                    date = date.plusWeeks(1);
                }
                break;
            case TEENTH:
                int day = date.getDayOfMonth();
                while (!(( day < 20 ) && (day > 12))) {
                    date = date.plusWeeks(1);
                    day = date.getDayOfMonth();
                }
                break;
            case FIRST:
            default:
                break;
        }
        return date;
//        return DateTime.now();
    }

}