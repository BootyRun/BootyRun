DROP DATABASE IF EXISTS brquestions;
DELETE FROM mysql.user WHERE user='booty';
DELETE FROM mysql.db WHERE user='booty';
FLUSH PRIVILEGES;
CREATE DATABASE brquestions DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE brquestions;

CREATE TABLE IF NOT EXISTS quser (
	id int(11) NOT NULL AUTO_INCREMENT,
	userid varchar(256) DEFAULT NULL,
	questionid int(11) DEFAULT NULL,
	askdate timestamp DEFAULT CURRENT_TIMESTAMP,
	correct boolean DEFAULT false,
	PRIMARY KEY (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `question` (
	id int(11) NOT NULL AUTO_INCREMENT,
	questiontext varchar(256) DEFAULT NULL,
	active boolean DEFAULT true,
	PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `answer` (
	id int(11) NOT NULL AUTO_INCREMENT,
	questionid int(11) DEFAULT NULL,
	answertext varchar(256) DEFAULT NULL,
	correct boolean DEFAULT false,
	PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE USER 'booty'@'%' IDENTIFIED BY 'booty';
GRANT ALL ON brquestions.* to 'booty'@'%';