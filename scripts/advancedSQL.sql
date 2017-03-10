use database Michaelsdb;

# Calculate the average of a basketball stat.  This is valid for all stats but is useless for 'minutes'.

select AVG(A1.scoreMetric)/AVG(A2.scoreMetric) 
        FROM athletePerformanceInEvent as A1, athletePerformanceInEvent as A2 
        WHERE A1.athleteID=A2.athleteID AND A1.eventName=A2.eventName AND A1.date=A2.date AND A1.place=A2.place 
            AND A1.sportName = 'basketball' AND A1.statName = "fieldGoals" AND A2.statName = "minutes" AND A2.scoreMetric > 0;
            
# Similar query for softball.  Divisor is atBats
select AVG(A1.scoreMetric)/AVG(A2.scoreMetric)
        FROM athletePerformanceInEvent as A1, athletePerformanceInEvent as A2
        WHERE A1.athleteID=A2.athleteID AND A1.eventName=A2.eventName AND A1.date=A2.date AND A1.place=A2.place
        AND A1.sportName = 'softball' AND A1.statName = "hits" AND A2.statName = "atBats" AND A2.scoreMetric > 0;
        
