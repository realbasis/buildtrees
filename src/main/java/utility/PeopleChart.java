package utility;

/**
 * Profiles (people) created over time (admin statistics).
 * Formerly a Cewolf DatasetProducer; now rendered as inline SVG by {@link ActivityChart}.
 */
public class PeopleChart extends ActivityChart {

    private static final long serialVersionUID = 1L;

    public PeopleChart() {
        super("People Activity", "CreationDate");
    }
}
