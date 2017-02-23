package hello;

public class Tournament {

    private final String _name;
    private final String _startDate;
    private final String _endDate;
    private final int _teamSize;
    private final int _teamCount;
    private final String _username;

    public Tournament(String name, String startDate, String endDate, 
        int teamSize, int teamCount, String username) 
    {
        this._endDate = endDate;
        this._name = name;
        this._startDate = startDate;
        this._teamCount = teamCount;
        this._teamSize = teamSize;
        this._username = username;
    }

    public String getName() {
        return _name;
    }

    public String getStartDate() {
        return _startDate;
    }

    public String getEndDate() {
        return _endDate;
    }

    public int getTeamCount() {
        return _teamCount;
    }

    public int getTeamSize() {
        return _teamSize;
    }

    public String getUsername() {
        return _username;
    }

}