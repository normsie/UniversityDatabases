CREATE TABLE Course ( 
courseCode TEXT, 
name TEXT, 
credits INTEGER, 
PRIMARY KEY (courseCode) 
); 
 
INSERT INTO Course VALUES ('DB-1123', 'Databases', 5);  
INSERT INTO Course VALUES ('KA-1406', 'Programming I', 5);  
INSERT INTO Course VALUES ('LN-1308', 'Calculus', 5);  
INSERT INTO Course VALUES ('LC-1111', 'Finnish 1A', 2);  
INSERT INTO Course VALUES ('CS-1010', 'Machine Learning', 3); 

CREATE TABLE CourseInstance ( 
courseInsID TEXT, 
courseID TEXT, 
startDate TEXT, 
endDate TEXT, 
PRIMARY KEY (courseInsID), 
FOREIGN KEY (courseID) REFERENCES Course(courseCode) 
ON UPATE CASCADE  
ON DELETE CASCADE, 
CHECK (endDate > startDate)  
); 

INSERT INTO CourseInstance VALUES ('DB1', 'DB-1123', '2019-08-13', '2020-01-11');  
INSERT INTO CourseInstance VALUES ('CS3', 'CS-1010', '2020-04-05', '2020-07-13');  
INSERT INTO CourseInstance VALUES ('CS1', 'CS-1010', '2019-08-15', '2019-10-17');  
INSERT INTO CourseInstance VALUES ('LC6', 'LC-1111', '2020-04-20', '2020-07-03');  
INSERT INTO CourseInstance VALUES ('KA2', 'KA-1406', '2020-01-13', '2020-04-22'); 

CREATE TABLE Exam (  
examID TEXT, 
courseID TEXT,  
startTime TEXT, 
endTime TEXT, 
date TEXT, 
PRIMARY KEY (examID),  
FOREIGN KEY (courseID) REFERENCES Course(courseCode) 
ON UPDATE CASCADE 
ON DELETE CASCADE, 
CHECK (endTime > startTime) 
); 

INSERT INTO Exam VALUES ('A1022', 'DB-1123', '12:00', '15:00', '2020-03-03');  
INSERT INTO Exam VALUES ('C2010', 'CS-1010', '08:00', '11:30', '2020-02-06');  
INSERT INTO Exam VALUES ('L2011', 'LC-1111', '14:15', '17:20', '2020-05-07');  
INSERT INTO Exam VALUES ('L2222', 'LC-1111', '10:00', '13:15', '2019-12-18');  
INSERT INTO Exam VALUES ('S1234', 'KA-1406', '11:45', '14:15', '2020-08-13'); 

CREATE TABLE ExerciseGroup ( 
groupID TEXT, 
courseInsID TEXT, 
studentLimit INTEGER, 
PRIMARY KEY (groupID), 
FOREIGN KEY (courseInsID) REFERENCES CourseInstance(courseInsID)  
ON UPDATE CASCADE 
ON DELETE CASCADE 
); 

INSERT INTO ExerciseGroup VALUES ('G1111', 'DB1', 30);  
INSERT INTO ExerciseGroup VALUES ('G1231', 'CS1', 50);  
INSERT INTO ExerciseGroup VALUES ('G1234', 'LC6', 25);  
INSERT INTO ExerciseGroup VALUES ('G1298', 'KA2', 30);  
INSERT INTO ExerciseGroup VALUES ('G1235', 'LC6', 25); 
 
CREATE TABLE GroupInstance ( 
groupInsID TEXT, 
groupID TEXT, 
reserveID TEXT, 
startTime TEXT, 
endTime TEXT, 
date TEXT, 
PRIMARY KEY (groupInsID), 
FOREIGN KEY (groupID) REFERENCES ExerciseGroup(groupID)  
ON DELETE CASCADE, 
FOREIGN KEY (reserveID) REFERENCES Reservation(reserveID) 
ON DELETE SET NULL 
ON UPDATE CASCADE, 
CHECK (endTime > startTime) 
); 

INSERT INTO GroupInstance VALUES ('G1111A', 'G1111', 'RS100475', '12:15', '13:45', '2020-06-14');  
INSERT INTO GroupInstance VALUES ('G1234D', 'G1234', 'RS112233', '16:00', '18:00', '2019-09-16');  
INSERT INTO GroupInstance VALUES ('G1234F', 'G1234', 'RS334455', '09:00', '11:00', '2020-06-24');  
INSERT INTO GroupInstance VALUES ('G1298A', 'G1298', 'RS556677', '08:15', '10:15', '2020-06-16');  
INSERT INTO GroupInstance VALUES ('G1234P', 'G1234', 'RS778899', '17:15', '19:30', '2020-04-06'); 

CREATE TABLE Lecture ( 
lectureID TEXT, 
courseInsID TEXT, 
PRIMARY KEY (lectureID), 
FOREIGN KEY (courseInsID) REFERENCES CourseInstance(courseInsID) ON DELETE CASCADE 
); 
 
INSERT INTO Lecture VALUES ('L2366', 'CS3');  
INSERT INTO Lecture VALUES ('L3784', 'LC6');  
INSERT INTO Lecture VALUES ('L4836', 'CS3');  
INSERT INTO Lecture VALUES ('L2222', 'CS1');  
INSERT INTO Lecture VALUES ('L7636', 'DB1'); 

CREATE TABLE LectureInstance ( 
lectureInsID TEXT, 
lectureID TEXT, 
reserveID TEXT, 
startTime TEXT, 
endTime TEXT, 
date TEXT, 
PRIMARY KEY (lectureInsID), 
FOREIGN KEY (lectureID) REFERENCES Lecture(lectureID) 
ON DELETE CASCADE, 
FOREIGN KEY (reserveID) REFERENCES Reservation(reserveID) 
ON DELETE SET NULL 
ON UPDATE CASCADE, 
CHECK (endTime > startTime) 
); 
 
INSERT INTO LectureInstance VALUES ('L2222A', 'L2222', 'RS090517', '13:00', '15:00', '2019-09-15');  
INSERT INTO LectureInstance VALUES ('L2366B', 'L2366', 'RS231111', '17:00', '19:00', '2020-06-23');  
INSERT INTO LectureInstance VALUES ('L2366D', 'L2366', 'RS121212', '14:00', '16:00', '2020-06-15');  
INSERT INTO LectureInstance VALUES ('L3784E', 'L3784', 'RS756234', '14:20', '16:20', '2020-04-05');  
INSERT INTO LectureInstance VALUES ('L7636A', 'L7636', 'RS067584', '13:30', '15:30', '2020-05-07'); 

CREATE TABLE Student ( 
studentID TEXT, 
name TEXT, 
dateOfBirth TEXT, 
degreeProgram TEXT CHECK (degreeProgram IN ('Bachelor', 'Master', 'PhD' 
)), 
year INTEGER CHECK (year < 7), 
expirationDate TEXT, 
PRIMARY KEY (studentID) 
); 
 
INSERT INTO Student VALUES ('783903', 'Long', '1999-13-08', 'Bachelor', 2, '2026-08-30'); 
INSERT INTO Student VALUES ('788788', 'Binh', '2001-14-02', 'Bachelor', 2, '2026-08-30');  
INSERT INTO Student VALUES ('678173', 'Matthew', '1988-09-09', 'Bachelor', 4, '2024-08-29');  
INSERT INTO Student VALUES ('283740', 'Kris', '1992-14-06', 'Master' , 1, '2022-04-20');  
INSERT INTO Student VALUES ('230984', 'Vera', '1997-11-01', 'Master' , 3, '2025-01-21'); 

CREATE TABLE Room (  
roomID TEXT, 
buildingID TEXT, 
numberOfSeats INTEGER, 
numberOfSeatsInExam INTEGER, 
PRIMARY KEY (roomID), 
FOREIGN KEY (buildingID) REFERENCES Building(buildingID) 
ON DELETE CASCADE, 
CHECK (numberOfSeatsInExam < numberOfSeats) 
 
); 
 
INSERT INTO Room VALUES ('R0002', 'B03', 50, 30);  
INSERT INTO Room VALUES ('R7832', 'B11', 100, 50);  
INSERT INTO Room VALUES ('R0005', 'B03', 30, 15);  
INSERT INTO Room VALUES ('R1314', 'B01', 200, 150);  
INSERT INTO Room VALUES ('R3334', 'B08', 20, 10); 

CREATE TABLE Building ( 
buildingID TEXT, 
name TEXT, 
address TEXT, 
PRIMARY KEY (buildingID) 
); 
 
INSERT INTO Building VALUES ('B01', 'Otakaari 1', '111 Otaniemi');  
INSERT INTO Building VALUES ('B03', 'CS Building', 'Jamerantaival 1');  
INSERT INTO Building VALUES ('B11', 'Alvari', '84 Otaniemi');  
INSERT INTO Building VALUES ('B08', 'Library', '99 Central City');  
INSERT INTO Building VALUES ('B02', 'Undergraduate Center', '123 Hakaniemi'); 

CREATE TABLE Equipment ( 
equipmentID TEXT, 
roomID TEXT, 
name TEXT, 
PRIMARY KEY (equipmentID), 
FOREIGN KEY (roomID) REFERENCES Room(roomID) 
ON DELETE SET NULL 
ON UPDATE CASCADE, 
); 
 
INSERT INTO Equipment VALUES ('E1234', 'R1314', 'projector');  
INSERT INTO Equipment VALUES ('E0003', 'R1314', 'speaker');  
INSERT INTO Equipment VALUES ('E1308', 'R3334', 'projector');  
INSERT INTO Equipment VALUES ('E0001', 'R0002', 'table');  
INSERT INTO Equipment VALUES ('E8923', 'R0005', 'chair'); 

CREATE TABLE Reservation ( 
reserveID TEXT, 
roomID TEXT, 
startTime TEXT, 
endTime TEXT, 
date TEXT, 
PRIMARY KEY (reserveID), 
FOREIGN KEY (roomID) REFERENCES Room(roomID) 
ON DELETE CASCADE, 
CHECK (endTime > startTime) 
); 
 
INSERT INTO Reservation VALUES ('RS182347', 'R0002', '09:00', '12:00', '2019-09-14');  
INSERT INTO Reservation VALUES ('RS020233', 'R1314', '14:30', '16:00', '2020-06-22');  
INSERT INTO Reservation VALUES ('RS100475', 'R7832', '12:15', '13:45', '2020-06-14');  
INSERT INTO Reservation VALUES ('RS172897', 'R0005', '09:20', '11:15', '2020-04-04');  
INSERT INTO Reservation VALUES ('RS000992', 'R3334', '10:15', '11:30', '2020-05-06'); 
INSERT INTO Reservation VALUES ('RS090517', 'R0002', '13:00', '15:00', '2019-09-15');  
INSERT INTO Reservation VALUES ('RS231111', 'R1314', '17:00', '19:00', '2020-06-23');  
INSERT INTO Reservation VALUES ('RS121212', 'R7832', '14:00', '16:00', '2020-06-15');  
INSERT INTO Reservation VALUES ('RS756234', 'R0005', '14:20', '16:20', '2020-04-05');  
INSERT INTO Reservation VALUES ('RS067584', 'R3334', '13:30', '15:30', '2020-05-07'); 
INSERT INTO Reservation VALUES ('RS112233', 'R0002', '16:00', '18:00', '2019-09-16');  
INSERT INTO Reservation VALUES ('RS334455', 'R1314', '09:00', '11:00', '2020-06-24');  
INSERT INTO Reservation VALUES ('RS556677', 'R7832', '08:15', '10:15', '2020-06-16');  
INSERT INTO Reservation VALUES ('RS778899', 'R0005', '17:15', '19:30', '2020-04-06'); 

 
CREATE TABLE EnrollExam (  
studentID TEXT,  
examID TEXT,  
PRIMARY kEY (studentID, examID) 
);  
 
INSERT INTO EnrollExam VALUES ('783903', 'A1022');  
INSERT INTO EnrollExam VALUES ('678173', 'L2222');  
INSERT INTO EnrollExam VALUES ('788788', 'S1234');  
INSERT INTO EnrollExam VALUES ('230984', 'L2011');  
INSERT INTO EnrollExam VALUES ('283740', 'C2010'); 

CREATE TABLE EnrollGroup (  
studentID TEXT,  
groupID TEXT,  
PRIMARY KEY (studentID, groupID) 
);  
 
INSERT INTO EnrollGroup VALUES ('783903', 'G1111');  
INSERT INTO EnrollGroup VALUES ('788788', 'G1231');  
INSERT INTO EnrollGroup VALUES ('678173', 'G1234');  
INSERT INTO EnrollGroup VALUES ('283740', 'G1298');  
INSERT INTO EnrollGroup VALUES ('230984', 'G1235'); 
INSERT INTO EnrollGroup VALUES ('783903', 'G1231'); 

CREATE TABLE ExamReserve (  
examID TEXT,  
reserveID TEXT,  
PRIMARY KEY (examID, reserveID)  
);  
 
INSERT INTO ExamReserve VALUES ('A1022', 'RS000992');  
INSERT INTO ExamReserve VALUES ('C2010', 'RS000992');  
INSERT INTO ExamReserve VALUES ('L2222', 'RS172897');  
INSERT INTO ExamReserve VALUES ('L2011', 'RS182347');  
INSERT INTO ExamReserve VALUES ('S1234', 'RS020233'); 
 