import java.util.ArrayList;
import java.util.List;

public class Allergies {

    private List<Allergen> allergens;

    public Allergies(int allergenCode) {
        this.allergens = computeAllergens(allergenCode);
    }

    private List<Allergen> computeAllergens(int allergenCode) {
        List<Allergen> allergens = new ArrayList<>();
        for ( Allergen allergen : Allergen.values() ) {
            if ( (allergen.getScore() & allergenCode) > 0) {
                allergens.add(allergen);
            }
        }
        return allergens;
    }

    public boolean isAllergicTo(Allergen stuff) {
        return !(this.allergens.indexOf(stuff) == -1);
    }

    public List<Allergen> getList() {
        return this.allergens;
    }
}