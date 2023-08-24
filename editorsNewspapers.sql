use paper;

DROP PROCEDURE IF EXISTS editors;
DELIMITER $
CREATE PROCEDURE editors( IN NAMEE varchar(128))
BEGIN

select j_email from journalist 
inner join employee on j_email=email 
inner join Paper on workson = Papername
where j_specialty = 'editor-in-chief' and workson=NAMEE;

END $
delimiter ;

call editors('Bhma');