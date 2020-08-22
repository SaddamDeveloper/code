DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `directJoin`(IN `sponsor_id` INT, IN `leg` CHAR(1), IN `userId` INT, IN `registeredBy` INT)
    NO SQL
BEGIN
	DECLARE status BOOL DEFAULT FALSE;
    DECLARE parent_leg_id VARCHAR(255) DEFAULT 0;
    DECLARE InsertedId VARCHAR(255) DEFAULT 0;

       IF leg = 'L' THEN 
       	SET parent_leg_id = (SELECT `left_id` FROM `trees` WHERE `id` = sponsor_id);
    	IF parent_leg_id IS NULL THEN
			INSERT INTO `trees` (`user_id`, `parent_id`, `parent_leg`, `registered_by`) VALUES (userId, sponsor_id, leg, registeredBy);
             SET InsertedId = LAST_INSERT_ID();
             UPDATE `trees` SET `left_id` = InsertedId WHERE `id` = sponsor_id;
             SET status = TRUE;
         ELSE
         	SET status = FALSE;
        END IF;
     END IF;

   	IF leg = 'R' THEN 
       	SET parent_leg_id = (SELECT `right_id` FROM `trees` WHERE `id` = sponsor_id);
        IF parent_leg_id IS NULL THEN
              INSERT INTO `trees` (`user_id`, `parent_id`, `parent_leg`, `registered_by`) VALUES (userId, sponsor_id, leg, registeredBy);  
              SET InsertedId = LAST_INSERT_ID();
              UPDATE `trees` SET `right_id`= InsertedId WHERE `id` = sponsor_id;
              SET status = TRUE;
          ELSE
				SET status = FALSE;              
          END IF;
    END IF;
    SELECT InsertedId AS InsertedIds, status as sts;
END$$
DELIMITER ;
