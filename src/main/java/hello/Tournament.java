package hello;

public class Tournament {

    private final String _name;
    private final java.util.Date _startDate;
    private final java.util.Date _endDate;
    private final int _teamSize;
    private final int _teamCount;
    private final String _username;

    public Tournament(String name, java.util.Date startDate, java.util.Date endDate, 
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

    public java.util.Date getStartDate() {
        return _startDate;
    }

    public java.util.Date getEndDate() {
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