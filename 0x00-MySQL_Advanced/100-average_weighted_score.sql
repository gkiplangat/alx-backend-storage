-- A SQL script that creates a stored procedure ComputeAverageScoreForUser
-- that computes and store the average score for a student.
-- Procedure ComputeAverageScoreForUser is taking 1 input:
-- user_id, a users.id value (assume user_id is linked to an existing users)
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN DECLARE weight_average_score FLOAT;
    
    SET weight_average_score = (
	SELECT SUM(score * weight) / SUM(weight)
	FROM users AS user
	JOIN corrections AS corr 
	ON user.id = corr.user_id
	JOIN projects AS pro
	On corr.project_id = pro.id
	WHERE user.id = user_id
    );
    UPDATE users
    SET average_score = weight_average_score
    WHERE id = user_id;
END;
//