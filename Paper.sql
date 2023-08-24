DROP DATABASE IF EXISTS paper;
CREATE DATABASE paper;
USE paper;

CREATE TABLE publisher(

	AFM char(10) NOT NULL,
    pub_name VARCHAR(64) NOT NULL,
    pub_subname VARCHAR(64) NOT NULL,
    pub_email varchar(128) not null,
    pub_password varchar(64) not null,
    PRIMARY KEY (AFM)
);

CREATE TABLE `Paper` (

  `Papername` varchar(128) NOT NULL,
  `Frequency` enum('Daily','Weekly','Monthly') DEFAULT NULL,
  `Owner` varchar(45) DEFAULT NULL,
  `publishersAFM` char(10) NOT NULL,
  PRIMARY KEY (`Papername`),
  CONSTRAINT `parer_ibfk_1` FOREIGN KEY (`publishersAFM`) REFERENCES `publisher` (`AFM`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee` (
  `email` varchar(128) NOT NULL,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `profit` int NOT NULL,
  `registrated` datetime NOT NULL,
  `workson` varchar(128) NOT NULL,
  `e_published` char(10) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `douleuei` (`workson`),
  KEY `epejergazetai` (`e_published`),
  CONSTRAINT `douleuei` FOREIGN KEY (`workson`) REFERENCES `paper` (`Papername`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `epejergazetai` FOREIGN KEY (`e_published`) REFERENCES `publisher` (`AFM`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE administrative(
 
	admin_email varchar(128) not null,
    admin_name varchar(64) not null,
    admin_surname varchar(64) not null,
    admin_town varchar(64) not null,
    admin_street varchar(120) not null,
    admin_strnum char(20) not null,
    admin_duties enum('Secretary','Logistics') DEFAULT NULL,
    PRIMARY KEY(admin_email),
    CONSTRAINT `ISA1` FOREIGN KEY (`admin_email`) REFERENCES `employee` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE phone(
	a_email varchar(128) not null,
	a_phone char(10) not null,
    PRIMARY KEY (a_email,a_phone)
);

CREATE TABLE journalist
(
	j_email varchar(255) not null ,
	j_cv text not null,
	j_work_history int not null,
    j_specialty enum ('journalist','editor-in-chief') default null,
	primary key (j_email) ,
	constraint wrkr foreign key (j_email) references employee(email)
	on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `filo` (
  `ar_filou` int NOT NULL,
  `efim_filou` varchar(128) NOT NULL,
  `pages` int NOT NULL,
  `date_kikloforias` date NOT NULL,
  `editor_filou` varchar(255) NOT NULL,
  `condition_filou` enum('sikwnei_article','den_sikwnei_article') DEFAULT NULL,
  `current_pages` int DEFAULT '0',
  `pub_copies` int default null,
  `copies_returned` int default null,
  PRIMARY KEY (`ar_filou`,`efim_filou`),
  KEY `efim_filou` (`efim_filou`),
  KEY `tou_editor` (`editor_filou`),
  CONSTRAINT `ths_efimeridas` FOREIGN KEY (`efim_filou`) REFERENCES `paper` (`Papername`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tou_editor` FOREIGN KEY (`editor_filou`) REFERENCES `journalist` (`j_email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE category (
  idCategory int NOT NULL,
  `nameCategory` varchar(45) NOT NULL,
  `sumCategory` text not NULL,
  `childCategory`int DEFAULT NULL,
  editorInsert varchar(255) not null,
  PRIMARY KEY (`idCategory`),
  KEY `childCategory` (`childCategory`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`childCategory`) REFERENCES `category` (`idCategory`),
  constraint edtrinsrt
  foreign key (editorInsert) references journalist(j_email)
  on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `article` (
  `Path` varchar(256) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  `Summary` text,
  `artCategory` int DEFAULT NULL,
  `editorCheck` varchar(255) DEFAULT NULL,
  `editorComment` enum('APPROVED','REJECTED','TO_BE_REVISED') NOT NULL,
  `publishedin` int DEFAULT NULL,
  `order_in_fyllo` int default null,
  `dateCheck` date DEFAULT NULL,
  `pages_capacity` int DEFAULT NULL,
  PRIMARY KEY (`Path`),
  KEY `artclcatgr` (`artCategory`),
  KEY `edtrchck` (`editorCheck`),
  KEY `pblshdfl` (`publishedin`),
  CONSTRAINT `artclcatgr` FOREIGN KEY (`artCategory`) REFERENCES `category` (`idCategory`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `edtrchck` FOREIGN KEY (`editorCheck`) REFERENCES `journalist` (`j_email`),
  CONSTRAINT `pblshdfl` FOREIGN KEY (`publishedin`) REFERENCES `filo` (`ar_filou`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


create table submit_article(
	
    sub_journalist varchar(255) not null,
	sub_article varchar(256) not null,
    sub_date date not null,
	primary key(sub_journalist, sub_article),
	constraint sbmtjrnl
	foreign key (sub_journalist) references journalist(j_email)
	on delete cascade on update cascade,
	constraint sbmtartc
	foreign key (sub_article) references article(Path)
	on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table article_key
(
  key_for_article varchar(256) not null,
  the_key int NOT NULL,
  PRIMARY KEY (key_for_article,the_key),
  FOREIGN KEY (key_for_article) REFERENCES article(Path)
  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into publisher values
('1234567890','Maria','Papadimitriou','mariapap@gmail.com','2525252525'),
('0987654321','Giwrgos','Oikonomou','giwrgosoik@gmail.com','2424242424'),
('1234554321','Ioannis','Papadopoulos','ioannispap@gmail.com','2323232323');

insert into Paper values
('Nautemporiki','Weekly','Panos Athanasiadis','1234567890'),
('Prwtathlitis','Daily','Stelios Stasinopoulos','0987654321'),
('Rizospastis','Weekly','Giwrgos Filaretos','1234554321'),
('Bhma','Daily','Pantelis Kapsis','1234567890');

insert into employee values
('theodxristo@gmail.com','Theodwros','Xristou','0000000000',1200,'2010-08-01','Nautemporiki','1234567890'),
('stavropoulou@gmail.com','Katerina','Stavropoulou','1111111111',1000,'2016-02-20','Nautemporiki','1234567890'),
('mariaki@gmail.com','Lydia','Mariaki','2222222222',1650,'2010-04-18','Nautemporiki','1234567890'),
('anagnos@hotmail.gr','Eleni','Anagnwstou','3333333333',1450,'2011-11-12','Prwtathlitis','0987654321'),
('kosmopoulos@gmail.com','Antonis','Kosmopoulos','4444444444',1300,'2013-04-09','Prwtathlitis','0987654321'),
('fwtopoulos@hotmail.com','Giwrgos','Fwtopoulos','5555555555',750,'2019-03-03','Prwtathlitis','1234567890'),
('papadop@gmail.com','Panos','Papadopoulos','6666666666',1100,'2014-10-18','Rizospastis','1234554321'),
('papas@gmail.com','Kwstas','Papas','7777777777',1150,'2013-10-11','Rizospastis','1234554321'),
('zaxarm@mail.com','Maria','Zaxaropoulou','8888888888',1500,'2012-05-05','Rizospastis','1234554321'),
('neofytoue@gmail.com','Evaggelia','Neofytou','9999999999',1500,'2020-01-08','Bhma','1234567890'),
('nydriotis@gmail.com','Andreas','Nydriotis','1010101010',1400,'2014-01-02','Bhma','1234567890'),
('mapapad@yahoo.com','Makis','Papadas','1212121212',980,'2015-09-01','Bhma','1234567890');

insert into administrative values
('theodxristo@gmail.com','Theodwros','Xristou','Athina','Kalidromiou','139','Logistics'),
('papadop@gmail.com','Panos','Papadopoulos','Athina','Doiranis','94','Secretary'),
('neofytoue@gmail.com','Evaggelia','Neofytou','Athina','Kwsta Varnali','84','Logistics'),
('anagnos@hotmail.gr','Eleni','Anagnwstou','Athina','Solwnos','31','Secretary');

insert into phone values
('theodxristo@gmail.com','2116574890'),
('papadop@gmail.com','2128907904'),
('neofytoue@gmail.com','2106462893'),
('anagnos@hotmail.gr','2128574963');

insert into journalist values
('stavropoulou@gmail.com','Panteio - Eleutherotypia ws dhmosiografos',56,'editor-in-chief'),
('mariaki@gmail.com','IEK - XRHMA&AGORA ws dhmosiografos',90,'journalist'),
('kosmopoulos@gmail.com','TEI - Athlitiki Kyriakh ws dhmosiografos',24,'editor-in-chief'),
('fwtopoulos@hotmail.com','IEK - Sports magazine ws dhmosiografos',36,'journalist'),
('papas@gmail.com','Panteio - Odhghths ws editor',86,'editor-in-chief'),
('zaxarm@mail.com','Panteio - Laiki hmerhsia ws dhmosiografos',73,'journalist'),
('nydriotis@gmail.com','IEK - Ta Nea ws editor',53,'editor-in-chief'),
('mapapad@yahoo.com','TEI - Eleytherotypia ws dhmosiografos',37,'journalist');

insert into filo values
(12345,'Nautemporiki',30,'2020-03-12','stavropoulou@gmail.com','sikwnei_article',DEFAULT,150,50),
(54321,'Prwtathlitis',30,'2020-02-10','kosmopoulos@gmail.com','sikwnei_article',DEFAULT,200,5),
(54322,'Prwtathlitis',30,'2020-02-11','kosmopoulos@gmail.com','sikwnei_article',DEFAULT,350,100),
(25881,'Bhma',30,'2020-04-10','nydriotis@gmail.com','sikwnei_article',DEFAULT,400,250),
(99663,'Rizospastis',30,'2020-04-19','papas@gmail.com','sikwnei_article',DEFAULT,200,80),
(12645,'Nautemporiki',30,'2020-08-12','stavropoulou@gmail.com','sikwnei_article',DEFAULT,210,90);

insert into category values
(00001,'Podosfairo', 'Ekselikseis gia omades eswterikou ekswterikou.',null,'kosmopoulos@gmail.com'),
(00002,'Metagrafes eswterikou','Ekselikseis gia omades podosfairou eswterikou',00001,'kosmopoulos@gmail.com'),
(00003,'Politiki','Diethneis k eswterikes ekselikseis.',null,'nydriotis@gmail.com'),
(00004,'Eswteriki politiki','Apofaseis eswterikou', 00003, 'nydriotis@gmail.com' ),
(00005,'Antipoliteush','Enstaseis-diafwnies',null,'papas@gmail.com'),
(00006,'Xrhmatisthrio','Metoxes nauthliakwn',null,'stavropoulou@gmail.com');

insert into article values
('E:\Users\Articles\Submitted\Article_34.doc','WWIII','Ekselikseis Ameriki-Iran.',00003,'nydriotis@gmail.com','APPROVED',25881,1,'2020-02-3','3'),
('C:\Desktop\ArticlesSubmitted\Article_5.doc','To kinitro Simanski.','Nea metagrafi AEK.',00002,'kosmopoulos@gmail.com','APPROVED',54321,1,'2020-01-15','3'),
('E:\Users\Articles\Submitted\Article_14.doc','Kovetai to tsipouro!','Nomos kata toy xyma tsipourou.',00004,'nydriotis@gmail.com','TO_BE_REVISED',25881,2,'2020-01-30','2'),
('C:\Desktop\ArticlesSubmitted\Article_39.doc','Manchester United','Aneliksi.',00001,'kosmopoulos@gmail.com','REJECTED',54322,1,'2019-12-30','5');

insert into article_key values
('E:\Users\Articles\Submitted\Article_34.doc',99991),
('C:\Desktop\ArticlesSubmitted\Article_5.doc',12345),
('E:\Users\Articles\Submitted\Article_14.doc',67678),
('C:\Desktop\ArticlesSubmitted\Article_39.doc',98767);

insert into submit_article values
('mapapad@yahoo.com','E:\Users\Articles\Submitted\Article_34.doc','2020-01-28'),
('fwtopoulos@hotmail.com','C:\Desktop\ArticlesSubmitted\Article_5.doc','2020-01-10'),
('mapapad@yahoo.com','E:\Users\Articles\Submitted\Article_14.doc','2020-01-26'),
('fwtopoulos@hotmail.com','C:\Desktop\ArticlesSubmitted\Article_39.doc','2019-12-19');


//*nsert into article values
('C:\Desktop\ArticlesSubmitted\Article_329.doc','Manchester United','Aneliksi.',00001,'kosmopoulos@gmail.com','REJECTED',54322,1,'2019-12-30','5');*/