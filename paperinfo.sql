use paper;

DROP PROCEDURE IF EXISTS infopaper;
DELIMITER $
CREATE PROCEDURE infopaper( IN NAMEE varchar(128))
BEGIN

select * from Paper where Papername=NAMEE;

END $
delimiter ;

call infopaper('Bhma');