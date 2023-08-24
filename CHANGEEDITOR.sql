use paper;

DROP PROCEDURE IF EXISTS changeEditor;
DELIMITER $
CREATE PROCEDURE changeEditor( IN EMAIL varchar(255))
BEGIN

update journalist set j_specialty = 'journalist' where j_email = EMAIL;

END $
delimiter ;

call changeEditor('mariaki@gmail.com');