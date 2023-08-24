DROP PROCEDURE IF EXISTS print_article;
DELIMITER $
CREATE PROCEDURE print_article(in filaraki int,in efimerida varchar(128))
BEGIN

    DECLARE rest_pages int;
    DECLARE cap_filou INT;
    DECLARE count_pages int;
    DECLARE conditionf enum('sikwnei_article','den_sikwnei_article');
    
    SELECT condition_filou INTO conditionf FROM filo WHERE ar_filou = filaraki and efim_filou = efimerida;
    SELECT current_pages INTO cap_filou from filo where  ar_filou = filaraki and efim_filou = efimerida;
    SELECT pages INTO count_pages FROM filo WHERE  ar_filou = filaraki and efim_filou = efimerida;
    
    SELECT title,editorCheck,dateCheck,pages_capacity,condition_filou,order_in_fyllo from article 
    INNER JOIN filo on publishedin = ar_filou
    WHERE publishedin = filaraki 
    ORDER BY order_in_fyllo asc;
    
    
    IF(conditionf = 'sikwnei_article')THEN
		
        SET rest_pages = count_pages - cap_filou ;
        SELECT rest_pages AS DiathesimesSelides;
        
	END IF;
    
       
    
 END $
DELIMITER ;

CALL print_article('25881','Bhma');