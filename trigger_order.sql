drop trigger if exists checkorder;
delimiter $

create trigger checkorder after insert on article
for each row 
begin
declare seira_new,seira_old int;

select new.order_in_fyllo into seira_new from article;

select order_in_fyllo into seira_old from article where publishedin = new.publishedin;

if( seira_new = seira_old) then
signal sqlstate value '45000'
set message_text = 'Yparxei hdh arthro se ayth th thesi.';
end if;

end$
delimiter ;

