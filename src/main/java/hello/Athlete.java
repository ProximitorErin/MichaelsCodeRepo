package hello;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Athlete {


    @JsonProperty("image")
    public  String image;
    @JsonProperty("text")
    public  String text;

    public Athlete()
    {
        
    }

    public Athlete(String image, String text) 
    {
        this.image = image;
        this.text = text;
    }

    public String getImage() {
        return image;
    }

    public String getText() {
        return text;
    }

}