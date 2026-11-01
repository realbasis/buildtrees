package utility;

/**
 * Accounts created over time (admin statistics).
 * Formerly a Cewolf DatasetProducer; now rendered as inline SVG by {@link ActivityChart}.
 */
public class AccountsChart extends ActivityChart {

    private static final long serialVersionUID = 1L;

    public AccountsChart() {
        super("Accounts Activity", "CreationDate");
    }
}
