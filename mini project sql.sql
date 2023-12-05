select * from ipl_bidder_details;
select * from ipl_bidder_points;
select * from ipl_bidding_details;
select * from ipl_match;
select * from ipl_match_schedule;
select * from ipl_player;
select * from ipl_stadium;
select * from ipl_team;
select * from ipl_team_players;
select * from ipl_team_standings;
select * from ipl_tournament;
select * from ipl_user;

-- --------------------------------------------------------------------------------------------------------------------------

-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
SELECT BIDDER_NAME,BIDDER_ID,BIDS_WON/COUNT(*)*100 AS PERCENTAGE_OF_WINS FROM
IPL_BIDDING_DETAILS JOIN
(SELECT BIDDER_ID,COUNT(*)AS BIDS_WON FROM
IPL_BIDDING_DETAILS WHERE BID_STATUS = 'WON'
GROUP BY BIDDER_ID) TYPE_1
USING(BIDDER_ID)
JOIN IPL_BIDDER_DETAILS USING(BIDDER_ID)
GROUP BY BIDDER_ID ORDER BY PERCENTAGE_OF_WINS DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
SELECT COUNT(IPL_STADIUM.STADIUM_ID) AS 'count(MATCH_ID)',IPL_STADIUM.STADIUM_ID, STADIUM_NAME,CITY 
FROM IPL_STADIUM
INNER JOIN IPL_MATCH_SCHEDULE
ON IPL_STADIUM.STADIUM_ID = IPL_MATCH_SCHEDULE.STADIUM_ID
GROUP BY IPL_STADIUM.STADIUM_ID,STADIUM_NAME
ORDER BY 'count(MATCH_ID)';

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
SELECT c.STADIUM_NAME,
(SELECT count(*) from ipl_match m join ipl_match_schedule ms on m.match_id=ms.match_id where ms.stadium_id = c.stadium_id and
(m.TOSS_WINNER=m.MATCH_WINNER))/(SELECT count(*) from ipl_match_schedule ms where ms.stadium_id = c.stadium_id) * 100 
as 'Percentage of Wins'
from ipl_stadium c;

-- --------------------------------------------------------------------------------------------------------------------------------------------

-- 4.	Show the total bids along with bid team and team name.
SELECT COUNT(BID_TEAM) ,BID_TEAM,d.TEAM_NAME
FROM IPL_BIDDING_DETAILS e
INNER JOIN IPL_TEAM d
ON e.BID_TEAM = d.TEAM_ID
GROUP BY BID_TEAM;

-- --------------------------------------------------------------------------------------------------------------------------------------------

-- 5.	Show the team id who won the match as per the win details.
SELECT TEAM_ID,MATCH_WINNER,WIN_DETAILS
FROM IPL_TEAM
CROSS JOIN IPL_MATCH
group by 2,3
order by TEAM_ID;

-- -------------------------------------------------------------------------------------------------------------------------------------------

-- 6.	Display total matches played, total matches won and total matches lost by team along with its team name.
SELECT s.TEAM_ID,t.TEAM_NAME,
SUM(s.MATCHES_PLAYED) AS TOTAL_MATCH_PLAYED,
SUM(s.MATCHES_WON) AS WON_MATCHES,
SUM(s.MATCHES_LOST) AS LOST_MATCHES
FROM IPL_TEAM_STANDINGS s
INNER JOIN IPL_TEAM t
ON s.TEAM_ID=t.TEAM_ID
GROUP BY s.TEAM_ID;

-- ------------------------------------------------------------------------------------------------------------------------------------------

-- 7.	Display the bowlers for Mumbai Indians team.
SELECT ipl_player.Player_Name, ipl_team_players.PLAYER_ROLE, ipl_team.Team_Name 
from ipl_player 
INNER JOIN ipl_team_players 
on ipl_player.player_id = ipl_team_players.player_id
and player_role like '%Bowler%'
INNER JOIN ipl_team  
on ipl_team.team_ID = ipl_team_players.team_ID
and Team_Name like '%Mumbai%';

-- -------------------------------------------------------------------------------------------------------------------------------------

-- 8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.
SELECT TEAM_NAME,PLAYER_ROLE, count(PLAYER_ROLE) AS TOTAL
FROM ipl_team
INNER JOIN ipl_team_players
ON SUBSTR(ipl_team.REMARKS,-2) = SUBSTR(ipl_team_players.REMARKS,-2)
GROUP BY PLAYER_ROLE, TEAM_NAME
HAVING PLAYER_ROLE LIKE 'All-Rounder' AND count(PLAYER_ROLE) > 4
ORDER BY COUNT(PLAYER_ROLE) DESC;
