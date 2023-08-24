DROP trigger IF EXISTS check_article;
DELIMITER $

CREATE TRIGGER check_article AFTER INSERT ON submit_article
FOR EACH ROW
BEGIN
	
    declare speciality  enum('journalist','editor-in-chief');
    
    select j_specialty into speciality from submit_article inner join journalist on j_email=sub_journalist where new.sub_journalist = j_email;
    
    if(speciality = 'editor-in-chief')THEN       
      UPDATE article SET editorCheck = new.sub_journalist , editorComment = 'APPROVED' WHERE path = new.sub_article;
	END IF;
        
END$

DELIMITER ;