/**
 * Created by jon on 8/7/16.
 */
public class PhoneNumber {

    private String phoneNumber;
    private String areaCode;
    private String prefix;
    private String suffix;

    public PhoneNumber(String s) {
        this.phoneNumber = s.replaceAll("[^\\d]+", "");
        process();
    }

    private void process() {
        if (valid()) {
            if (phoneNumber.length() == 11) {
                this.phoneNumber = this.phoneNumber.substring(1);
            }
            this.areaCode = this.phoneNumber.substring(0,3);
            this.prefix = this.phoneNumber.substring(3,6);
            this.suffix = this.phoneNumber.substring(6);
        } else {
            this.prefix = "000";
            this.areaCode = "000";
            this.suffix = "0000";
        }
    }

    private boolean valid() {
        return (phoneNumber.length() == 10) || (phoneNumber.length() == 11 && phoneNumber.charAt(0) == '1' );
    }

    public String getNumber() {
        return areaCode + prefix + suffix;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public String pretty() {
        return String.format("(%s) %s-%s", areaCode, prefix, suffix);
    }
}