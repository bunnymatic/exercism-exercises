public class SpaceAge {

   private enum Period {

       EARTH(31557600.0),
       MERCURY((long)(0.2408467 * 31557600.0)),
       VENUS((long)(0.61519726 * 31557600.0)),
       MARS((long)(1.8808158 * 31557600.0)),
       JUPITER((long)(11.862615 * 31557600.0)),
       SATURN((long)(29.447498 * 31557600.0)),
       URANUS((long)(84.016846 * 31557600.0)),
       NEPTUNE((long)(164.79132 * 31557600.0));

       private double seconds;

       Period(double seconds) {
            this.seconds = seconds;
       }

       double getSeconds() {
           return this.seconds;
       }
   }

    private long seconds;

    public SpaceAge(long seconds) {
        this.seconds = seconds;
    }

    public long getSeconds() {
        return seconds;
    }

    public double onEarth() {
        return (double)this.seconds / Period.EARTH.getSeconds();
    }

    public double onMercury() {
        return (double)this.seconds / Period.MERCURY.getSeconds();
    }

    public double onVenus() {
        return (double)this.seconds / Period.VENUS.getSeconds();
    }

    public double onMars() {
        return (double)this.seconds / Period.MARS.getSeconds();
    }

    public double onJupiter() {
        return (double)this.seconds / Period.JUPITER.getSeconds();
    }

    public double onSaturn() {
        return (double)this.seconds / Period.SATURN.getSeconds();
    }

    public double onUranus() {
        return (double)this.seconds / Period.URANUS.getSeconds();
    }

    public double onNeptune() {
        return (double)this.seconds / Period.NEPTUNE.getSeconds();
    }
}