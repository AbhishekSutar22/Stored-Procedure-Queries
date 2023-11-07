 use abhishek
 go

 --stored procedures

 --simple sp
 create procedure uspGetAllStudents
 as
 begin
	select * from student
end

--call sp
exec uspGetAllStudents

--using select statement we cannot execute stored procedure
--select RollNumber,uspGetAllStudents from students

alter procedure uspGetAllStudents
 as
 begin
	select * from student where city = 'Mumbai'
end

exec uspGetAllStudents

--stored procedure with parameter

create procedure uspGetAllStudentsongender
@gender varchar(50)
 as
 begin
	select * from student where gender = @gender
end

exec uspGetAllStudentsongender--Procedure or function 'uspGetAllStudentsoncity' expects parameter '@city', which was not supplied.
exec uspGetAllStudentsongender 'Male'
exec uspGetAllStudentsongender 'Female'
exec uspGetAllStudentsongender 'all'--select *from student where gender = 'all'
									--no student having gender as all

alter procedure uspGetAllStudentsongender
@gender varchar(50)
 as
 begin
     if @gender ='male' or @gender ='female'
begin
	select * from student where gender = @gender
end
else
begin
select * from student
end
end

exec uspGetAllStudentsongender 'Male'
exec uspGetAllStudentsongender 'Female'
exec uspGetAllStudentsongender 'all'

--we can write multiple parameters with sp
create procedure uspGetAllStudentsongendercity
@gender varchar(50),@city varchar(50)
 as
 begin
      select * from student where gender = @gender or city = @city
end

exec uspGetAllStudentsongendercity 'male','mumbai'

alter procedure uspGetAllStudentsongendercity
@gender varchar(50),@city varchar(50)
 as
 begin
      select * from student where gender = @gender and city = @city
end

exec uspGetAllStudentsongendercity 'male','mumbai' -- 2 records
exec uspGetAllStudentsongendercity 'female','mumbai' -- 1 record

go 

--return rollnumber by name
create proc uspGetStudentRollNumberByName
@name varchar(50)
as
begin
select RollNumber from student where name = @name
end

exec uspGetStudentRollNumberByName 'sachin'
exec uspGetStudentRollNumberByName 'nitin'
go

--return statement
alter proc uspGetStudentRollNumberByName
@name varchar(50)
as
begin
declare @RollNumber int
select @RollNumber = RollNumber from student where name = @name
return @RollNumber
end
go
declare @Rn int
exec @Rn = uspGetStudentRollNumberByName 'smriti'
print @Rn

--by default every procedure returns a int which denotes status of execution
declare @r1 int
exec @r1 = uspGetAllStudentsOnGenderCity @City = 'Mumbai',@Gender = 'Male'
print @r1

go
create proc uspGetStudentNameByRollNumber1
@RollNumber int
as
begin
declare @Name varchar(50)
select @Name = Name from student where RollNumber = @RollNumber
return @Name
end
go
declare @r2 varchar(50)
exec @r2 = uspGetStudentNameByRollNumber1 1 -- Not Work
print @r2

alter proc uspGetStudentNameByRollNumber1
@RollNumber int,@Name varchar(50) out
as
begin
select @Name=Name from student where RollNumber = @RollNumber
end

exec uspGetStudentNameByRollNumber1--Procedure or function 'uspGetStudentNameByRollNumber1' expects parameter '@RollNumber', which was not supplied.

declare @r4 varchar(50)
exec uspGetStudentNameByRollNumber1 @RollNumber = 6,@Name = @r4 out
print @r4

alter proc uspGetStudentNameByRollNumber1
@RollNumber int,@Name varchar(50) out,@city varchar(50) out
as
begin
select @Name=Name,@city = city from student where RollNumber = @RollNumber
end

declare @r4 varchar(50),@r5 varchar(50)
exec uspGetStudentNameByRollNumber1 @RollNumber = 6,@Name = @r4 out, @city = @r5 out
print @r4
print @r5

go

alter procedure uspGetAllStudentsongenderage 
@gender varchar(50),@age int
 as
 begin
      select * from student where gender = @gender or age >= @age
end

exec uspGetAllStudentsongenderage 'male',25
exec uspGetAllStudentsongenderage
exec uspGetAllStudentsongenderage
exec uspGetAllStudentsongenderage































