-- User
CREATE TABLE "User" (
    UserId NUMBER PRIMARY KEY,
    Username VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Password VARCHAR2(100) NOT NULL,
    ProfilePicURL VARCHAR2(255),
    JoinDate DATE
);

-- "Subscription"
CREATE TABLE "Subscription" (
    PlanId NUMBER PRIMARY KEY,
    PlanName VARCHAR2(50),
    PlanType VARCHAR2(50),
    Price NUMBER
);

-- Subscribes (User ↔ "Subscription")
CREATE TABLE Subscribes (
    UserId NUMBER,
    PlanId NUMBER,
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (UserId, PlanId),
    FOREIGN KEY (UserId) REFERENCES "User"(UserId),
    FOREIGN KEY (PlanId) REFERENCES "Subscription"(PlanId)
);

-- Anime
CREATE TABLE Anime (
    AnimeId NUMBER PRIMARY KEY,
    Title VARCHAR2(100) NOT NULL,
    Description VARCHAR2(1000),
    ReleaseDate DATE,
    Status VARCHAR2(50),
    CoverImgURL VARCHAR2(255)
);

-- Genre
CREATE TABLE Genre (
    GenreId NUMBER PRIMARY KEY,
    GenreName VARCHAR2(50)
);

-- BelongsTo (Anime ↔ Genre)
CREATE TABLE BelongsTo (
    AnimeId NUMBER,
    GenreId NUMBER,
    PRIMARY KEY (AnimeId, GenreId),
    FOREIGN KEY (AnimeId) REFERENCES Anime(AnimeId),
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

-- Studio
CREATE TABLE Studio (
    StudioId NUMBER PRIMARY KEY,
    StudioName VARCHAR2(100),
    DescriptionText VARCHAR2(1000),
    WebsiteURL VARCHAR2(255),
    FoundedYear NUMBER(4)
);

-- ProducedBy (Anime ↔ Studio)
CREATE TABLE ProducedBy (
    AnimeId NUMBER PRIMARY KEY,
    StudioId NUMBER,
    FOREIGN KEY (AnimeId) REFERENCES Anime(AnimeId),
    FOREIGN KEY (StudioId) REFERENCES Studio(StudioId)
);

-- Season (Weak)
CREATE TABLE Season (
    AnimeId NUMBER,
    SeasonNo NUMBER,
    Title VARCHAR2(100),
    ReleaseDate DATE,
    PRIMARY KEY (AnimeId, SeasonNo),
    FOREIGN KEY (AnimeId) REFERENCES Anime(AnimeId)
);

-- Episode (Weak)
CREATE TABLE Episode (
    AnimeId NUMBER,
    SeasonNo NUMBER,
    EpisodeNo NUMBER,
    Title VARCHAR2(100),
    ReleaseDate DATE,
    Duration NUMBER,
    VideoURL VARCHAR2(255),
    PRIMARY KEY (AnimeId, SeasonNo, EpisodeNo),
    FOREIGN KEY (AnimeId, SeasonNo) REFERENCES Season(AnimeId, SeasonNo)
);

-- AudioTrack (Weak)
CREATE TABLE AudioTrack (
    AnimeId NUMBER,
    SeasonNo NUMBER,
    EpisodeNo NUMBER,
    AudioURL VARCHAR2(255),
    Language VARCHAR2(50),
    PRIMARY KEY (AnimeId, SeasonNo, EpisodeNo, AudioURL),
    FOREIGN KEY (AnimeId, SeasonNo, EpisodeNo)
        REFERENCES Episode(AnimeId, SeasonNo, EpisodeNo)
);

-- WatchHistory
CREATE TABLE WatchHistory (
    HistoryId NUMBER PRIMARY KEY,
    UserId NUMBER,
    AnimeId NUMBER,
    SeasonNo NUMBER,
    EpisodeNo NUMBER,
    WatchedAt DATE,
    WatchedTill VARCHAR2(50),
    FOREIGN KEY (UserId) REFERENCES "User"(UserId),
    FOREIGN KEY (AnimeId, SeasonNo, EpisodeNo)
        REFERENCES Episode(AnimeId, SeasonNo, EpisodeNo)
);

-- Review
CREATE TABLE Review (
    ReviewId NUMBER PRIMARY KEY,
    UserId NUMBER,
    AnimeId NUMBER,
    ReviewText VARCHAR2(1000),
    Rating NUMBER(3,1),
    ReviewAt DATE,
    FOREIGN KEY (UserId) REFERENCES "User"(UserId),
    FOREIGN KEY (AnimeId) REFERENCES Anime(AnimeId)
);

-- EpisodeComment
CREATE TABLE EpisodeComment (
    CommentId NUMBER PRIMARY KEY,
    UserId NUMBER,
    AnimeId NUMBER,
    SeasonNo NUMBER,
    EpisodeNo NUMBER,
    CommentText VARCHAR2(1000),
    CommentedAt DATE,
    FOREIGN KEY (UserId) REFERENCES "User"(UserId),
    FOREIGN KEY (AnimeId, SeasonNo, EpisodeNo)
        REFERENCES Episode(AnimeId, SeasonNo, EpisodeNo)
);

-- ======== INSERTS  =========

-- User
INSERT INTO "User" VALUES (1, 'dinesh51', 'dinesh@example.com', 'pass123', 'pic1.jpg', TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO "User" VALUES (2, 'nikhil47', 'nikhil@example.com', 'pass456', 'pic2.jpg', TO_DATE('2023-07-01', 'YYYY-MM-DD'));
INSERT INTO "User" VALUES (3, 'preetesh', 'preetesh@example.com', 'pass789', 'pic3.jpg', TO_DATE('2023-08-01', 'YYYY-MM-DD'));
INSERT INTO "User" VALUES (4, 'narender', 'narender@example.com', 'passabc', 'pic4.jpg', TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO "User" VALUES (5, 'sai', 'sai@example.com', 'passxyz', 'pic5.jpg', TO_DATE('2023-10-01', 'YYYY-MM-DD'));

-- "Subscription"
INSERT INTO "Subscription" VALUES (101, 'Mega Fan', 'Monthly', 99);
INSERT INTO "Subscription" VALUES (102, 'Annual Mega Fan', 'Yearly', 475);
INSERT INTO "Subscription" VALUES (103, 'Fan', 'Monthly', 79);
INSERT INTO "Subscription" VALUES (104, 'Trial', 'Weekly', 0);

-- Subscribes
INSERT INTO Subscribes VALUES (1, 101, SYSDATE-60, SYSDATE-30);
INSERT INTO Subscribes VALUES (2, 102, SYSDATE-340, SYSDATE+25);
INSERT INTO Subscribes VALUES (3, 103, SYSDATE-7, SYSDATE+23);
INSERT INTO Subscribes VALUES (4, 104, SYSDATE-3, SYSDATE+4);
INSERT INTO Subscribes VALUES (5, 103, SYSDATE-2, SYSDATE+28);

-- Genre
INSERT INTO Genre VALUES (1, 'Action');
INSERT INTO Genre VALUES (2, 'Adventure');
INSERT INTO Genre VALUES (3, 'Fantasy');
INSERT INTO Genre VALUES (4, 'Drama');
INSERT INTO Genre VALUES (5, 'Comedy');

-- Anime
INSERT INTO Anime VALUES (10, 'Naruto', 'A ninja journey', TO_DATE('2002-10-03', 'YYYY-MM-DD'), 'Completed', 'naruto.jpg');
INSERT INTO Anime VALUES (11, 'Bleach', 'Soul Reapers vs Hollows', TO_DATE('2004-10-05', 'YYYY-MM-DD'), 'Ongoing', 'bleach.jpg');
INSERT INTO Anime VALUES (12, 'One Piece', 'Pirate adventure', TO_DATE('1999-10-20', 'YYYY-MM-DD'), 'Ongoing', 'onepiece.jpg');
INSERT INTO Anime VALUES (13, 'Death Note', 'Battle of intellect', TO_DATE('2006-10-04', 'YYYY-MM-DD'), 'Completed', 'deathnote.jpg');
INSERT INTO Anime VALUES (14, 'Attack on Titan', 'Humanity vs Titans', TO_DATE('2013-04-06', 'YYYY-MM-DD'), 'Completed', 'aot.jpg');

-- BelongsTo
INSERT INTO BelongsTo VALUES (10, 1);
INSERT INTO BelongsTo VALUES (10, 2);
INSERT INTO BelongsTo VALUES (11, 1);
INSERT INTO BelongsTo VALUES (12, 2);
INSERT INTO BelongsTo VALUES (13, 4);

-- Studio
INSERT INTO Studio VALUES (1, 'Studio Pierrot', 'Known for Naruto and Bleach', 'http://pierrot.jp', 1979);
INSERT INTO Studio VALUES (2, 'Toei Animation', 'Long running anime', 'http://toei.jp', 1956);
INSERT INTO Studio VALUES (3, 'Madhouse', 'High quality production', 'http://madhouse.co.jp', 1972);
INSERT INTO Studio VALUES (4, 'Wit Studio', 'Visual masterwork', 'http://witstudio.jp', 2012);
INSERT INTO Studio VALUES (5, 'MAPPA', 'Modern anime powerhouse', 'http://mappa.co.jp', 2011);

-- ProducedBy
INSERT INTO ProducedBy VALUES (10, 1);
INSERT INTO ProducedBy VALUES (11, 1);
INSERT INTO ProducedBy VALUES (12, 2);
INSERT INTO ProducedBy VALUES (13, 3);
INSERT INTO ProducedBy VALUES (14, 4);

-- Season
INSERT INTO Season VALUES (10, 1, 'Naruto Classic', TO_DATE('2002-10-03', 'YYYY-MM-DD'));
INSERT INTO Season VALUES (11, 1, 'Bleach S1', TO_DATE('2004-10-05', 'YYYY-MM-DD'));
INSERT INTO Season VALUES (12, 1, 'East Blue', TO_DATE('1999-10-20', 'YYYY-MM-DD'));
INSERT INTO Season VALUES (13, 1, 'The Beginning', TO_DATE('2006-10-04', 'YYYY-MM-DD'));
INSERT INTO Season VALUES (14, 1, 'The Fall of Shiganshina', TO_DATE('2013-04-06', 'YYYY-MM-DD'));

-- Episode
INSERT INTO Episode VALUES (10, 1, 1, 'Enter Naruto Uzumaki!', TO_DATE('2002-10-03', 'YYYY-MM-DD'), 24, 'naruto_s1_e1.mp4');
INSERT INTO Episode VALUES (11, 1, 1, 'A Shinigami is Born', TO_DATE('2004-10-05', 'YYYY-MM-DD'), 23, 'bleach_s1_e1.mp4');
INSERT INTO Episode VALUES (12, 1, 1, 'I''m Luffy!', TO_DATE('1999-10-20', 'YYYY-MM-DD'), 25, 'onepiece_s1_e1.mp4');
INSERT INTO Episode VALUES (13, 1, 1, 'Rebirth', TO_DATE('2006-10-04', 'YYYY-MM-DD'), 22, 'deathnote_s1_e1.mp4');
INSERT INTO Episode VALUES (14, 1, 1, 'To You, 2000 Years in the Future', TO_DATE('2013-04-06', 'YYYY-MM-DD'), 24, 'aot_s1_e1.mp4');

-- AudioTrack
INSERT INTO AudioTrack VALUES (10, 1, 1, 'naruto_en.mp3', 'English');
INSERT INTO AudioTrack VALUES (10, 1, 1, 'naruto_jp.mp3', 'Japanese');
INSERT INTO AudioTrack VALUES (11, 1, 1, 'bleach_en.mp3', 'English');
INSERT INTO AudioTrack VALUES (12, 1, 1, 'op_jp.mp3', 'Japanese');
INSERT INTO AudioTrack VALUES (14, 1, 1, 'aot_en.mp3', 'English');

-- WatchHistory
INSERT INTO WatchHistory VALUES (1, 1, 10, 1, 1, SYSDATE-10, '00:22:15');
INSERT INTO WatchHistory VALUES (2, 2, 11, 1, 1, SYSDATE-9, '00:18:20');
INSERT INTO WatchHistory VALUES (3, 3, 12, 1, 1, SYSDATE-8, '00:10:00');
INSERT INTO WatchHistory VALUES (4, 4, 13, 1, 1, SYSDATE-7, '00:22:00');
INSERT INTO WatchHistory VALUES (5, 5, 14, 1, 1, SYSDATE-6, '00:21:30');

-- Review
INSERT INTO Review VALUES (501, 1, 10, 'Loved Naruto!', 9.5, SYSDATE-10);
INSERT INTO Review VALUES (502, 2, 11, 'Bleach is intense', 8.7, SYSDATE-9);
INSERT INTO Review VALUES (503, 3, 12, 'One Piece forever', 10.0, SYSDATE-8);
INSERT INTO Review VALUES (504, 4, 13, 'Death Note is godly', 9.8, SYSDATE-7);
INSERT INTO Review VALUES (505, 5, 14, 'AOT shook me', 9.9, SYSDATE-6);

-- EpisodeComment
INSERT INTO EpisodeComment VALUES (601, 1, 10, 1, 1, 'Great start to the story!', SYSDATE-10);
INSERT INTO EpisodeComment VALUES (602, 2, 11, 1, 1, 'Bleach intro 🔥', SYSDATE-9);
INSERT INTO EpisodeComment VALUES (603, 3, 12, 1, 1, 'Go Luffy go!', SYSDATE-8);
INSERT INTO EpisodeComment VALUES (604, 4, 13, 1, 1, 'Kira is insane...', SYSDATE-7);
INSERT INTO EpisodeComment VALUES (605, 5, 14, 1, 1, 'AOT opening gave chills', SYSDATE-6);
--
--
-- ===== SHOW DATA =====
SELECT * FROM "User";
SELECT * FROM "Subscription";
SELECT * FROM Subscribes;

SELECT * FROM Anime;
SELECT * FROM Genre;
SELECT * FROM BelongsTo;

SELECT * FROM Studio;
SELECT * FROM ProducedBy;

SELECT * FROM Season;
SELECT * FROM Episode;
SELECT * FROM AudioTrack;

SELECT * FROM WatchHistory;
SELECT * FROM Review;
SELECT * FROM EpisodeComment;

-- ========== SQL QUERIES ==========

-- 1. List all anime released after 2010
SELECT Title, ReleaseDate
FROM Anime
WHERE ReleaseDate > TO_DATE('2010-01-01', 'YYYY-MM-DD');

-- 2. List all users subscribed to any plan
SELECT u.Username, s.PlanName
FROM "User" u
JOIN Subscribes sub ON u.UserId = sub.UserId
JOIN "Subscription" s ON sub.PlanId = s.PlanId
WHERE s.PlanName LIKE '%Fan%';

-- 3. Show all genres associated with Naruto
SELECT g.GenreName
FROM Genre g
JOIN BelongsTo b ON g.GenreId = b.GenreId
WHERE b.AnimeId = 10;

-- 4. Number of animes in each genre
SELECT g.GenreName, COUNT(*) AS AnimeCount
FROM Genre g
JOIN BelongsTo b ON g.GenreId = b.GenreId
GROUP BY g.GenreName;

-- 5. Average rating of each anime
SELECT a.Title, ROUND(AVG(r.Rating), 2) AS AvgRating
FROM Anime a
JOIN Review r ON a.AnimeId = r.AnimeId
GROUP BY a.Title;

-- 6. Count of users per subscription plan
SELECT s.PlanName, COUNT(sub.UserId) AS UserCount
FROM "Subscription" s
LEFT JOIN Subscribes sub ON s.PlanId = sub.PlanId
GROUP BY s.PlanName;

-- 7. List episodes with anime and season title
SELECT a.Title AS AnimeTitle, s.Title AS SeasonTitle, e.EpisodeNo, e.Title AS EpisodeTitle
FROM Episode e
JOIN Season s ON e.AnimeId = s.AnimeId AND e.SeasonNo = s.SeasonNo
JOIN Anime a ON e.AnimeId = a.AnimeId;

-- 8. Users and episodes they watched
SELECT u.Username, a.Title, s.SeasonNo, e.EpisodeNo, w.WatchedTill
FROM WatchHistory w
JOIN "User" u ON w.UserId = u.UserId
JOIN Episode e ON w.AnimeId = e.AnimeId AND w.SeasonNo = e.SeasonNo AND w.EpisodeNo = e.EpisodeNo
JOIN Anime a ON a.AnimeId = w.AnimeId
JOIN Season s ON s.AnimeId = w.AnimeId AND s.SeasonNo = w.SeasonNo;

-- 9. Studios and animes they produced
SELECT s.StudioName, a.Title
FROM ProducedBy p
JOIN Studio s ON p.StudioId = s.StudioId
JOIN Anime a ON p.AnimeId = a.AnimeId;

-- 10. Animes with English audio
SELECT DISTINCT a.Title
FROM AudioTrack at
JOIN Anime a ON a.AnimeId = at.AnimeId
WHERE at.Language = 'English';

-- 11. Top 3 highest-rated animes
SELECT a.Title, ROUND(AVG(r.Rating), 2) AS AvgRating
FROM Anime a
JOIN Review r ON a.AnimeId = r.AnimeId
GROUP BY a.Title
ORDER BY AvgRating DESC
FETCH FIRST 3 ROWS ONLY;

-- 12. Most commented episode
SELECT a.Title, e.Title AS EpisodeTitle, COUNT(*) AS CommentCount
FROM EpisodeComment ec
JOIN Episode e ON ec.AnimeId = e.AnimeId AND ec.SeasonNo = e.SeasonNo AND ec.EpisodeNo = e.EpisodeNo
JOIN Anime a ON a.AnimeId = ec.AnimeId
GROUP BY a.Title, e.Title
ORDER BY CommentCount DESC
FETCH FIRST 1 ROW ONLY;

-- 13. Users with no reviews
SELECT u.Username
FROM "User" u
LEFT JOIN Review r ON u.UserId = r.UserId
WHERE r.UserId IS NULL;

-- 14. Anime without a studio
SELECT a.Title
FROM Anime a
LEFT JOIN ProducedBy pb ON a.AnimeId = pb.AnimeId
WHERE pb.StudioId IS NULL;

-- 15. Animes belonging to more than 1 genre
SELECT a.Title, COUNT(*) AS GenreCount
FROM Anime a
JOIN BelongsTo b ON a.AnimeId = b.AnimeId
GROUP BY a.Title
HAVING COUNT(*) > 1;

-- 16. Users who joined after August 2023
SELECT * 
FROM "User"
WHERE JoinDate > TO_DATE('2023-08-01', 'YYYY-MM-DD');

-- 17. Total episodes per anime
SELECT a.Title, COUNT(*) AS EpisodeCount
FROM Anime a
JOIN Episode e ON a.AnimeId = e.AnimeId
GROUP BY a.Title;

-- 18. Users who watched Bleach
SELECT DISTINCT u.Username
FROM WatchHistory w
JOIN "User" u ON w.UserId = u.UserId
WHERE w.AnimeId = 11;

-- 19. Expired subscriptions
SELECT u.Username, s.PlanName, sub.EndDate
FROM Subscribes sub
JOIN "User" u ON u.UserId = sub.UserId
JOIN "Subscription" s ON s.PlanId = sub.PlanId
WHERE sub.EndDate IS NOT NULL AND sub.EndDate < SYSDATE;

-- 20. Active users on Trial plan
SELECT u.Username
FROM Subscribes sub
JOIN "User" u ON u.UserId = sub.UserId
WHERE sub.PlanId = 104 AND (sub.EndDate IS NULL OR sub.EndDate >= SYSDATE);

-- 21. Review count per user
SELECT u.Username, COUNT(r.ReviewId) AS ReviewCount
FROM "User" u
LEFT JOIN Review r ON u.UserId = r.UserId
GROUP BY u.Username;

-- 22. Episodes longer than 23 minutes
SELECT a.Title, e.Title AS EpisodeTitle, e.Duration
FROM Episode e
JOIN Anime a ON a.AnimeId = e.AnimeId
WHERE e.Duration > 23;

-- 23. Comments made by each user
SELECT u.Username, COUNT(ec.CommentId) AS TotalComments
FROM "User" u
LEFT JOIN EpisodeComment ec ON u.UserId = ec.UserId
GROUP BY u.Username;

-- 24. List of all subscriptions that are still active
SELECT u.Username, s.PlanName
FROM Subscribes sub
JOIN "User" u ON sub.UserId = u.UserId
JOIN "Subscription" s ON sub.PlanId = s.PlanId
WHERE sub.EndDate IS NULL OR sub.EndDate > SYSDATE;

-- 25. Average episode duration for each anime
SELECT a.Title, ROUND(AVG(e.Duration), 2) AS AvgDuration
FROM Anime a
JOIN Episode e ON a.AnimeId = e.AnimeId
GROUP BY a.Title;

-- 26. Number of seasons per anime
SELECT a.Title, COUNT(*) AS SeasonCount
FROM Anime a
JOIN Season s ON a.AnimeId = s.AnimeId
GROUP BY a.Title;

-- 27. Show all episodes and how many audio tracks they have
SELECT e.Title AS EpisodeTitle, COUNT(at.AudioURL) AS AudioTracks
FROM Episode e
JOIN AudioTrack at ON e.AnimeId = at.AnimeId AND e.SeasonNo = at.SeasonNo AND e.EpisodeNo = at.EpisodeNo
GROUP BY e.Title;

-- 28. Find the user who has watched the most episodes
SELECT u.Username, COUNT(*) AS EpisodesWatched
FROM WatchHistory w
JOIN "User" u ON w.UserId = u.UserId
GROUP BY u.Username
ORDER BY EpisodesWatched DESC
FETCH FIRST 1 ROW ONLY;

-- 29. Find the anime with the most reviews
SELECT a.Title, COUNT(*) AS ReviewCount
FROM Review r
JOIN Anime a ON a.AnimeId = r.AnimeId
GROUP BY a.Title
ORDER BY ReviewCount DESC
FETCH FIRST 1 ROW ONLY;

-- 30. Number of audio tracks available per language
SELECT Language, COUNT(*) AS TotalTracks
FROM AudioTrack
GROUP BY Language;

-- ========== END ==========


