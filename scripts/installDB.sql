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
    PRIMARY KEY (name), 
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
    PRIMARY KEY (athleteID, eventName, date, time, place, statName),
    FOREIGN KEY (athleteID) REFERENCES Athletes(ID),
    FOREIGN KEY (eventName, date, time, place) REFERENCES Events(name, date, time, place),
    FOREIGN KEY (statName) REFERENCES Stats(name)
);

CREATE TABLE TournamentPerformanceScoring(
    tournamentName       VARCHAR(32) NOT NULL,
    tournamentStart      DATE NOT NULL,
    tournamentEnd        DATE NOT NULL,
    statName             VARCHAR(32) NOT NULL,
    statWeight           FLOAT NOT NULL DEFAULT 1.0,  # should weight be INT? (currently arbitrary default)
    PRIMARY KEY (tournamentName, tournamentStart, tournamentEnd, statName),
    CONSTRAINT fk_tournaments_tps FOREIGN KEY (tournamentName, tournamentStart, tournamentEnd) REFERENCES Tournaments(name, startDate, endDate),
    FOREIGN KEY (statName) REFERENCES Stats(name)
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
                                            ('totalPoints','basketball'),      # Some Values like Total points can be calculated
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

INSERT INTO AthletePerformanceInEvent (athleteID, eventName, date, time, place, scoreMetric, statName) VALUES       
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoals'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'fieldGoalAttempts'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'threePointers'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointAttempts'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'defensiveRebounds'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'personalFouls'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 7, 'totalPoints'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'assists'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'turnOvers'),   
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'steals'),      
                                            (2, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 22, 'minutes'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoals'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 9, 'fieldGoalAttempts'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointAttempts'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'offensiveRebounds'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'defensiveRebounds'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'personalFouls'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 12, 'totalPoints'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'assists'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals'),      
                                            (3, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 28, 'minutes'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'fieldGoals'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoalAttempts'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'freeThrowsGoals'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'freeThrowAttempts'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'offensiveRebounds'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'defensiveRebounds'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'personalFouls'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 7, 'totalPoints'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'assists'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals'),      
                                            (4, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 31, 'minutes'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'fieldGoals'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 8, 'fieldGoalAttempts'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointers'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'threePointAttempts'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'freeThrowsGoals'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'freeThrowAttempts'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'personalFouls'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 13, 'totalPoints'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'assists'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'turnOvers'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals'),      
                                            (5, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 27, 'minutes'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoals'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 11, 'fieldGoalAttempts'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'threePointers'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'threePointAttempts'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'freeThrowsGoals'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'freeThrowAttempts'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'defensiveRebounds'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'personalFouls'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 19, 'totalPoints'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'assists'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'turnOvers'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'steals'),      
                                            (6, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 38, 'minutes'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'fieldGoals'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'fieldGoalAttempts'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'threePointers'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'offensiveRebounds'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'defensiveRebounds'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'personalFouls'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'totalPoints'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'assists'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'blocks'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals'),      
                                            (7, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 11, 'minutes'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoals'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 6, 'fieldGoalAttempts'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'threePointers'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 5, 'threePointAttempts'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowsGoals'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'freeThrowAttempts'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'personalFouls'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 9, 'totalPoints'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'assists'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'steals'),      
                                            (8, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 22, 'minutes'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'fieldGoals'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 3, 'fieldGoalAttempts'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'threePointers'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'threePointAttempts'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'freeThrowsGoals'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'freeThrowAttempts'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'offensiveRebounds'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 4, 'defensiveRebounds'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'personalFouls'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'totalPoints'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'assists'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 1, 'turnOvers'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 0, 'blocks'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 2, 'steals'),      
                                            (9, 'Nebraska','17/2/26','18:36:00','Pinnacle Bank Arena', 21, 'minutes');

INSERT INTO TournamentPerformanceScoring (tournamentName, tournamentStart, tournamentEnd, statName, statWeight) VALUES 
                                            ('WinnerTakeAll','17/2/24','17/3/6', 'fieldGoals', 0.25); 
