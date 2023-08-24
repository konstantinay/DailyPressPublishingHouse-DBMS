use paper;

DROP PROCEDURE IF EXISTS PUBLISHER;
DELIMITER $
CREATE PROCEDURE PUBLISHER(in AFMMM char(10))
BEGIN

select Papername from Paper inner join publisher on publishersAFM=AFM where publishersAFM=AFMMM;

END $
delimiter ;

call PUBLISHER(1234567890);