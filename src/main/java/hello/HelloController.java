package hello;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

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
		
        return "Greetings 6 from Spring Boot: " + findings;
    }

}
