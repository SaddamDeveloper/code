TREE INSERT AND UPDATE

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TreeInsertAndUpdate`(IN `userId` INT, IN `parentId` INT, IN `leg` CHAR(1), IN `registeredBy` INT)
BEGIN
	DECLARE left_id VARCHAR(255) DEFAULT 0;
    DECLARE InsertedId VARCHAR(255) DEFAULT 0;
        IF leg = 'L' THEN
             SET left_id = (SELECT extLeft(parentId));
        ELSE
           SET left_id = (SELECT extRight(parentId));
        END IF;
	INSERT INTO `trees` (`user_id`, `parent_id`, `parent_leg`, `registered_by`) VALUES (userId, left_id, leg, registeredBy);
     SET InsertedId = LAST_INSERT_ID();
    
     	IF leg = 'L' THEN
           UPDATE `trees` SET `left_id` = InsertedId WHERE `id` = left_id;
        ELSE
           UPDATE `trees` SET `right_id` = InsertedId WHERE `id` = left_id;
        END IF;
         SELECT InsertedId AS InsertedIds;
END$$
DELIMITER ;
