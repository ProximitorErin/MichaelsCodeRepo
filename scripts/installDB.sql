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

INSERT INTO Users (name, password, email) VALUES ('derekf2', 'derekf2', 'derekf2@illinois.edu'), ('gryk2', 'gryk2', 'gryk2@illinois.edu'), ('liacopo2', 'liacopo2', 'liacopo2@illinois.edu'), ('mwalsh34', 'mwalsh34', 'mwalsh34@illinois.edu');
INSERT INTO Sports (name, seasonStartDate, seasonEndDate) VALUES ('bb', '17/2/3', '17/3/24');
INSERT INTO Athletes (firstName, lastName, sportName) VALUES ("Michael", "Jordan", "bb");
INSERT INTO Events (name, date, time, place) VALUES ('game1','27/2/17','14:00:00','State Farm Arena');
INSERT INTO Stats (name, sportName) VALUES ('rebounds', 'bb'),('field goals','bb');
INSERT INTO Tournaments (name, startDate, endDate, adminName) VALUES ('WinnerTakeAll','17/2/28','17/3/6','gryk2');
INSERT INTO Teams (name, username, tournamentName, tournamentStart, tournamentEnd) VALUES ('MichaelsBest','gryk2', 'WinnerTakeAll','17/2/28','17/3/6');
INSERT INTO TeamRoster (athleteID, teamName, tournamentName, tournamentStart, tournamentEnd) VALUES (1,'MichaelsBest','WinnerTakeAll','17/2/28','17/3/6'); #why is sport in here?
INSERT INTO AthletePerformanceInEvent (athleteID, eventName, date, time, place, scoreMetric, statName) VALUES (1, 'game1', '27/2/17','14:00:00','State Farm Arena', 30.0, 'field goals'); #Need FK to stats?
INSERT INTO TournamentPerformanceScoring (tournamentName, tournamentStart, tournamentEnd, statName, statWeight) VALUES ('WinnerTakeAll','17/2/28','17/3/6', 'field goals', 0.25); 
