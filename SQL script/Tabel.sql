-- Create Teams Table
CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    stadium_name VARCHAR(100),
    stadium_capacity INT
);

-- Create Players Table
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    team_id INT REFERENCES Teams(team_id) ON DELETE CASCADE,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    kit_number INT,
    total_goals INT DEFAULT 0,
    total_assists INT DEFAULT 0
);

-- Create Managers Table
CREATE TABLE Managers (
    manager_id SERIAL PRIMARY KEY,
    manager_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    team_id INT REFERENCES Teams(team_id) ON DELETE CASCADE
);

-- Create Matches Table
CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    home_team_id INT REFERENCES Teams(team_id) ON DELETE CASCADE,
    away_team_id INT REFERENCES Teams(team_id) ON DELETE CASCADE,
    match_date DATE NOT NULL,
    home_team_score INT,
    away_team_score INT,
    match_outcome VARCHAR(50)
);

-- Create Standings Table
CREATE TABLE Standings (
    team_id INT PRIMARY KEY REFERENCES Teams(team_id) ON DELETE CASCADE,
    matches_played INT DEFAULT 0,
    won INT DEFAULT 0,
    drawn INT DEFAULT 0,
    lost INT DEFAULT 0,
    points INT DEFAULT 0, -- Points = (Won * 3) + (Drawn * 1)
    goals_scored INT DEFAULT 0,
    goals_conceded INT DEFAULT 0,
    goal_difference INT DEFAULT 0
);

-- Create Season Table
CREATE TABLE Season (
    season_id SERIAL PRIMARY KEY,
    year VARCHAR(10) NOT NULL,
    winning_team_id INT REFERENCES Teams(team_id),
    top_scorer_id INT REFERENCES Players(player_id),
    best_passer_id INT REFERENCES Players(player_id),
    best_offensive_team_id INT REFERENCES Teams(team_id),
    best_defensive_team_id INT REFERENCES Teams(team_id),
    relegated_teams TEXT -- Stores the list of relegated teams
);
