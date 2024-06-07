CREATE DATABASE  IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336project`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraftID` char(10) NOT NULL,
  `airlineID` char(2) NOT NULL,
  `num_seats` int DEFAULT NULL,
  `operate_days` set('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') DEFAULT NULL,
  PRIMARY KEY (`aircraftID`,`airlineID`),
  KEY `airlineID` (`airlineID`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `airline_company` (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('1234567890');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline_company`
--

DROP TABLE IF EXISTS `airline_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline_company` (
  `airlineID` char(2) NOT NULL,
  PRIMARY KEY (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline_company`
--

LOCK TABLES `airline_company` WRITE;
/*!40000 ALTER TABLE `airline_company` DISABLE KEYS */;
INSERT INTO `airline_company` VALUES ('AA'), ('BB'), ('CC'), ('DD'), ('EE'), ('FF'), ('GG'), ('HH');
/*!40000 ALTER TABLE `airline_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airportID` char(3) NOT NULL,
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('IAD'), ('EWR');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_airline`
--

DROP TABLE IF EXISTS `airport_airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_airline` (
  `airportID` char(3) NOT NULL,
  `airlineID` char(2) NOT NULL,
  PRIMARY KEY (`airportID`,`airlineID`),
  KEY `airlineID` (`airlineID`),
  CONSTRAINT `airport_airline_ibfk_1` FOREIGN KEY (`airportID`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `airport_airline_ibfk_2` FOREIGN KEY (`airlineID`) REFERENCES `airline_company` (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_airline`
--

LOCK TABLES `airport_airline` WRITE;
/*!40000 ALTER TABLE `airport_airline` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport_airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_num` int NOT NULL,
  `airlineID` char(2) NOT NULL,
  `aircraftID` char(10) DEFAULT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `departure_airport` char(3) NOT NULL,
  `arrival_airport` char(3) NOT NULL,
  `num_seats` int DEFAULT 100,
  `domestic_or_international` enum('Domestic','International') NOT NULL,
  PRIMARY KEY (`flight_num`,`airlineID`),
  KEY `airlineID` (`airlineID`),
  KEY `departure_airport` (`departure_airport`),
  KEY `arrival_airport` (`arrival_airport`),
  KEY `aircraftID` (`aircraftID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `airline_company` (`airlineID`),
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`departure_airport`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`arrival_airport`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`aircraftID`) REFERENCES `aircraft` (`aircraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (123, 'AA', NULL, '2023-12-17 15:30:00', '2023-12-17 17:30:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (124, 'BB', NULL, '2023-12-17 16:30:00', '2023-12-17 18:30:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (125, 'CC', NULL, '2023-12-20 16:30:00', '2023-12-20 18:30:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (126, 'DD', NULL, '2023-12-14 16:30:00', '2023-12-14 18:30:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (127, 'EE', NULL, '2023-12-18 16:30:00', '2023-12-18 18:30:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (128, 'EE', NULL, '2023-12-17 14:30:00', '2023-12-17 16:00:00', 'IAD', 'EWR', 100, 'Domestic');
INSERT INTO `flight` VALUES (129, 'DD', NULL, '2023-12-22 14:30:00', '2023-12-22 16:00:00', 'EWR', 'IAD', 100, 'Domestic');
INSERT INTO `flight` VALUES (130, 'CC', NULL, '2023-12-22 12:30:00', '2023-12-17 14:30:00', 'EWR', 'IAD', 100, 'Domestic');
INSERT INTO `flight` VALUES (131, 'BB', NULL, '2023-12-25 16:30:00', '2023-12-25 19:00:00', 'EWR', 'IAD', 100, 'Domestic');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `passengerID` char(10) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`passengerID`),
  KEY `username` (`username`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `username` varchar(30) NOT NULL,
  `flight_history` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_num` int NOT NULL,
  `booking_fee` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `class` enum('Economy','Business','First') NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_time` time DEFAULT NULL,
  `passengerID` char(10) DEFAULT NULL,
  PRIMARY KEY (`ticket_num`),
  KEY `passengerID` (`passengerID`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`passengerID`) REFERENCES `passenger` (`passengerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (987, 10.00, 100.00, 'Economy', NULL, NULL, NULL), (986, 10.00, 100.00, 'Economy', NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (985, 10.00, 100.00, 'Economy', NULL, NULL, NULL), (984, 10.00, 100.00, 'Economy', NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (983, 10.00, 100.00, 'Economy', NULL, NULL, NULL), (982, 10.00, 90.00, 'Economy', NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (981, 10.00, 100.00, 'Economy', NULL, NULL, NULL), (980, 10.00, 90.00, 'Economy', NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (979, 10.00, 100.00, 'Economy', NULL, NULL, NULL), (978, 10.00, 90.00, 'Economy', NULL, NULL, NULL);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_flight`
--

DROP TABLE IF EXISTS `ticket_flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_flight` (
  `ticket_num` int NOT NULL,
  `flight_num` int NOT NULL,
  PRIMARY KEY (`ticket_num`,`flight_num`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `ticket_flight_ibfk_1` FOREIGN KEY (`ticket_num`) REFERENCES `ticket` (`ticket_num`),
  CONSTRAINT `ticket_flight_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flight` (`flight_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_flight`
--

LOCK TABLES `ticket_flight` WRITE;
/*!40000 ALTER TABLE `ticket_flight` DISABLE KEYS */;
INSERT INTO `ticket_flight` VALUES (987, 123), (986, 124), (985,125), (984,126), (983,127), (982,128);
INSERT INTO `ticket_flight` VALUES (981, 129), (980, 130), (979,131);
/*!40000 ALTER TABLE `ticket_flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `account_type` set('Admin','Customer','Customer Representative') DEFAULT 'Customer',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('tim','password123','Customer'),('user123124','superpassword.12','Customer');
INSERT INTO `user` VALUES ('cust','rep','Customer Representative'),('admin','boy','Admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `questions`;
CREATE TABLE questions (
    question VARCHAR(500) PRIMARY KEY,
    answer VARCHAR(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
LOCK TABLES `questions` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE bookings (
    username VARCHAR(20) NOT NULL,
    flight VARCHAR(5) NOT NULL,
     PRIMARY KEY(username, flight),
     FOREIGN KEY(username) REFERENCES user(username)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
LOCK TABLES `bookings` WRITE;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16 15:39:01
