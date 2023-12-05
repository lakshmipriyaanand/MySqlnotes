select * from ratings;

-- Rank()
select rating,rank() over(order by rating desc) from ratings;

-- Dene_Rank():
select rating,dense_rank() over(order by rating desc) from ratings;

-- percent_rank():
select rating,percent_rank() over(order by rating desc) from ratings;

-- First Value:
select rating,first_value(rating) over(order by rating desc) from ratings;

-- Last Value:
select rating,last_value(rating) over(order by rating) from ratings; -- we dont get last value here so we use unbounded preceeding and unbounded following

select rating,last_value(rating) over(order by rating
range between unbounded preceding and unbounded following) from ratings;

-- Lag(): -- brings down the value diagonally opposite 
select *, lag(marks,1) over(order by marks) Lag_Marks from students; -- for all subjects
select *, lag(marks,1) over(partition by subject order by marks) Lag_Marks from students; -- lag only for grouped subject
select *, lag(marks,1) over(order by marks) Lag_Marks,marks - lag(marks,1) over(order by marks) Diff from students; -- Diff between marks - Lag_Marks

-- Lead(): -- brings up the value diagonally opposite 
select *, lead(marks,1) over(order by marks) Lead_Marks from students;
select *, lead(marks,1) over(partition by subject order by marks) Lead_Marks from students; -- lead only for grouped subject
select *, lead(marks,1) over(partition by subject order by marks) Lead_Marks,
marks + lead(marks,1) over(partition by subject order by marks) Sum from students; -- Sum of marks and lead_marks

-- ntile() : Splits into defined number of buckets
select rating,ntile(2) over(order by rating desc) from ratings;

-- cume_dist():
select rating,cume_dist() over(order by rating) from ratings;

-- Avg:
select avg(rating) from ratings; -- aggregate avg
select rating,avg(rating) over() from ratings; -- analytical avg

-- Max:
select rating,max(rating) over() from ratings;

-- Min:
select rating,min(rating) over() from ratings;

-- Sum:
select rating,sum(rating) over() from ratings;

-- Count:
select rating,count(rating) over() from ratings;