drop trigger if exists newEmployee;
delimiter $

create trigger newEmployee 
before insert on employee 
for each row
begin
set NEW.profit = 650;
end $
delimiter ;

