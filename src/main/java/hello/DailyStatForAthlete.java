package hello;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class DailyStatForAthlete {


    @JsonProperty("data")
    public  List<Integer> data;
    @JsonProperty("label")
    public  String label;

    public DailyStatForAthlete()
    {
        
    }

    public DailyStatForAthlete(List<Integer> data, String label) 
    {
        this.data = data;
        this.label = label;
    }

    public List<Integer> getData() {
        return data;
    }

    public String getLabel() {
        return label;
    }

}