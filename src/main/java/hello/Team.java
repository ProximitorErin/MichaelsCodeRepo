package hello;

public class Team {

    private final String _name;
    private final int _wins;
    private final String _username;
    private final String _tournamentName;
    private final java.util.Date _tournamentStart;
    private final java.util.Date _tournamentEnd;

    public Team(String name, int wins, String username, String tournamentName, 
    java.util.Date tournamentStart, java.util.Date tournamentEnd)
    {
        this._name = name;
        this._wins = wins;
        this._username = username;
        this._tournamentName = tournamentName;
        this._tournamentStart = tournamentStart;
        this._tournamentEnd = tournamentEnd;
    }
    public String getName() {
        return _name;
    }
    public int getWins(){
        return _wins;
    }
    public String getUsername(){
        return _username;
    }
    public String getTournamentName(){
        return _tournamentName;
    }
    public java.util.Date getTournamentStart(){
        return _tournamentStart;
    }
    public java.util.Date getTournamentEnd(){
        return _tournamentEnd;
    }
    

}