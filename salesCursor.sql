use paper;

DROP PROCEDURE IF EXISTS salesCursor;
DELIMITER $
CREATE PROCEDURE salesCursor (IN NAMEE varchar(128))
BEGIN

declare copies_made, copiesReturned, apotelesma, id_filou int;
declare not_found int;

declare s_cursor cursor for 
select ar_filou from filo where efim_filou=NAMEE;

declare continue handler for not found set not_found=1;

set not_found=0;
open s_cursor; 

repeat 
fetch s_cursor into id_filou;

if (not_found=0) then
select pub_copies,copies_returned into copies_made,copiesReturned
from filo
where ar_filou = id_filou;
set apotelesma = copies_made - copiesReturned;

select ar_filou, apotelesma from filo where  ar_filou = id_filou;
end if;

until(not_found=1)
end repeat;

close s_cursor;

end $

delimiter ;

call salesCursor('Nautemporiki');








