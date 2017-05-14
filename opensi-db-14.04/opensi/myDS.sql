-- MySQL dump 10.9
--
-- Host: localhost    Database: myDS
-- ------------------------------------------------------
-- Server version  4.1.12-Debian_1ubuntu3.7-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `BLOB_DATA` blob,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--


/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `CALENDAR_NAME` varchar(80) NOT NULL default '',
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY  (`CALENDAR_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_CALENDARS`
--


/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
LOCK TABLES `QRTZ_CALENDARS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `CRON_EXPRESSION` varchar(80) NOT NULL default '',
  `TIME_ZONE_ID` varchar(80) default NULL,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--


/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `ENTRY_ID` varchar(95) NOT NULL default '',
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `IS_VOLATILE` char(1) NOT NULL default '',
  `INSTANCE_NAME` varchar(80) NOT NULL default '',
  `FIRED_TIME` bigint(13) NOT NULL default '0',
  `STATE` varchar(16) NOT NULL default '',
  `JOB_NAME` varchar(80) default NULL,
  `JOB_GROUP` varchar(80) default NULL,
  `IS_STATEFUL` char(1) default NULL,
  `REQUESTS_RECOVERY` char(1) default NULL,
  PRIMARY KEY  (`ENTRY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--


/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `JOB_NAME` varchar(80) NOT NULL default '',
  `JOB_GROUP` varchar(80) NOT NULL default '',
  `DESCRIPTION` varchar(120) default NULL,
  `JOB_CLASS_NAME` varchar(128) NOT NULL default '',
  `IS_DURABLE` char(1) NOT NULL default '',
  `IS_VOLATILE` char(1) NOT NULL default '',
  `IS_STATEFUL` char(1) NOT NULL default '',
  `REQUESTS_RECOVERY` char(1) NOT NULL default '',
  `JOB_DATA` blob,
  PRIMARY KEY  (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `QRTZ_JOB_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_LISTENERS`;
CREATE TABLE `QRTZ_JOB_LISTENERS` (
  `JOB_NAME` varchar(80) NOT NULL default '',
  `JOB_GROUP` varchar(80) NOT NULL default '',
  `JOB_LISTENER` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_JOB_LISTENERS`
--


/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` DISABLE KEYS */;
LOCK TABLES `QRTZ_JOB_LISTENERS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `LOCK_NAME` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`LOCK_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_LOCKS`
--


/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
LOCK TABLES `QRTZ_LOCKS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--


/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `INSTANCE_NAME` varchar(80) NOT NULL default '',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL default '0',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL default '0',
  `RECOVERER` varchar(80) default NULL,
  PRIMARY KEY  (`INSTANCE_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--


/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `REPEAT_COUNT` bigint(7) NOT NULL default '0',
  `REPEAT_INTERVAL` bigint(12) NOT NULL default '0',
  `TIMES_TRIGGERED` bigint(7) NOT NULL default '0',
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `JOB_NAME` varchar(80) NOT NULL default '',
  `JOB_GROUP` varchar(80) NOT NULL default '',
  `IS_VOLATILE` char(1) NOT NULL default '',
  `DESCRIPTION` varchar(120) default NULL,
  `NEXT_FIRE_TIME` bigint(13) default NULL,
  `PREV_FIRE_TIME` bigint(13) default NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL default '',
  `TRIGGER_TYPE` varchar(8) NOT NULL default '',
  `START_TIME` bigint(13) NOT NULL default '0',
  `END_TIME` bigint(13) default NULL,
  `CALENDAR_NAME` varchar(80) default NULL,
  `MISFIRE_INSTR` smallint(2) default NULL,
  `JOB_DATA` blob,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Table structure for table `QRTZ_TRIGGER_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGER_LISTENERS`;
CREATE TABLE `QRTZ_TRIGGER_LISTENERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL default '',
  `TRIGGER_GROUP` varchar(80) NOT NULL default '',
  `TRIGGER_LISTENER` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QRTZ_TRIGGER_LISTENERS`
--


/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` DISABLE KEYS */;
LOCK TABLES `QRTZ_TRIGGER_LISTENERS` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

