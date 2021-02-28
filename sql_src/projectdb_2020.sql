DROP DATABASE newspapper;

CREATE DATABASE newspapper;

USE newspapper;

CREATE TABLE newspapper(
   name VARCHAR(50) NOT NULL, 
   publication_date ENUM('Daily','Weekly','Monthly'), 
   owner VARCHAR(100),
   PRIMARY KEY(name)
);

CREATE TABLE employee(
   email VARCHAR(50) NOT NULL, 
   name VARCHAR(50), 
   last_name VARCHAR(50), 
   password VARCHAR(50) NOT NULL,
   salary INT(5), 
   hire_date DATE, 
   PRIMARY KEY(email),
   newspapper_name VARCHAR(100) NOT NULL, 
   CONSTRAINT const1 
   FOREIGN KEY(newspapper_name) 
   REFERENCES newspapper(name) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE journalist(
   email VARCHAR(50) NOT NULL,
   work_experience TEXT, 
   cv TEXT,
   PRIMARY KEY(email),
   CONSTRAINT const2 
   FOREIGN KEY(email) 
   REFERENCES employee(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE chief_editor(
   email VARCHAR(50) NOT NULL,
   PRIMARY KEY(email), 
   CONSTRAINT const3 
   FOREIGN KEY(email)
   REFERENCES journalist(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE simple_journalist(
   email VARCHAR(50) NOT NULL,
   PRIMARY KEY(email), 
   CONSTRAINT const4 
   FOREIGN KEY(email)
   REFERENCES journalist(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE administrator(
   email VARCHAR(50) NOT NULL,
   duties ENUM('Secretary','Logistics'),
   route VARCHAR(50), 
   number VARCHAR(10),
   city VARCHAR(50),
   PRIMARY KEY(email), 
   CONSTRAINT const5 
   FOREIGN KEY(email) 
   REFERENCES employee(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE phone_numbers(
   email VARCHAR(50) NOT NULL,
   phone_number VARCHAR(30), 
   PRIMARY KEY(email, phone_number),
   CONSTRAINT const6 
   FOREIGN KEY(email) 
   REFERENCES administrator(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category(
   code INT NOT NULL, 
   description TEXT,
   name VARCHAR(120),
   parent INT, 
   PRIMARY KEY(code),
   CONSTRAINT const7 
   FOREIGN KEY(parent)
   REFERENCES category(code) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE papper(
   number INT NOT NULL,
   pages INT DEFAULT 30,
   publication_date DATE,
   newspapper_name VARCHAR(100) NOT NULL,
   PRIMARY KEY(number, newspapper_name),
   CONSTRAINT const8 
   FOREIGN KEY(newspapper_name) 
   REFERENCES newspapper(name) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE article(
   path VARCHAR(200) NOT NULL,
   title VARCHAR(100), 
   summary TEXT, 
   category_code INT,
   idPapper INT,
   PRIMARY KEY(path),
   CONSTRAINT const9 
   FOREIGN KEY(category_code) 
   REFERENCES category(code) 
   ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT const10 
   FOREIGN KEY(idPapper) 
   REFERENCES papper(number) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE key_words(
   path VARCHAR(200) NOT NULL, 
   key_word VARCHAR(120), 
   PRIMARY KEY(path, key_word),
   CONSTRAINT const11 
   FOREIGN KEY(path)
   REFERENCES article(path) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE working(
   email VARCHAR(50) NOT NULL,
   path VARCHAR(200) NOT NULL,
   submit_date DATE,
   PRIMARY KEY(email, path),
   CONSTRAINT const12 
   FOREIGN KEY(path) 
   REFERENCES article(path) 
   ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT const13 
   FOREIGN KEY(email) 
   REFERENCES simple_journalist(email) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE checks(
   code INT NOT NULL AUTO_INCREMENT,
   email VARCHAR(50), 
   path VARCHAR(200), 
   result_of_codes ENUM('accepted','rejected','needs_modification'),
   date_of_confirmation DATE,
   start_page INT,
   PRIMARY KEY(code),
   CONSTRAINT const14 
   FOREIGN KEY(email) 
   REFERENCES chief_editor(email) 
   ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT const15 
   FOREIGN KEY(path) 
   REFERENCES article(path) 
   ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE selects(
   code INT NOT NULL,
   email VARCHAR(50), 
   path VARCHAR(200),
   selected BOOLEAN, 
   selection_row INT,
   PRIMARY KEY(code),
   CONSTRAINT const16 
   FOREIGN KEY(email) 
   REFERENCES chief_editor(email) 
   ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT const17 
   FOREIGN KEY(path) 
   REFERENCES article(path) 
   ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO newspapper VALUES('Ta Nea','Daily','Marinakis');
INSERT INTO newspapper VALUES('To Bima','Weekly','Psixaris');

 
INSERT INTO employee VALUES('stefotsi@gmail.com','Stefania','Tsilibaki','stefania123',1500,'2007-09-01','To Bima');
INSERT INTO employee VALUES('annampellou@gmail.com','anna','mpellou','anna123',2100,'2001-06-01','Ta Nea');
INSERT INTO employee VALUES('eirinaki@gmail.com','Eirini','Rouxwta','eirini123',1900,'2009-05-01','To Bima');
INSERT INTO employee VALUES('dimin99@gmail.com','Dimosthenis','Minas','dimos123',2500,'2006-06-01','Ta Nea');
INSERT INTO employee VALUES('dimosminas@gmail.com','Fanis','Gekas','fanis123',1700,'2010-05-01','Ta Nea');
INSERT INTO employee VALUES('PanagiotisArapis@gmail.com','Panagiotis','Arapis','panagiwtis123',1800,'2008-05-01','To Bima');
INSERT INTO employee VALUES('prwtotipo@gmail.com','Dimitra','Gariza','dimitra123',1900,'2009-05-01','To Bima');
INSERT INTO employee VALUES('staurosalexiou@gmail.com','Stauros','Alexiou','steve123',1900,'2009-05-01','To Bima');
INSERT INTO employee VALUES('tzimistube@gmail.com','Iakwbos','Takis','iakwvos123',1500,'2004-06-01','Ta Nea');
INSERT INTO employee VALUES('wraioskai@gmail.com','Xristos','Gewrgiadis','xristos123',2100,'2006-05-01','Ta Nea'); 


INSERT INTO journalist VALUES('dimin99@gmail.com','Journalist NOvember 2003 - present     Investigate questions and timely story ideas in the community as developments happen and create news stories detailing breaking events.     - Compose a variety of stories for print news and an additional online edition of a local newspaper by using reserach notes, assignment detail the basics of working for a major organization.',' Talented and immensely creative journalist with a commitment to high-qualityh research and wrting. Proven history of acgievement in the industry with more than 10 years of professional experience. Dedication to sound investigative reserach methods and a strong desire to know the truth of the matter. Ecellent reporting and interviewing skills and award-winning writing techniques. Experience writing and reporting across a variery of platforms, including print, television, and online social media.');
INSERT INTO journalist VALUES('dimosminas@gmail.com','Staff Reporter - The Fast Time- September 2000-Present    -Reported local news and updated stories based on reports from the field.     - Covered some community events.    - Maintained community events calendar(print version and website version).','Experienced multimedia journalist with a background in investigative reporting. Expert in interviewing, reporting, fact-checking, and working on a deadline. Excel at cinematic storytelling and sourcing images, sound bites, and video for multimedia publication. I work well with photographers and video agraphers when not shooting my own stories, and love to collaborate on large, in-depth features.'); 
INSERT INTO journalist VALUES('PanagiotisArapis@gmail.com','Journalist,2005 to present to the The Watcher, New York,NY','Prepares investigative content for online publication performs thorough research and secures information sources.     - Writes for the web and makes final decisions on feature stories and layout design. Edits and reviews aticles of junior writers and accuracy, clarity, and libel.');-- dimosiografos kathimerinis
INSERT INTO journalist VALUES('wraioskai@gmail.com','Breaking News Reporter - The Paper News Print Division - September 2000-Present    -Reported breaking news throughout the Denver Metro.     -Traveled extensively throughout the regino to uncover stories.    - Managed mobile photography and videography equipment.     -Collaborated with photographers, camera operators, and others in the field.    - Built relationships with relevant sources on the beat, including city and county officials, school board members, and law enforcement.','A dedicated journalist who is keen on exploring unexpected angles and equipped with 7 years of prolific wrting experience in different avenues seeks to join Blank Pages pool of writers in producing factual, ethical and impactful investigative articles.'); -- dimosiografos-arxisyntaktis ethnous
INSERT INTO journalist VALUES('staurosalexiou@gmail.com','Sr. Journalist,2007-Present The New York Times Company, New York, NY','Profile Summary Solid background in political science    -Abreast with latest public news and affairs   - Solid understanding of Journalism ethics    - Solid technical knowledge in broadcast media'); 
INSERT INTO journalist VALUES('eirinaki@gmail.com','Jr. Journalist,2006-2007 News Corporation, Newyork,NY','Professional Summary    Talented and immensely creative journalist with a commitment to high-quality research and writing. Proven history of achievement in the industry with more than 10 years of professional experience. Dedication to sound investigative reserach methods and a strong desire to know the truth of the matter. Excellent reporting and interviewing skills and award-winning writing techniques. Experience writing and reporting across a variety of platforms, including print, television, and online social media.'); -- dimosiografos ethnous

 
INSERT INTO chief_editor VALUES('dimosminas@gmail.com'); 
INSERT INTO chief_editor VALUES('eirinaki@gmail.com');


INSERT INTO simple_journalist VALUES('dimin99@gmail.com'); 
INSERT INTO simple_journalist VALUES('wraioskai@gmail.com');
INSERT INTO simple_journalist VALUES('PanagiotisArapis@gmail.com');
INSERT INTO simple_journalist VALUES('staurosalexiou@gmail.com');


INSERT INTO administrator VALUES('tzimistube@gmail.com','Secretary','Kalomoiri Manwli',45,'Patra'); 
INSERT INTO administrator VALUES('annampellou@gmail.com','Logistics','Kalomoiri Manwli',45,'Patra'); 
INSERT INTO administrator VALUES('stefotsi@gmail.com','Logistics','Kalomoiri Manwli',45,'Patra');
INSERT INTO administrator VALUES('prwtotipo@gmail.com','Secretary','Kalomoiri Manwli',45,'Patra');


INSERT INTO phone_numbers VALUES('stefotsi@gmail.com','1234321412');
INSERT INTO phone_numbers VALUES('prwtotipo@gmail.com','261019999');
INSERT INTO phone_numbers VALUES('tzimistube@gmail.com','699999999'); 
INSERT INTO phone_numbers VALUES('annampellou@gmail.com','699999999');


INSERT INTO category VALUES(1,'Politika','Pasok',null);
INSERT INTO category VALUES(2,'Oikonomika','Oikononika Pasok',null);
INSERT INTO category VALUES(3,'Koinonika','Tsobolas',null);
INSERT INTO category VALUES(4,'Kosmika','Menegaki',null);
INSERT INTO category VALUES(5,'Athlitika','Olympiakos',null);
INSERT INTO category VALUES(101,'Esoterili Politiki','Anhkei sthn yperkathgoria Politika',1);
INSERT INTO category VALUES(102,'Exoterili Politiki','Anhkei sthn yperkathgoria Politika',1);
INSERT INTO category VALUES(1020,'Ellhnotourkies Sxeseis','Anhkei sthn yperkathgoria Exoteriki Politiki',101);
INSERT INTO category VALUES(1021,'Metanasteytiko','Anhkei sthn yperkathgoria Exoteriki Politiki',101);
INSERT INTO category VALUES(1022,'Eyropaiki Enosi','Anhkei sthn yperkathgoria Exoteriki Politiki',101);


INSERT INTO papper VALUES(1045,2,'2020-1-10','Ta Nea');
INSERT INTO papper VALUES(1046,30,'2020-2-11','Ta Nea');
INSERT INTO papper VALUES(2055,10,'2019-02-11','To Bima');
INSERT INTO papper VALUES(2056,40,'2019-3-11','To Bima');


INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article34a.doc','Koronaios','Arnitikos ston koronaio o kinezos touristas pou eisixthi sto Attiko nosokimeio',3,1045);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article34b.doc','Brexit','I bathia odini tis germanias sto brexit',102,1045);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article35a.doc','Olympiakos','O Olympiakos nikise tin Lamia',5,1046);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article35b.doc','Dorean Farmaka','Prosfora farmakon se oikonomika aseneis',4,1046);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article40a.doc','Misthos Bouleutwn','Oi bouleutes pairnw 5000 eurw',1,2055);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article40b.doc','Ellada','H Ellada einai politika adinami',1020,2055);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article41a.doc','Panathinaikos','Ston panathinaiko o Lionel Messi',5,2056);
INSERT INTO article VALUES('C:\Users\Articles\Sumbitted\Article41b.doc','Tsobalas','O Tsobolas xoreuei me tin neolaia',4,2056);
 

INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article34a.doc','Koronaios');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article34b.doc','Brexit');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article35a.doc','Olympiakos');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article35b.doc','Farmako');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article40a.doc','Boleytes');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article40b.doc','Ellada,politiki');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article41a.doc','Panathinaikos');
INSERT INTO key_words VALUES('C:\Users\Articles\Sumbitted\Article41b.doc','Tsobolas');


INSERT INTO working VALUES('dimin99@gmail.com','C:\Users\Articles\Sumbitted\Article34a.doc','2020-02-11');
INSERT INTO working VALUES('wraioskai@gmail.com','C:\Users\Articles\Sumbitted\Article34a.doc','2020-02-11');
INSERT INTO working VALUES('dimin99@gmail.com','C:\Users\Articles\Sumbitted\Article34b.doc','2020-02-11');
INSERT INTO working VALUES('wraioskai@gmail.com','C:\Users\Articles\Sumbitted\Article34b.doc','2020-02-11');
INSERT INTO working VALUES('wraioskai@gmail.com','C:\Users\Articles\Sumbitted\Article35a.doc','2020-02-11');
INSERT INTO working VALUES('wraioskai@gmail.com','C:\Users\Articles\Sumbitted\Article35b.doc','2020-02-11');
INSERT INTO working VALUES('PanagiotisArapis@gmail.com','C:\Users\Articles\Sumbitted\Article40a.doc','2019-02-11');
INSERT INTO working VALUES('staurosalexiou@gmail.com','C:\Users\Articles\Sumbitted\Article40b.doc','2019-02-11');
INSERT INTO working VALUES('staurosalexiou@gmail.com','C:\Users\Articles\Sumbitted\Article41a.doc','2019-3-11');
INSERT INTO working VALUES('staurosalexiou@gmail.com','C:\Users\Articles\Sumbitted\Article41b.doc','2019-3-11');
INSERT INTO working VALUES('PanagiotisArapis@gmail.com','C:\Users\Articles\Sumbitted\Article41a.doc','2019-3-11');
INSERT INTO working VALUES('PanagiotisArapis@gmail.com','C:\Users\Articles\Sumbitted\Article41b.doc','2019-3-11');


INSERT INTO checks VALUES(null,'dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article34a.doc','accepted','2020-02-12',1);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article34b.doc','rejected',null,null);
INSERT INTO checks VALUES(null,'dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article35a.doc','accepted','2020-02-11',2);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article35b.doc','needs_modification',null,null);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article40a.doc','accepted','2019-02-11',1);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article40b.doc','rejected',null,null);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article41a.doc','accepted','2019-3-11',2);
INSERT INTO checks VALUES(null,'eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article41b.doc','needs_modification',null,null);
 
 
INSERT INTO selects values('23','dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article34a.doc',true,1);
INSERT INTO selects values('24','dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article34b.doc',false,null);
INSERT INTO selects values('25','dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article35a.doc',true,2);
INSERT INTO selects values('26','dimosminas@gmail.com','C:\Users\Articles\Sumbitted\Article35b.doc',false,null);
INSERT INTO selects values('38','eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article40a.doc',true,1);
INSERT INTO selects values('39','eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article40b.doc',false,null);
INSERT INTO selects values('40','eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article41a.doc',true,2);
INSERT INTO selects values('41','eirinaki@gmail.com','C:\Users\Articles\Sumbitted\Article41b.doc',false,null);
-- INSERT INTO selects values('04','papad@hotmail.com','C:\Users\Articles\Sumbitted\Article34a.doc',true,1);
 


DROP PROCEDURE IF EXISTS procedure_1;
delimiter $
CREATE PROCEDURE procedure_1 (IN arithmos_fyllou INT,IN onoma_efimeridas VARCHAR(100))
BEGIN
	DECLARE not_found INT;
	DECLARE arithmos_selidas INT;
	DECLARE plithos INT;
	DECLARE titlos VARCHAR(100);
	DECLARE path VARCHAR(200);
	DECLARE email1 VARCHAR(50);
	DECLARE email2 VARCHAR(50);
	DECLARE hmerom_egrisis DATE;
	DECLARE selida INT;
	DECLARE ypoloipo INT;
	
    DECLARE bcursor CURSOR FOR SELECT DISTINCT papper.pages, title, article.path,
    chief_editor.email AS chief_editor,
    simple_journalist.email AS syntak,
    date_of_confirmation,
    start_page,
    COUNT(pages) AS synolo
	FROM article, selects, working, papper, simple_journalist, chief_editor, checks, newspapper
    WHERE papper.number = article.idPapper 
    AND article.path = working.path 
    AND working.email = simple_journalist.email 
    AND article.path = selects.path
    AND selects.email = chief_editor.email 
    AND checks.email = chief_editor.email 
    AND checks.path = selects.path 
    AND newspapper.name = papper.newspapper_name
	AND newspapper.name = onoma_efimeridas 
    AND papper.number = arithmos_fyllou
	GROUP BY papper.number;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_found=1;
	SET not_found=0;
	OPEN bcursor;
	 REPEAT 
	   	 FETCH bcursor INTO selida, titlos, path, email1, email2, hmerom_egrisis, arithmos_selidas, plithos;
		 IF(not_found = 0) THEN
			 SELECT titlos, path, email1, email2, hmerom_egrisis, arithmos_selidas, plithos;
		 END IF;
		
        IF (selida > plithos) THEN
			 SET ypoloipo = selida - plithos;
			 SELECT 'Yparxei akoma xoros gia selides = ', ypoloipo;
		 END IF;
	 UNTIL (not_found = 1)
	 END REPEAT;
	CLOSE bcursor;
	END$
delimiter ;


CALL procedure_1(1045,'Ta Nea');
 

DROP PROCEDURE IF EXISTS procedure_2;

delimiter $

CREATE PROCEDURE procedure_2 (IN email1 VARCHAR(50))

BEGIN

                DECLARE imer_proslip DATE;
				DECLARE ypallhlos VARCHAR(50); 
                DECLARE duration, misthos INT;

                DECLARE bcursor CURSOR FOR SELECT email, hire_date, salary 
                FROM employee 
                WHERE employee.email = email1;

                OPEN bcursor;
               
					FETCH bcursor 
					INTO ypallhlos, imer_proslip, misthos;

					SELECT ypallhlos, imer_proslip;
					-- SELECT PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM imer_proslip)) AS months FROM imer_proslip;
					SELECT TIMESTAMPDIFF(MONTH, imer_proslip, now()) 
                    INTO duration;
                    SELECT duration, 0.5 * misthos * duration;

                CLOSE bcursor;

END$

delimiter ;

 
CALL procedure_2('stefotsi@gmail.com');
CALL procedure_2('annampellou@gmail.com');
CALL procedure_2('eirinaki@gmail.com');
CALL procedure_2('dimin99@gmail.com');
CALL procedure_2('PanagiotisArapis@gmail.com');
CALL procedure_2('dimosminas@gmail.com');
CALL procedure_2('prwtotipo@gmail.com');
CALL procedure_2('staurosalexiou@gmail.com');


DROP TRIGGER IF EXISTS trigger_1;

delimiter $

CREATE TRIGGER trigger_1 
BEFORE INSERT ON employee

FOR EACH ROW

BEGIN

                SET NEW.salary=650;

END$

delimiter ;

 
INSERT INTO employee VALUES('kappa@gmail.com','Kappa','Keepo','kappa123',800,'2015-01-05','Ta Nea');
INSERT INTO employee VALUES('kappakeepo@gmail.com','Keeppo','Creepo','keepo123',750,'2016-06-03','To Bima');



DROP TRIGGER IF EXISTS trigger_2;

delimiter $

CREATE TRIGGER trigger_2 
BEFORE INSERT ON checks

FOR EACH ROW

BEGIN

                DECLARE email1 VARCHAR(50);
                DECLARE bcursor CURSOR FOR SELECT checks.email 
                FROM chief_editor 
                INNER JOIN checks 
                ON chief_editor.email = checks.email 
                WHERE checks.email = NEW.email;

                OPEN bcursor;

					FETCH bcursor INTO email1;

					IF NEW.email = email1 THEN

						SET NEW.result_of_codes = 'accepted';

					END IF;

                CLOSE bcursor;

END$

delimiter ;

 
-- INSERT INTO checks VALUES(null,'mariad@hotmail.com','C:\Users\Articles\Sumbitted\Article35b.doc','rejected','2020-3-3',29);


DROP TRIGGER IF EXISTS trigger_3;

delimiter $

CREATE TRIGGER trigger_3 BEFORE INSERT ON selects

FOR EACH ROW

BEGIN

                DECLARE plithos INT;
                DECLARE selida INT;
                DECLARE email1 VARCHAR(50);
				DECLARE bcursor CURSOR FOR SELECT selects.email, pages, 
                COUNT(code) 
                FROM selects 
                INNER JOIN article 
                ON selects.path = article.path 
                INNER JOIN papper 
                ON article.idPapper=papper.number 
                INNER JOIN chief_editor 
                ON chief_editor.email = selects.email 
                WHERE NEW.email = selects.email 
                AND NEW.path=selects.path 
                GROUP BY papper.number;

                OPEN bcursor;

					FETCH bcursor INTO email1, selida, plithos;

					IF plithos > selida THEN

						SIGNAL SQLSTATE VALUE '45000' 
                        SET MESSAGE_TEXT = 'den eparkoun oi selides';

					END IF;

                CLOSE bcursor;

END$

delimiter ;
