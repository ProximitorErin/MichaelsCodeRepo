package hello;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import org.springframework.jdbc.datasource.DataSourceUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

@RestController

public class HelloController {

	@Autowired
	private ApplicationContext ctx;

	/* createTournament(size: number, count: number, stats: IStatistic[]) */

	@RequestMapping("/createTournamentService")
    public @ResponseBody String createTournament (
		@RequestParam(value="name") String name,
		@RequestParam(value="start") String start,
		@RequestParam(value="end") String end,
		@RequestParam(value="size") int size,
		@RequestParam(value="count") int count,
		@RequestParam(value="stats") String stats)
	{
		ObjectMapper mapper = new ObjectMapper();
		try {
		Statistic[] obj = mapper.readValue(stats, Statistic[].class);
		return "success: " + obj.length;
	} catch (JsonGenerationException e) {
    	e.printStackTrace();
	} catch (JsonMappingException e) {
    	e.printStackTrace();
	} catch (IOException e) {
    	e.printStackTrace();
	}
		return "failure";
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

			// Retrieve the data source from the application context

			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");
			//ds.setPassword(System.getenv("DB_PASSWORD"));
		// Open a database connection using Spring's DataSourceUtils
		Connection c = DataSourceUtils.getConnection(ds);
		try {
			// retrieve a list of three random cities
			PreparedStatement ps = c.prepareStatement(
				"SELECT * FROM michaelsdb.Users WHERE name='" + username + 
					"' and password = '" + password + "'");
			ResultSet rs = ps.executeQuery();
			Boolean isAdmin = false;

			if (rs.next()) {
				isAdmin = rs.getBoolean("isAdmin");
				
				if (isAdmin)
				{
					return "admin";
				}
				else
				{
					return "player";
				}
			}
			else
			{
				return "failure";
			}

		} catch (SQLException ex) {
			// something has failed and we print a stack trace to analyse the error
			
			// ignore failure closing connection
			try { c.close(); } catch (SQLException e) { return "" + e; }

			return ""+ex;

		} finally {
			// properly release our connection
		}
		
    }

	@RequestMapping("/tryUsingConnectionPool")
	public String checkPoolUse()
	{
		// Retrieve the data source from the application context

			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");
			ds.setPassword(System.getenv("DB_PASSWORD"));
		// Open a database connection using Spring's DataSourceUtils
		Connection c = DataSourceUtils.getConnection(ds);
		try {
			// retrieve a list of three random cities
			PreparedStatement ps = c.prepareStatement(
				"SELECT * FROM michaelsdb.Users");
			ResultSet rs = ps.executeQuery();
			String name = "";
			while(rs.next()) {
				name = rs.getString("name");
			}
			return name;
		} catch (SQLException ex) {
			// something has failed and we print a stack trace to analyse the error
			
			// ignore failure closing connection
			try { c.close(); } catch (SQLException e) { return "" + e; }

			return ""+ex;

		} finally {
			// properly release our connection
			DataSourceUtils.releaseConnection(c, ds);
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
