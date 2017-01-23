import java.util.ArrayList;
import java.util.List;

import static java.util.function.Function.identity;
import static java.util.stream.Collectors.toList;

public class Triangle {

    private List<Double> sides;
    private List<Double> original;
    private final double EPSILON = Math.pow(10,-8);

    public Triangle(double side1, double side2, double side3) throws TriangleException {
        List<Double> sides = new ArrayList<>();
        sides.add(side1);
        sides.add(side2);
        sides.add(side3);
        this.sides = sides.stream().sorted().collect(toList());
        this.validate();
    }

    private void validate() throws TriangleException {
        if (violatesPositivity() || violatesInequality()) {
            throw new TriangleException();
        }
    }

    public TriangleKind getKind() {
        if (sides.stream().allMatch(s -> isEqual(s, sides.get(0)))) {
            return TriangleKind.EQUILATERAL;
        }
        if ( isEqual(sides.get(1), sides.get(0)) || isEqual(sides.get(1), sides.get(2)) ) {
            return TriangleKind.ISOSCELES;
        }
        return TriangleKind.SCALENE;
    }

    private boolean violatesInequality() {
        return (sides.get(0) + sides.get(1) <= sides.get(2));
    }

    private boolean violatesPositivity() {
        return this.sides.stream().anyMatch( side -> isEqual(side, 0.0) );
    }

    private boolean isEqual(double d1, double d2) {
        return Math.abs(d1 - d2) < EPSILON;
    }

//    private double area() {
//        double s = sides.stream().reduce(0.0, Double::sum)/2.0;
//        double areaSquared = s * ( s - sides.get(0) ) * ( s - sides.get(1) ) * ( s - sides.get(2) );
//        return areaSquared;
//    }

//    @Override
//    public String toString() {
//        return this.original.stream().map(side -> String.format("%4.4f ", side)).reduce("", String::concat);
//    }
}