--7) 

alter function ProperCase(@Text varchar(8000))
returns varchar(8000)
as
begin
  declare @Reset bit;
  declare @Ret varchar(8000);
  declare @i int;
  declare @c char(1);

  if @Text is null
    return null;

  select @Reset = 1, @i = 1, @Ret = '';

  while (@i <= len(@Text))
    select @c = substring(@Text, @i, 1),
		 @Reset = case when @c like '[a-z]' then 1 else 0 end,
      @Ret = @Ret + case when @Reset = 1 then UPPER(@c)
						 else LOWER(@c) end,
     
      @i = @i + 1
  return @Ret

end
Go

select dbo.ProperCase('aNURAG');

--8)

Create Function dbo.anurag(@emp_id empid)
returns varchar(100)
as
begin
declare @gender varchar(100)
SELECT @gender = (SUBSTRING(@emp_id, LEN(@emp_id) ,1)) 
--GROUP BY (SUBSTRING(emp_id, LEN(emp_id) ,1))
return @gender
end

GO 
select dbo.anurag(emp_id) from employee AS Gender;

--9)

Alter Function dbo.anurag1()
returns @emprtntable table
(
ID empid NOT NULL,
firstName varchar(20) NOT NULL,
Minit char(1) NOT NULL,
LastName varchar(30) NOT NULL,
JobID tinyint NOT NULL,
JobLevel tinyint NOT NULL,
PubID char(4) NOT NULL,
HireDate datetime NOT NULL,
Gender varchar(100) NOT NULL
)
AS
begin
declare @emptemptable table(ID empid, firstNamr varchar(20), Minit char(1), LastName varchar(30), JobID tinyint, JobLevel tinyint, PubID Char(4), HireDate datetime, Gender varchar(100))
insert into @emptemptable
SELECT emp_id, fname, minit, lname, job_id, job_lvl, pub_id, hire_date, (SUBSTRING(emp_id, len(emp_id),1)) from employee;
insert into @emprtntable
select * from @emptemptable
return
end 

select * from dbo.anurag1();

--10)

Create function dbo.calcage(@dob DATE)
returns 
INT
as
begin
DECLARE @age 
as INT
set @age = DATEDIFF(YY,@dob,GETDATE()) -
  CASE
  when DATEADD (YY,DATEDIFF(YY,@dob,GETDATE()),@dob) > GETDATE()
	then 1
  else 0
 end
 return @age
end
GO


SELECT dbo.calcage('1996-12-13') AS Age

--11)

Create procedure insertInJobs
	@jobdes VARCHAR(100),
	@minlvl INT,
	@maxlvl INT
	AS
		if @jobdes IS NULL OR @minlvl IS NULL OR @maxlvl IS NULL
			begin
			RAISERROR('The value shouldn''t not be null', 15, 15)
			end
		else if EXISTS(SELECT * FROM JOBS WHERE JOB_DESC = @jobdes)
			begin
			RAISERROR('The value should be unique!', 15, 15) 
			end
		else 
			begin
			insert into jobs (job_desc, min_lvl, max_lvl)
			values (@jobdes, @minlvl, @maxlvl)
			end
			
	GO
	

exec insertInJobs joker, 34, 234

