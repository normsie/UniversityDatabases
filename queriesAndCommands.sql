SELECT Student.studentID, Student.name, courseCode, name, credits 
FROM Course, CourseInstance, ExerciseGroup, EnrollGroup, Student 
WHERE Course.courseCode = CourseInstance.courseID 
AND CourseInstance.courseInsID = ExerciseGroup.courseInsID 
AND ExerciseGroup.groupID = EnrollGroup.groupID 
AND EnrollGroup.studentID = Student.studentID 
AND EnrollGroup.studentID = '678173';


SELECT studentID, name  
FROM Student, EnrollGroup, ExerciseGroup, CourseInstance, Course  
WHERE Student.studentID = EnrollGroup.studentID  
AND EnrollGroup.groupID = ExerciseGroup.groupID  
AND ExerciseGroup.courseInsID = CourseInstance.courseInsID  
AND CourseInstance.courseID = Course.courseCode  
AND courseCode = 'CS-1010';


SELECT groupID, studentLimit, COUNT(DISTINCT studentID) 
FROM ExerciseGroup JOIN EnrollGroup ON ExerciseGroup.groupID = EnrollGroup.groupID  
WHERE ExerciseGroup.courseInsID IN (SELECT courseIns  
                                    FROM CourseInstance 
                                    WHERE courseID = 'KA-1406') 
GROUP BY groupID 
HAVING COUNT(DISTINCT studentID) < studentLimit;


SELECT roomID, numberOfSeats, numberOfSeatsInExam 
FROM Room  
WHERE Room.roomID NOT IN (SELECT roomID  
                          FROM Reservation 
                          WHERE startTime >= '08:00' 
                          AND endTime <= '13:00' 
                          AND date = '2019-09-14') 
AND Room.numberOfSeats >= 45;


SELECT buildingID, name, address 
FROM Building, Room, LectureInstance, Reservation 
WHERE Reservation.reserveID = LectureInstance.reserveID 
AND Reservation.roomID = Room.roomID 
AND Room.buildingID = Building.buildingID 
AND LectureInstance.lectureInsID = 'L222A';


SELECT roomID, numberOfSeats, numberOfSeatsInExam 
FROM Room, Equipment 
WHERE Equipment.roomID = Room.roomID 
AND Equipment.name = 'projector';


SELECT studentID, Student.name, dateOfBirth, degreeProgram, year, expirationDate, SUM(Course.credits) 
FROM Course, CourseInstance, ExerciseGroup, EnrollGroup, Student 
WHERE Course.courseCode = CourseInstance.courseID 
AND CourseInstance.courseInsID = ExerciseGroup.courseInsID  
AND ExerciseGroup.groupID = EnrollGroup.groupID 
AND EnrollGroup.studentID = Student.studentID 
GROUP BY Course.courseCode;


SELECT studentID, Student.name, dateOfBirth, degreeProgram, year, expirationDate, SUM(Course.credits) 
FROM Course, CourseInstance, ExerciseGroup, EnrollGroup, Student 
WHERE Course.courseCode = CourseInstance.courseID 
AND CourseInstance.courseInsID = ExerciseGroup.courseInsID  
AND ExerciseGroup.groupID = EnrollGroup.groupID 
AND EnrollGroup.studentID = Student.studentID 
GROUP BY Course.courseCode 
HAVING SUM(Course.credits) > 3;


SELECT Building.buildingID, Building.name, address, COUNT(DISTINCT Room.roomID)  
FROM Building, Room  
WHERE Building.buildingID = Room.buildingID 
GROUP BY Building.buildingID;


SELECT Building.buildingID, Building.name, address, COUNT(DISTINCT Room.roomID)  
FROM Building, Room  
WHERE Building.buildingID = Room.buildingID 
GROUP BY Building.buildingID 
HAVING COUNT(DISTINCT Room.roomID) > 1;


SELECT studentID, name  
FROM Student  
WHERE studentID IN (SELECT Student.studentID  
FROM Student, CourseInstance, ExerciseGroup, EnrollGroup  
WHERE CourseInstance.courseInsID = ExerciseGroup.courseInsID  
AND ExerciseGroup.groupID = EnrollGroup.groupID  
AND EnrollGroup.studentID = Student.studentID  
AND CourseInstance.courseID = 'DB-1123') 
AND studentID IN (SELECT Student.studentID  
FROM Student, CourseInstance, ExerciseGroup, EnrollGroup  
WHERE CourseInstance.courseInsID = ExerciseGroup.courseInsID  
AND ExerciseGroup.groupID = EnrollGroup.groupID  
AND EnrollGroup.studentID = Student.studentID  
AND CourseInstance.courseID = 'CS-1010');


SELECT Exam.examID, Exam.startTime, Exam.endTime, Exam,date 
FROM Exam, Room, ExamReserve, Reservation 
WHERE Room.roomID = Reservation.roomID 
AND Reservation.reserveID = ExamReserve.reserveID 
AND ExamReserve.examID = Exam.examID 
AND Room.roomID = 'R3334';

 
SELECT degreeProgram, COUNT(DISTINCT studentID) 
FROM Student 
GROUP BY degreeProgram;


SELECT Exam.examID, Course.courseCode, Course.name, COUNT(DISTINCT Student.studentID) 
FROM Exam, Course, Student,EnrollExam 
WHERE Course.courseCode = Exam.courseID 
AND Exam.examID = EnrollExam.examID 
AND EnrollExam.studentID = Student.studentID 
GROUP BY Exam.examID;


INSERT INTO EnrollExam(studentID,examID) 
VALUES('678173', 'A1022');

SELECT studentID, name 
FROM Student, EnrollExam 
WHERE Student.studentID = EnrollExam.studentID 
AND EnrollExam.examID = 'A1022';


UPDATE Student 
SET degreeProgram = 'master' 
WHERE studentID = '678173';

SELECT * 
FROM Student 
WHERE studentID = '678173';


UPDATE EnrollGroup 
SET groupID = 'G1234' 
WHERE studentID = '783903' 
AND groupID = 'G1111'; 

SELECT Student.studentID, name  
FROM Student, EnrollGroup  
WHERE Student.studentID = EnrollGroup.studentID 
AND groupID = 'G1234'; 


DELETE FROM Equipment 
WHERE equipmentID = 'E0003' 
AND roomID = 'R1314';

SELECT equipmentID, name 
FROM Equipment 
WHERE roomID = 'R1314';