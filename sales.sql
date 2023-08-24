use paper;

DROP PROCEDURE IF EXISTS sales;
DELIMITER $
CREATE PROCEDURE sales( IN NAMEE varchar(128))
BEGIN

declare copies_made, copiesReturned, apotelesma int;

select pub_copies into copies_made from filo where efim_filou=NAMEE;
select copies_returned into copiesReturned from filo where efim_filou=NAMEE;

set apotelesma = copies_made - copiesReturned;

select ar_filou,apotelesma from filo where efim_filou=NAMEE
ORDER BY ar_filou asc;

END $
delimiter ;

call sales('Nautemporikh', @x, @y );

