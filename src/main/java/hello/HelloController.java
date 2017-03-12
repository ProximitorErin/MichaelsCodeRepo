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
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

@RestController

public class HelloController {

	@Autowired
	private ApplicationContext ctx;

	@RequestMapping("/getSingleAverage")
    public @ResponseBody String getSingleAverage (
		@RequestParam(value="sport1") String sport1,
		@RequestParam(value="stat1") String stat1,
		@RequestParam(value="sport2") String sport2,
		@RequestParam(value="stat2") String stat2)
	{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			// Retrieve the data source from the application context
			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

			// Open a database connection using Spring's DataSourceUtils
			Connection c = DataSourceUtils.getConnection(ds);

			try {
				
				PreparedStatement ps = c.prepareStatement("select AVG(A1.scoreMetric)/AVG(A2.scoreMetric) AS answer " +
        "FROM michaelsdb.AthletePerformanceInEvent as A1, michaelsdb.AthletePerformanceInEvent as A2 " +
        "WHERE A1.athleteID=A2.athleteID AND A1.eventName=A2.eventName AND A1.date=A2.date AND A1.place=A2.place " +
            "AND A1.sportName = ? " +
			"AND A1.statName = ? " +
			"AND A2.sportName = ? " +
			"AND A2.statName = ? " +
            "AND A2.scoreMetric > 0");

				ps.setString(1, sport1);
				ps.setString(2, stat1);
				ps.setString(3, sport2);
				ps.setString(4, stat2);
				
				ResultSet rs = ps.executeQuery();

				if (rs.next()) {
					return rs.getString("answer");
				} 

			} catch (Exception ex) {
				ex.printStackTrace();
				return "failure";
			} finally {
				// properly release our connection
				// ignore failure closing connection
				try { c.close(); } catch (SQLException e) { return "failure"; }
			}

			return "failure";
		
    }

	@RequestMapping("/increaseTeamCountByOne")
    public @ResponseBody String increaseTeamCountByOne (
		@RequestParam(value="name") String name,
		@RequestParam(value="start") String txtStartDate,
		@RequestParam(value="end") String txtEndDate)
	{

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			// Retrieve the data source from the application context
			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

			// Open a database connection using Spring's DataSourceUtils
			Connection c = DataSourceUtils.getConnection(ds);

			try {
				
				java.util.Date startDate = formatter.parse(txtStartDate);
				java.util.Date endDate = formatter.parse(txtEndDate);
				
				PreparedStatement ps = c.prepareStatement("UPDATE michaelsdb.Tournaments SET teamCount = teamCount + 1 "
						+ "WHERE NAME = ? "
						+ "AND StartDate = ? "
						+ "AND EndDate = ?");
				ps.setString(1, name);
				ps.setDate(2, new java.sql.Date(startDate.getTime()));
				ps.setDate(3, new java.sql.Date(endDate.getTime()));
				
				ps.executeUpdate();

				return "success";

			} catch (Exception ex) {
				ex.printStackTrace();
				return "failure";
			} finally {
				// properly release our connection
				// ignore failure closing connection
				try { c.close(); } catch (SQLException e) { return "failure"; }
			}
		
    }

	@RequestMapping("/deleteTournament")
    public @ResponseBody String deleteTournament (
		@RequestParam(value="name") String name,
		@RequestParam(value="start") String txtStartDate,
		@RequestParam(value="end") String txtEndDate)
	{

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			// Retrieve the data source from the application context
			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

			// Open a database connection using Spring's DataSourceUtils
			Connection c = DataSourceUtils.getConnection(ds);

			try {
				
				java.util.Date startDate = formatter.parse(txtStartDate);
				java.util.Date endDate = formatter.parse(txtEndDate);

				PreparedStatement ins = c.prepareStatement("DELETE FROM michaelsdb.TournamentPerformanceScoring "
					+ "WHERE TournamentName = ? "
						+ "AND tournamentStart = ? "
						+ "AND tournamentEnd = ?");
				ins.setString(1, name);
				ins.setDate(2, new java.sql.Date(startDate.getTime()));
				ins.setDate(3, new java.sql.Date(endDate.getTime()));
				ins.executeUpdate();
				
				PreparedStatement ps = c.prepareStatement("DELETE FROM michaelsdb.Tournaments "
						+ "WHERE NAME = ? "
						+ "AND StartDate = ? "
						+ "AND EndDate = ?");
				ps.setString(1, name);
				ps.setDate(2, new java.sql.Date(startDate.getTime()));
				ps.setDate(3, new java.sql.Date(endDate.getTime()));
				
				ps.executeUpdate();

				return "success";

			} catch (Exception ex) {
				ex.printStackTrace();
				return "failure";
			} finally {
				// properly release our connection
				// ignore failure closing connection
				try { c.close(); } catch (SQLException e) { return "failure"; }
			}
		
    }

	@RequestMapping("/createTournamentService")
    public @ResponseBody String createTournament (
		@RequestParam(value="name") String name,
		@RequestParam(value="start") String txtStartDate,
		@RequestParam(value="end") String txtEndDate,
		@RequestParam(value="size") int size,
		@RequestParam(value="count") int count,
		@RequestParam(value="username") String username,
		@RequestParam(value="stats") String stats)
	{
		ObjectMapper mapper = new ObjectMapper();
		try {
			Statistic[] obj = mapper.readValue(stats, Statistic[].class);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			List<Statistic> list = new ArrayList<Statistic>();

			// Retrieve the data source from the application context
			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

			// Open a database connection using Spring's DataSourceUtils
			Connection c = DataSourceUtils.getConnection(ds);
			try {
				java.util.Date startDate = formatter.parse(txtStartDate);
				java.util.Date endDate = formatter.parse(txtEndDate);
				// retrieve a list of three random cities
				PreparedStatement ps = c.prepareStatement("INSERT INTO michaelsdb.Tournaments "
						+ "(name, startdate, enddate, teamsize, teamcount, adminname) "
						+ "VALUES (?, ?, ?, ?, ?, ?)"
						);
				ps.setString(1, name);
				ps.setDate(2, new java.sql.Date(startDate.getTime()));
				ps.setDate(3, new java.sql.Date(endDate.getTime()));
				ps.setInt(4, size);
				ps.setInt(5, count);
				ps.setString(6, username);
				
				ps.executeUpdate();

				for (Statistic item : obj) {
					PreparedStatement ins = c.prepareStatement("INSERT INTO michaelsdb.TournamentPerformanceScoring " +
					"(tournamentName, tournamentStart, tournamentEnd, sportName, statName, statWeight) "+
					"VALUES (?, ?, ?, ?, ?, ?)");
					ins.setString(1, name);
					ins.setDate(2, new java.sql.Date(startDate.getTime()));
					ins.setDate(3, new java.sql.Date(endDate.getTime()));
					ins.setString(4, item.getSportName());
					ins.setString(5, item.getStatName());
					float f = Float.parseFloat(item.getWeight());
					ins.setFloat(6, f);
					ins.executeUpdate();
				}

				return "success: " + obj.length;

			} catch (Exception ex) {
				ex.printStackTrace();
				return "failure";
			} finally {
				// properly release our connection
				// ignore failure closing connection
				try { c.close(); } catch (SQLException e) { return "failure"; }
			}
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
    public @ResponseBody List<Statistic> getStatsByDate(@RequestParam(value="startDate") String txtStartDate,
		@RequestParam(value="endDate") String txtEndDate) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		List<Statistic> list = new ArrayList<Statistic>();
		// Leave the blank row here, so we can have a blank row in the combo
		list.add(new Statistic("", "", null));

		// Retrieve the data source from the application context
		BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

		// Open a database connection using Spring's DataSourceUtils
		Connection c = DataSourceUtils.getConnection(ds);
		try {
			java.util.Date startDate = formatter.parse(txtStartDate);
			java.util.Date endDate = formatter.parse(txtEndDate);
			// retrieve a list of three random cities
			PreparedStatement ps = c.prepareStatement("SELECT a.sportName, a.name as statName "
					+ "FROM michaelsdb.Stats a, michaelsdb.Sports b "
					+ "WHERE a.sportName = b.Name "
					+ "AND ? BETWEEN b.SeasonStartDate AND b.SeasonEndDate "
					+ "AND ? BETWEEN b.SeasonStartDate AND b.SeasonEndDate"
					);
			ps.setDate(1, new java.sql.Date(startDate.getTime()));
			ps.setDate(2, new java.sql.Date(endDate.getTime()));
			//ps.setDate(3, new java.sql.Date(startDate.getTime()));
			//ps.setDate(4, new java.sql.Date(endDate.getTime()));
			
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String sportName = rs.getString("sportName");
				String statName = rs.getString("statName");

				list.add(new Statistic(sportName, statName, null));

			}

			return list;

		} catch (Exception ex) {
			ex.printStackTrace();
			return list;
		} finally {
			// properly release our connection
			// ignore failure closing connection
			try { c.close(); } catch (SQLException e) { return list; }
		}

    }

	@RequestMapping("/getTournaments")
    public @ResponseBody List<Tournament> getTournaments() {

		List<Tournament> list = new ArrayList<Tournament>();
		
		// Retrieve the data source from the application context
		BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

		// Open a database connection using Spring's DataSourceUtils
		Connection c = DataSourceUtils.getConnection(ds);
		try {
			// retrieve a list of three random cities
			PreparedStatement ps = c.prepareStatement(
				"SELECT * FROM michaelsdb.Tournaments");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String name = rs.getString("name");
				java.util.Date startDate = rs.getDate("startDate");
				java.util.Date endDate = rs.getDate("endDate");
				int teamSize = rs.getInt("teamSize");
				int teamCount = rs.getInt("teamCount");
				String adminName = rs.getString("adminName");

				list.add(new Tournament(name, startDate, endDate, teamSize, teamCount, adminName));

			}

		} catch (SQLException ex) {
			// something has failed and we print a stack trace to analyse the error
			return list;
		} finally {
			// properly release our connection
			// ignore failure closing connection
			try { c.close(); } catch (SQLException e) { return list; }
		}

        return list;
    }

	@RequestMapping("/getCurrentSportAverages")
    public @ResponseBody List<CurrentSportAverage> getCurrentSportAverages() {

		List<CurrentSportAverage> list = new ArrayList<CurrentSportAverage>();
		
		// Retrieve the data source from the application context
		BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

		// Open a database connection using Spring's DataSourceUtils
		Connection c = DataSourceUtils.getConnection(ds);
		try {
			// retrieve a list of three random cities
			PreparedStatement ps = c.prepareStatement(
				"select DISTINCT sportName, statName AS statistic, (SELECT TRUNCATE(AVG(A1.scoreMetric)/AVG(A2.scoreMetric),3) AS SportAverage "+
                "FROM AthletePerformanceInEvent AS A1, AthletePerformanceInEvent AS A2 "+
                "WHERE A1.athleteID=A2.athleteID AND A1.eventName=A2.eventName "+
                "AND A1.date=A2.date AND A1.place=A2.place AND statistic=A1.statName and "+
                "((A1.sportName = 'basketball' AND A2.statName = 'minutes') OR "+
                "(A1.sportName='softball' AND A2.statName = 'atBats')) "+
                "AND A2.scoreMetric > 0) AS SA "+
       			"FROM AthletePerformanceInEvent ORDER by sportName, statistic");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String sportName = rs.getString("sportName");
				String statistic = rs.getString("statistic");
				float val = rs.getFloat("SA");

				list.add(new CurrentSportAverage(sportName, statistic, val));

			}

		} catch (SQLException ex) {
			// something has failed and we print a stack trace to analyse the error
			ex.printStackTrace();
			return list;
		} finally {
			// properly release our connection
			// ignore failure closing connection
			try { c.close(); } catch (SQLException e) { return list; }
		}

        return list;
    }

	@RequestMapping("/login")
    public String greeting(@RequestParam(value="username") String username,
		@RequestParam(value="password") String password) {

			// Retrieve the data source from the application context
			BasicDataSource ds = (BasicDataSource) ctx.getBean("dataSource");

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
				return ""+ex;
			} finally {
				// properly release our connection
				// ignore failure closing connection
				try { c.close(); } catch (SQLException e) { return "" + e; }
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
