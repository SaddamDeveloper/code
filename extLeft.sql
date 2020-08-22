DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `extLeft`(`parent_id` INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
     DECLARE ret_id VARCHAR(256);
    SET ret_id =(SELECT max(tv) FROM (
                    SELECT @pv:=(
                        SELECT left_id FROM trees WHERE id = @pv
                        ) AS tv FROM trees
                        JOIN
                        (SELECT @pv:=parent_id) tmp
                    ) a
                    WHERE tv IS NOT NULL AND tv != 0 LIMIT 1000);

	-- return the customer level
	RETURN (ret_id);
END$$
DELIMITER ;
