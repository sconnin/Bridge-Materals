CREATE TABLE videos
(
id INT NOT NULL,
title TEXT,
length_min INT,
url TEXT,
PRIMARY KEY(id)
)
;

INSERT INTO videos (id, title, length_min, url) VALUES
(1, 'Wonder Woman 1984', 151, 'https://www.youtube.com/watch?v=XW2E2Fnh52w');
INSERT INTO videos (id, title, length_min,url) VALUES
(2, 'News of the World', 118, 'https://www.youtube.com/watch?v=zTZDb_iKooI');
INSERT INTO videos (id, title, length_min, url) VALUES
(3, 'Contagion', 106, 'https://www.youtube.com/watch?v=4sYSyuuLk5g');

CREATE TABLE reviewers
(
reviewer_name TEXT,
rating INT NULL,
review TEXT,
id INT NOT NULL,
FOREIGN KEY(id) REFERENCES videos(id)
);

INSERT INTO reviewers (reviewer_name, rating, review, id) 
VALUES ('Rafer', 3, 'A serviceable sequel, elevated by its radiant leading 
lady and an over-the-top villain', 1);

INSERT INTO reviewers (reviewer_name, rating, review, id) 
VALUES ('Ty', 5, 'It is a well-made and thoughtful movie that does not 
leave that much of a mark', 2);

INSERT INTO reviewers (reviewer_name, rating, review, id) 
VALUES ('Candace', 4, 'A bit of a mixed bag at times', 3);

SELECT *
FROM videos v
INNER JOIN reviewers r
USING (id); -- USING drops duplicate JOIN column (e.g., id) 

