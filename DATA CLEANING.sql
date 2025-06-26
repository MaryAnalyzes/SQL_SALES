 --RENAMING
EXEC sp_rename 'DPS.[Q3 - Current Yearly Salary (in USD)]', 'Salary','column'
  
  SELECT  [Q3 - Current Yearly Salary (in USD)] FROM ['Data Professional Survey$']

  --USING SUBSTRING AND THE CHARINDEX

  SELECT * FROM DPS

  SELECT right(Salary,3)   
  from DPS


  select Salary,cast(REPLACE(substring(salary,charindex('-', salary)-4,4),'K','') as int) as Lowersalary,
  cast(REPLACE (substring(salary,charindex('-',salary)+1,4),'K','') as int) as Uppersalary from DPS
 

  --ALTER AND UPDATE ON THE TABLE 

  ALTER  table DPS
  ADD Lowersalary int,Uppersalary int, AverageSalary int   

  update DPS
  SET Uppersalary = cast(REPLACE(substring(salary,charindex('-', salary)+1,4),'K','') as int)*1000

  update DPS
  SET Lowersalary=cast(REPLACE(substring(salary,charindex('-', salary)-4,4),'K','') as int)*1000

  --CALCULATE AVERAGE SALARY

  UPDATE DPS
  SET AverageSalary = ((Lowersalary)+(Uppersalary))/2
  

  see

  select Lowersalary, Uppersalary,Averagesalary from DPS

  select format(Averagesalary, 'C','en-US') from DPS

 
  --renaming to industry

  exec sp_rename 'DPS.[Q4 - What Industry do you work in?]','INDUSTRY','COLUMN'

  select INDUSTRY from DPS

  select INDUSTRY,replace(substring(INDUSTRY,charindex(':', INDUSTRY)+1,50), 'Other (Please Specify)','Tech') from DPS

 --alter and update on the table

 alter table DPS
 ADD Industry1 text  

 update DPS
 SET Industry1=replace(substring(INDUSTRY,charindex(':', INDUSTRY)+1,50), 'Other (Please Specify)','Tech') 

 select formatmessage('Tech:%s', INDUSTRY) from DPS 

 --date functions

 select [Date Taken (America/New_York)], datepart(month, [Date Taken (America/New_York)]) as monthnumber, datename(month, [Date Taken (America/New_York)]) as Monthnames from DPS

--DATEDIFF

 select [Date Taken (America/New_York)], datediff(year,[Date Taken (America/New_York)],getdate()) from DPS

 --DATEADD

 select [Date Taken (America/New_York)], dateadd(year,1,[Date Taken (America/New_York)]) as newdate from DPS


