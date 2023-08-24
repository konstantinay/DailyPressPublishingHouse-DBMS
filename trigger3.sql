drop trigger if exists checkfilo;
delimiter $

create trigger checkfilo before insert on article
for each row 
begin 

declare katastasi_f enum('sikwnei_article','den_sikwnei_article');
declare selides_f, selides_a, counter int;
declare comment_e enum ('APPROVED','REJECTED','TO_BE_REVISED');

select new.pages_capacity into selides_a; 
select new.editorComment into comment_e;

select filo.condition_filou into katastasi_f from filo where new.publishedin = ar_filou;
select filo.current_pages into selides_f from filo where new.publishedin = ar_filou;

set counter = selides_f + selides_a;

if (comment_e = 'APPROVED') then
	if (katastasi_f = 'sikwnei_article') then
		if(counter>30) then
		signal sqlstate value '45000'
		set message_text = 'To fyllo den mporei na exei panw apo 30 selides.';
		
		else 
		UPDATE filo SET current_pages = counter where new.publishedin = ar_filou;
		
			if (counter = 30)then
			UPDATE filo SET condition_filou = 'den_sikwnei_article' where new.publishedin = ar_filou;
			end if;
		
		end if;
		
	else 
	signal sqlstate value '45000'
	set message_text = 'To fyllo apoteleitai hdh 30 selides.';

	end if;

else 
signal sqlstate value '45000'    
set message_text = 'To arthro den einai APPROVED.';

end if;

end $

delimiter ;
