package hello;

public class Statistic {

    private final String _sportName;
    private final String _statName;
    private final String _weight;

    public Statistic(String sportName, String statName, String weight) 
    {
        this._sportName = sportName;
        this._statName = statName;
        this._weight = weight;
    }

    public String getSportName() {
        return _sportName;
    }

    public String getStatName() {
        return _statName;
    }

    public String getWeight() {
        return _weight;
    }

}