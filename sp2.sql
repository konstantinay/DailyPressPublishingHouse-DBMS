use paper;

DROP PROCEDURE IF EXISTS raise_profit;
DELIMITER $
CREATE PROCEDURE raise_profit(in emailll varchar(128))
BEGIN
    
    declare currDate  date;
    declare e_date    date;
    declare mhnestwrinhsdouleias   int;
    declare past      int;
    declare income    int;
    declare raise     int;
    declare vasikos int;
    declare synolikoimhnes int;
    set vasikos=650;
    
    set currDate = CURDATE();
    
    select registrated into e_date from journalist inner join  employee on employee.email = journalist.j_email where j_email = emailll;
    select j_work_history into past from journalist where j_email = emailll;
    select profit into income from journalist  inner join employee on j_email = email where j_email = emailll;
	
    
    SELECT DATEDIFF(currDate, e_date) INTO mhnestwrinhsdouleias;
    set synolikoimhnes = mhnestwrinhsdouleias  + past;
    set raise =  synolikoimhnes * 0.005;
    set income = vasikos + raise;   
    UPDATE employee SET profit = income WHERE email=emailll;
 END $
DELIMITER ;

call raise_profit('fwtopoulos@hotmail.com');