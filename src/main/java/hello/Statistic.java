package hello;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Statistic {


    @JsonProperty("sportName")
    public  String sportName;
    @JsonProperty("statName")
    public  String statName;
    @JsonProperty("weight")
    public  String weight;

    public Statistic()
    {
        
    }

    public Statistic(String sportName, String statName, String weight) 
    {
        this.sportName = sportName;
        this.statName = statName;
        this.weight = weight;
    }

    public String getSportName() {
        return sportName;
    }

    public String getStatName() {
        return statName;
    }

    public String getWeight() {
        return weight;
    }

}