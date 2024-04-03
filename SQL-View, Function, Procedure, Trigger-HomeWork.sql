create database CourseDatabase
--use courseDatabase

create table Students(
  [Id] int primary key identity(1,1),
  [Name] nvarchar(50),
  [Surname] nvarchar (50),
  [Age] int check (Age >= 18),
  [Email] nvarchar(100) unique,
  [Address] nvarchar (50)
)

select * from Students

create procedure usp_createStudent
@name nvarchar(50),
@surname nvarchar(50),
@age int,
@email nvarchar(100),
@address nvarchar (50)

as
begin
  insert into Students([Name],[Surname],[Age],[Email],[Address])
  values (@name,@surname,@age,@email,@address)
end
exec usp_createStudent 'Nazim','Hesenli',26,'nazim@gmail.com','Bineqedi'


create procedure usp_deleteStudentById
@id int
as
begin
    delete from Students where [Id] = @id
end


create table StudentLogs(
[Id]int primary key identity(1,1),
[StudentId] int,
[Operation] nvarchar(20),
[Date] datetime
)

select * from StudentLogs

create trigger trg_deleteStudentLogs on Students
after delete
as
begin
   insert into StudentLogs([StudentId],[Operation],[Date])
   select [Id],'Delete',GETDATE() from deleted
end

exec usp_deleteStudentById 4


select * from StudentLogs
select * from Students
