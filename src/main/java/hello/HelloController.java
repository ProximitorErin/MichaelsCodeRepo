package hello;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@RestController
public class HelloController {

	/* createTournament(size: number, count: number, stats: IStatistic[]) */

	@RequestMapping("/createTournamentService")
    public @ResponseBody String createTournament (
		@RequestParam(value="name") String name,
		@RequestParam(value="start") String start,
		@RequestParam(value="end") String end,
		@RequestParam(value="size") int size,
		@RequestParam(value="count") int count,
		@RequestParam(value="stats") List<Statistic> stats)
	{
		return "success: got " + stats.size() + " stats";
    }

	@RequestMapping("/getStatsByDate")
    public @ResponseBody List<Statistic> getStatsByDate(@RequestParam(value="startDate") String startDate,
		@RequestParam(value="endDate") String endDate) {
		List<Statistic> list = new ArrayList<Statistic>();
		// Leave the blank row here, so we can have a blank row in the combo
		list.add(new Statistic("", "", null));
		list.add(new Statistic("Swimming", "Laps", null));
		list.add(new Statistic("Soccer", "Saves", null));
        return list;
    }

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
