USE michaelsdb;
CREATE TABLE Users (
    name      VARCHAR(16) NOT NULL,
    password  VARCHAR(16) NOT NULL,
    email     VARCHAR(64) NOT NULL,
    isAdmin   BOOL NOT NULL DEFAULT 0, #default to not admin
    PRIMARY KEY (name)
);

CREATE TABLE Sports (
    name             VARCHAR(32) NOT NULL, #longest illini sport name: "Wheelchair basketball" so 32 char
    seasonStartDate  DATE NOT NULL,
    seasonEndDate    DATE NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE Athletes (
    id            INT NOT NULL AUTO_INCREMENT,
    firstName     VARCHAR(16) NOT NULL,
    lastName      VARCHAR(32) NOT NULL,
    picture       VARCHAR(128),            #Assuming URL here
    hometown      VARCHAR(128),
    class         VARCHAR(8),              #Used "Class" over "Year" to match illini listings; length 8 b/c "R-Fr."
    sportName     VARCHAR(32) NOT NULL,
    jerseyNumber  INT,
    PRIMARY KEY (id),
    FOREIGN KEY (sportName) REFERENCES Sports(name)
);

CREATE TABLE Events (
    name   VARCHAR(32) NOT NULL,
    date   DATE NOT NULL,
    time   TIME NOT NULL,
    place  VARCHAR(32) NOT NULL,
    CONSTRAINT pk_event PRIMARY KEY (name,date,time,place)
);

CREATE TABLE Stats (
    name       VARCHAR(32) NOT NULL,
    role       VARCHAR(32), 
    sportName  VARCHAR(32) NOT NULL,
    PRIMARY KEY (name, sportName), 
    FOREIGN KEY (sportName) REFERENCES Sports(name)
 );

CREATE TABLE Tournaments (
    name       VARCHAR(32) NOT NULL,
    startDate  DATE NOT NULL,
    endDate    DATE NOT NULL,
    teamSize   INT NOT NULL DEFAULT 10, #default to 10 athletes on a team
    teamCount  INT NOT NULL DEFAULT 10, #default to 10 teams in a tournament
    adminName  VARCHAR(16) NOT NULL,
    PRIMARY KEY (name, startDate, endDate),
    FOREIGN KEY (adminName) REFERENCES Users(name)
);

CREATE TABLE Teams (
    name                 VARCHAR(128) NOT NULL, 
    wins                 INT DEFAULT 0, #default to 0 wins
    username             VARCHAR(16) NOT NULL, 
    tournamentName       VARCHAR(128) NOT NULL, 
    tournamentStart      DATE NOT NULL,
    tournamentEnd        DATE NOT NULL,
    CONSTRAINT pk_teams PRIMARY KEY (name, username, tournamentName), #Assumption:No same team name in same tournament
    CONSTRAINT fk_tournaments_teams FOREIGN KEY (tournamentName, tournamentStart, tournamentEnd) REFERENCES Tournaments(name, startDate, endDate)
);

CREATE TABLE TeamRoster (
    athleteID           INT NOT NULL,
    teamName             VARCHAR(32) NOT NULL,
    tournamentName       VARCHAR(32) NOT NULL,
    tournamentStart      DATE NOT NULL,
    tournamentEnd        DATE NOT NULL,
    PRIMARY KEY (athleteID, teamName, tournamentName),
    FOREIGN KEY (athleteID) REFERENCES Athletes(id),
    CONSTRAINT fk_tournaments_roster FOREIGN KEY (tournamentName, tournamentStart, tournamentEnd) REFERENCES Tournaments(name, startDate, endDate)
);

CREATE TABLE AthletePerformanceInEvent(
    athleteID    INT NOT NULL,  # Removed athlete name - in athlete table under ID
    eventName    VARCHAR(32) NOT NULL,
    date         DATE NOT NULL,
    time         TIME NOT NULL,
    place        VARCHAR(32) NOT NULL,
    scoreMetric  FLOAT NOT NULL DEFAULT 1.0,  # what should scoremetric be (currently arbitrary default)
    statName     VARCHAR(32) NOT NULL,
	sportName 	 VARCHAR(32) NOT NULL,
    PRIMARY KEY (athleteID, eventName, date, time, place, statName),
    FOREIGN KEY (athleteID) REFERENCES Athletes(ID),
    FOREIGN KEY (eventName, date, time, place) REFERENCES Events(name, date, time, place),
    FOREIGN KEY (statName, sportName) REFERENCES Stats(name, sportName)
);

CREATE TABLE TournamentPerformanceScoring(
    tournamentName       VARCHAR(32) NOT NULL,
    tournamentStart      DATE NOT NULL,
    tournamentEnd        DATE NOT NULL,
    statName             VARCHAR(32) NOT NULL,
	sportName			 VARCHAR(32) NOT NULL,
    statWeight           FLOAT NOT NULL DEFAULT 1.0,  # should weight be INT? (currently arbitrary default)
    PRIMARY KEY (tournamentName, tournamentStart, tournamentEnd, statName),
    CONSTRAINT fk_tournaments_tps FOREIGN KEY (tournamentName, tournamentStart, tournamentEnd) REFERENCES Tournaments(name, startDate, endDate),
    FOREIGN KEY (statName, sportName) REFERENCES Stats(name, sportName)
);

INSERT INTO Users (name, password, email) VALUES 
                                            ('derekf2', 'derekf2', 'derekf2@illinois.edu'), 
                                            ('gryk2', 'gryk2', 'gryk2@illinois.edu'), 
                                            ('liacopo2', 'liacopo2', 'liacopo2@illinois.edu'), 
                                            ('mwalsh34', 'mwalsh34', 'mwalsh34@illinois.edu');
                                 
INSERT INTO Sports (name, seasonStartDate, seasonEndDate) VALUES ('basketball', '16/10/3', '17/4/4');

INSERT INTO Athletes (id, firstName, lastName, sportName, jerseyNumber) VALUES
                                            (1, "Michael", "Jordan", "basketball", 23),
                                            (2, "Leron", "Black", "basketball", 12),
                                            (3, "Maverick", "Morgan", "basketball", 22),
                                            (4, "Te'Jon", "Lucas", "basketball", 03),
                                            (5, "Tracy", "Abrams", "basketball", 13),
                                            (6, "Malcolm", "Hill", "basketball", 21),
                                            (7, "Kipper", "Nichols", "basketball", 02),
                                            (8, "Jalen", "Coleman-Lands", "basketball", 05),
                                            (9, "Michael", "Finke", "basketball", 43);

INSERT INTO Events (name, date, time, place) VALUES ('Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena');

INSERT INTO Stats (name, sportName) VALUES  
                                            ('fieldGoals', 'basketball'),
                                            ('fieldGoalAttempts','basketball'),
                                            ('threePointers', 'basketball'),
                                            ('threePointAttempts','basketball'),
                                            ('freeThrowsGoals', 'basketball'),
                                            ('freeThrowAttempts','basketball'),
                                            ('offensiveRebounds','basketball'),
                                            ('defensiveRebounds','basketball'),
                                            ('personalFouls','basketball'),
                                            ('totalPoints','basketball'), # Some Values like Total points can be calculated
                                            ('assists','basketball'),
                                            ('turnOvers','basketball'),
                                            ('blocks','basketball'),
                                            ('steals','basketball'),
                                            ('minutes','basketball');

INSERT INTO Tournaments (name, startDate, endDate, adminName) VALUES ('WinnerTakeAll','17/2/24','17/3/6','gryk2');

INSERT INTO Teams (name, username, tournamentName, tournamentStart, tournamentEnd) VALUES 
                                            ('MichaelsBest','gryk2', 'WinnerTakeAll','17/2/24','17/3/6');

INSERT INTO TeamRoster (athleteID, teamName, tournamentName, tournamentStart, tournamentEnd) VALUES 
                                            (1,'MichaelsBest','WinnerTakeAll','17/2/24','17/3/6'); #why is sport in here?

INSERT INTO AthletePerformanceInEvent (athleteID, eventName, date, time, place, scoreMetric, statName, sportName) VALUES
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoals', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'fieldGoalAttempts', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'threePointers', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointAttempts', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'defensiveRebounds', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'personalFouls', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 7, 'totalPoints', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'assists', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'turnOvers', 'basketball'),
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'steals', 'basketball'), 
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 22, 'minutes', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoals', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 9, 'fieldGoalAttempts', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointAttempts', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'offensiveRebounds', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'defensiveRebounds', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'personalFouls', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 12, 'totalPoints', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'assists', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals', 'basketball'), 
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 28, 'minutes', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'fieldGoals', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoalAttempts', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'freeThrowsGoals', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'freeThrowAttempts', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'offensiveRebounds', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'defensiveRebounds', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'personalFouls', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 7, 'totalPoints', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'assists', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals', 'basketball'), 
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 31, 'minutes', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'fieldGoals', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'fieldGoalAttempts', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointers', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'threePointAttempts', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'freeThrowsGoals', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'freeThrowAttempts', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'personalFouls', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 13, 'totalPoints', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'assists', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'turnOvers', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals', 'basketball'), 
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 27, 'minutes', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoals', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 11, 'fieldGoalAttempts', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointers', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'threePointAttempts', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'freeThrowsGoals', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'freeThrowAttempts', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'defensiveRebounds', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'personalFouls', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 19, 'totalPoints', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'assists', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'turnOvers', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'steals', 'basketball'), 
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 38, 'minutes', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'fieldGoals', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'fieldGoalAttempts', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'threePointers', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'offensiveRebounds', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'defensiveRebounds', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'personalFouls', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'totalPoints', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'assists', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'blocks', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals', 'basketball'), 
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 11, 'minutes', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoals', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoalAttempts', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'threePointers', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'threePointAttempts', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'personalFouls', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 9, 'totalPoints', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'assists', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals', 'basketball'), 
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 22, 'minutes', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'fieldGoals', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoalAttempts', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'freeThrowsGoals', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'freeThrowAttempts', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'personalFouls', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'totalPoints', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'assists', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals', 'basketball'), 
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 21, 'minutes', 'basketball');

INSERT INTO TournamentPerformanceScoring (tournamentName, tournamentStart, tournamentEnd, statName, sportName, statWeight) VALUES 
                                            ('WinnerTakeAll','17/2/24','17/3/6', 'fieldGoals', 'basketball', 0.25); 
