package hello;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RestController
public class HelloController {

	@RequestMapping("/getTournaments")
    public @ResponseBody List<Tournament> getTournaments() {
		List<Tournament> list = new ArrayList<Tournament>();
		list.add(new Tournament("hello", "3/4/73", "6/1/99", 3, 5, "derek"));
		list.add(new Tournament("bye", "6/6/66", "7/4/87", 7, 7, "michael"));
        return list;
    }

	@RequestMapping("/login")
    public String greeting(@RequestParam(value="username") String username,
		@RequestParam(value="password") String password) {
			if (username.equals("derek"))
			{
				return "player";
			}
			else
			{
				return "admin";
			}
    }

    @RequestMapping("/")
    public String index() {
    	
    	String dbPassword = System.getenv("DB_PASSWORD");
    	String findings = "";
    	
    	try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            findings += ex;
        }
		
		Connection conn = null;
		
		try {
		    conn =
		       DriverManager.getConnection("jdbc:mysql://michaelsinstance.cg5hjai80h9e.us-east-1.rds.amazonaws.com:3306/michaelsdb?" +
		                                   "user=michael&password=" + dbPassword);

		    
		} catch (SQLException ex) {
		    // handle any errors
		    findings += ex;
		}
		
		findings += "clean!";
		
        return "Greetings 7 from Spring Boot: " + findings;
    }

}
