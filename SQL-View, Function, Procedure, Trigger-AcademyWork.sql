
select * from Teachers

create  view  getTeacherWithId
as
select * from Teachers where [Id] > 3

select * from getTeacherWithId



create  view  getTeacherWithAge
as
select Top 3 * from Teachers where [Age] > 26


 create function sayHelloWorld()
 returns nvarchar(50)
 as
 begin
   return 'Hello World'
 end

 declare @data nvarchar (30) = (select dbo.sayHelloWorld())

 print @data



  create function dbo.showText(@text nvarchar(50))
 returns nvarchar(50)
 as
 begin
   return @text
 end

 select dbo.showText('Elasiz Resad bey')



 create function dbo.SumofNums(@num1 int,@num2 int)
 returns int
 as
 begin
     return @num1+ @num2
end

declare @id int =(select dbo.SumofNums(1,2))
select * from Teachers where [Id] = @id


create function dbo.getTeachersByAge(@age int)
returns int
as
begin
  declare @count int;
  select @count = COUNT (*) from Teachers where [Age] > @age
  return @count;
end


select * from Teachers

select dbo.getTeachersByAge(20) as 'Teachers count'


create function dbo.getAllTeachers()
returns table
as
return (select * from Teachers) 

select * from dbo.getAllTeachers()


create function dbo.serachTeachersbyName(@serchText nvarchar(50))
returns table
as
return(
   select * from Teachers where [Name] like '%' +@serchText+ '%'
)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

select * from dbo.serachTeachersbyName('d')

select * from Teachers


create procedure usp_ShowText
as
begin
  print'Salamlar'
end

create procedure usp_ShowText2
@Text nvarchar(50)
as
begin
  print @Text
end

exec usp_ShowText2'Salam Fatime xanim'


create procedure usp_createTeacher
@name nvarchar(100),
@surname nvarchar(100),
@email nvarchar(200),
@age int
as
begin
  insert into Teachers([Name],[Surname],[Email],[Age])
  values (@name,@surname,@email,@age)
end
exec usp_createTeacher 'Nurlan','Umudov','nurlan@gmail.com',27



create procedure usp_deleteTeacherById
@id int
as
begin
    delete from Teachers where [Id] = @id
end

exec usp_deleteTeacherById 3

select * from Teachers



create function dbo.getTeacherAvgAges(@id int)
returns int
as
begin
   declare @avgAge int;
   select @avgAge = AVG(Age) from Teachers where [Id]>@id
   return @avgAge 
end

select dbo.getTeacherAvgAges(3)



create procedure usp_changeTeacherNameByCondition
@id int,
@name nvarchar(50)
as
begin
     declare @avgAge int = (select dbo.getTeacherAvgAges(@id))
	 update Teachers
	 set[Name] = @name
	 where [Age]>@avgAge
end

exec usp_changeTeacherNameByCondition 3,'XXX'

select * from Teachers order  by [Age] asc

select GETDATE()


create table TeacherLogs(
[Id]int primary key identity(1,1),
[TeacherId] int,
[Operation] nvarchar(20),
[Date] datetime
)

create trigger trg_createTeacherLogs on Teachers
after insert
as
begin
   insert into TeacherLogs([TeacherId],[Operation],[Date])
   select [Id],'Insert',GETDATE() from inserted
end

exec usp_createTeacher'Afide','Veliyeva','afide@gmail.com',39

select * from TeacherLogs


create trigger trg_deleteTeacherLogs on Teachers
after delete
as
begin
   insert into TeacherLogs([TeacherId],[Operation],[Date])
   select [Id],'Delete',GETDATE() from deleted
end

exec usp_deleteTeacherById 2

select * from Teachers


 
