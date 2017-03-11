package hello;

public class CurrentSportAverage {

    private final String _sportName;
    private final String _statName;
    private final float _statValue;

    public CurrentSportAverage(String sportName, String statName, float statValue) 
    {
        this._sportName = sportName;
        this._statName = statName;
        this._statValue = statValue;
    }

    public String getSportName() {
        return _sportName;
    }

    public String getStatName() {
        return _statName;
    }

    public float getStatValue() {
        return _statValue;
    }

}