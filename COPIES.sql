use paper;

DROP PROCEDURE IF EXISTS Copies;
DELIMITER $
CREATE PROCEDURE Copies( IN FILO int, IN COPIES int)
BEGIN

update filo set pub_copies = COPIES where ar_filou = FILO;

END $
delimiter ;

call Copies(12345,200);