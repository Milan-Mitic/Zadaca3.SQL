use SEDCHome

-- Calculate the count of all grades per Teacher in the system
select 
TeacherID,
count(Grade) as AllGrades
from Grade
group by TeacherID

-- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
select
TeacherID, 
count(Grade) as AllGrades
from Grade
where StudentID < 100
group by TeacherID

-- Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select 
StudentID,
max(Grade) as MaxGrade,
avg(Grade) as AvgGrade
from Grade
group by StudentID

-- Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
select 
TeacherID,
count(Grade) as AllGrades
from Grade
group by TeacherID
having count(Grade) > 200

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade. (Calculate statistics for all students, but display only those with above-average results.)
select 
StudentID,
count(Grade) as GradeCount,
max(Grade) as MaxGrade,
avg(Grade) as AvgGrade
from Grade
group by StudentID
having max(Grade) = avg(Grade)

-- List Student First Name and Last Name next to the other details from previous query
select 
StudentID, Student.FirstName, Student.LastName,
count(Grade) as GradeCount,
max(Grade) as MaxGrade,
avg(Grade) as AvgGrade
from Grade
left join Student on StudentID = Student.ID
group by StudentID, Student.FirstName, Student.LastName
having max(Grade) = avg(Grade)

-- Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
go
drop view vw_StudentGrades
go
create view vw_StudentGrades
as 
select 
StudentID,
count(Grade) as AllGrades
from Grade
group by StudentID
go
select * from vw_StudentGrades


-- Change the view to show Student First and Last Names instead of StudentID
go
drop view vw_StudentGrades
go
create view vw_StudentGrades
as
select
Student.FirstName, Student.LastName, 
count(Grade) as AllGrades
from Student
left join Grade on StudentID = Student.ID
group by Student.FirstName, Student.LastName
go
select * from vw_StudentGrades

-- List all rows from view ordered by biggest Grade Count
select 
FirstName, 
LastName,
AllGrades
from vw_StudentGrades
order by AllGrades desc

