-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 13, 2024 at 02:59 PM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+05:30";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `em_admins`
--

CREATE TABLE `em_admins` (
  `AID` int(10) NOT NULL,
  `EMail` varchar(50) NOT NULL,
  `Password` varchar(70) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Department` varchar(50) NOT NULL,
  `isFaculty` tinyint(1) NOT NULL,
  `isCoordinator` tinyint(1) NOT NULL,
  `isCampaigner` tinyint(1) NOT NULL,
  `RegisterTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `em_admins`
--

INSERT INTO `em_admins` (`AID`, `EMail`, `Password`, `Name`, `Department`, `isFaculty`, `isCoordinator`, `isCampaigner`, `RegisterTime`) VALUES
(1, 'Dhruv@gmail.com', '123456', 'Dhruv Shah', 'Computer', 0, 1, 0, '2024-05-13 07:12:20'),
(2, 'Ravi@gmail.com', '123456', 'Ravi Patel', 'Computer', 0, 0, 1, '2024-05-13 08:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `em_events`
--

CREATE TABLE `em_events` (
  `EVID` int(10) NOT NULL,
  `EVCode` varchar(30) NOT NULL,
  `EVName` varchar(30) NOT NULL,
  `EVDepartment` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `em_events`
--

INSERT INTO `em_events` (`EVID`, `EVCode`, `EVName`, `EVDepartment`) VALUES
(1, 'COMP-PITCH', 'Pitchers', 'Computer'),
(2, 'COMP-PLAC', 'Placement Drive', 'Computer'),
(3, 'CIVIL-AH2O', 'Absolute H2O', 'Civil'),
(4, 'CIVIL-EPLA', 'E-Placement', 'Civil'),
(5, 'CIVIL-CHKR', 'Chakravyuh', 'Civil'),
(6, 'ELEC-QUIZ', 'E-Quiz', 'Electrical'),
(7, 'ELEC-AQUA', 'Aqua Robo', 'Electrical'),
(8, 'ELEC-BUZZ', 'Buzz Wire', 'Electrical'),
(9, 'MECH-JUNKY', 'Junk Yard', 'Mechanical'),
(10, 'MECH-LATH', 'Lathe War', 'Mechanical'),
(11, 'CHEM-OQUIZ', 'Chem-O-Quiz', 'Chemical'),
(12, 'CHEM-OLIVE', 'Chem-O-Live', 'Chemical');

-- --------------------------------------------------------

--
-- Table structure for table `em_event_reg`
--

CREATE TABLE `em_event_reg` (
  `ERID` int(10) NOT NULL,
  `PID` int(10) NOT NULL,
  `EVID` int(10) NOT NULL,
  `ERCode` varchar(30) NOT NULL,
  `FCode` varchar(11) NOT NULL,
  `RegAdmin` int(10) DEFAULT NULL,
  `isPaid` tinyint(1) NOT NULL,
  `isAttended` tinyint(1) NOT NULL,
  `AttendAdmin` int(10) DEFAULT NULL,
  `AttendTime` timestamp NULL DEFAULT NULL,
  `EventRegTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `em_participants`
--

CREATE TABLE `em_participants` (
  `PID` int(10) NOT NULL,
  `EMail` varchar(50) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `College` varchar(70) NOT NULL,
  `Department` varchar(30) NOT NULL,
  `Semester` int(1) NOT NULL,
  `Mobile` varchar(14) NOT NULL,
  `Gender` varchar(6) NOT NULL,
  `RegisterTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `em_admins`
--
ALTER TABLE `em_admins`
  ADD PRIMARY KEY (`AID`);

--
-- Indexes for table `em_events`
--
ALTER TABLE `em_events`
  ADD PRIMARY KEY (`EVID`);

--
-- Indexes for table `em_event_reg`
--
ALTER TABLE `em_event_reg`
  ADD PRIMARY KEY (`ERID`);

--
-- Indexes for table `em_participants`
--
ALTER TABLE `em_participants`
  ADD PRIMARY KEY (`PID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `em_admins`
--
ALTER TABLE `em_admins`
  MODIFY `AID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `em_events`
--
ALTER TABLE `em_events`
  MODIFY `EVID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `em_event_reg`
--
ALTER TABLE `em_event_reg`
  MODIFY `ERID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `em_participants`
--
ALTER TABLE `em_participants`
  MODIFY `PID` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
