SELECT * FROM walmart.sales;

-- time_of_day---------
select time,
(case
	when 'time' between "00:00:00" and "12:00:00" then "morning"
	when 'time' between "12:01:00" and "16:00:00" then "afternoon"
	else "evening"
end
) as time_of_day
from sales;

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day = (
case
	when 'time' between "00:00:00" and "12:00:00" then "morning"
	when 'time' between "12:01:00" and "16:00:00" then "afternoon"
	else "evening"
end	
);

-- day_name---------------------

select date,
dayname(date) as day_name
from sales;

alter table sales add column day_name varchar(10);

update sales set day_name = dayname(date);


-- month_name

select date, monthname(date)
from sales;

alter table sales add column month_name varchar(10);

update sales
set month_name=monthname(date);
-- ----------------------------------------------------------------------------------------------------


-- EDA questions-------------------------------------------------------------------------------

-- How many unique cities does the data have?

	select distinct city from sales;


-- In which city is each branch?
    
    select distinct city, branch
    from sales;


-- How many unique product lines does the data have?

	SELECT count(DISTINCT `Product line`)
	FROM sales;	


-- What is the most common payment method?

	select payment, count(payment) as cnt
	from sales 
	group by payment
	order by cnt desc;
    

-- What is the most selling product line?

	select `product line`, count(`product line`) as cnt
    from sales
    group by `product line`
    order by cnt desc;


-- What is the total revenue by month?

	select month_name as month,
    sum(total) as total_revenue
    from sales
    group by month_name
    order by total_revenue desc;
		

-- What month had the largest COGS?

	select month_name as month, 
    sum(cogs) as cogs
    from sales
    group by month_name
    order by cogs desc;
    
    
-- What product line had the largest revenue?

	select `product line`,
    sum(total) as total_revenue
    from sales
    group by `product line`
    order by total_revenue desc;
	
    
-- What is the city with the largest revenue?

	select city,branch,
    sum(total) as total_revenue
    from sales
    group by city,branch
    order by total_revenue desc;


-- What product line had the largest VAT?

	select `product line`,
    avg(`tax 5%`) as avg_tax
    from sales
    group by `product line`
    order by avg_tax desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

	

-- Which branch sold more products than average product sold?

	select branch,
    sum(quantity) as qty
    from sales
    group by branch
    having sum(quantity) > (select avg(quantity) from sales);


-- What is the most common product line by gender?

	select gender, `product line`, 
    count(gender) as total_cnt
    from sales
    group by gender, `product line`
    order by total_cnt desc;
    
    
-- What is the average rating of each product line?

	select 
    round(avg(rating),2)as avg_rating, `product line`
    from sales
    group by `product line`
    order by avg_rating desc;


-- Number of sales made in each time of the day per weekday

	select time_of_day, 
    count(*) as total_sales
    from sales
    where day_name='monday'
    group by time_of_day
    order by total_sales desc;
    

-- Which of the customer types brings the most revenue?

	select `customer type`,
    sum(total) as total_rev
    from sales
    group by `customer type`
    order by total_rev desc;
    

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

	select City,
    avg(`tax 5%`) as `tax 5%`
    from sales
    group by city
    order by `tax 5%` desc;

-- Which customer type pays the most in VAT?

	select `customer type`,
    avg(`tax 5%`) as `tax 5%`
    from sales
    group by `customer type`
    order by `tax 5%` desc;

-- How many unique customer types does the data have?

	select distinct `customer type`
    from sales;

-- How many unique payment methods does the data have?

	select distinct payment
    from sales;

-- What is the most common customer type?

	select `customer type`,
    sum(total) as total_amount
    from sales 
    group by `customer type`
    order by total_amount desc;

-- Which customer type buys the most?

	select `customer type`,
    count(*) as cstm_cnt
    from sales
    group by `customer type`;


-- What is the gender of most of the customers?

	select gender,
    count(*) as gender_cnt
    from sales
    group by gender
    order by gender_cnt;

-- What is the gender distribution per branch?

	select gender,
    count(*) as gender_cnt
    from sales
    where branch="A"
    group by gender
    order by gender_cnt desc;


-- Which time of the day do customers give most ratings?

	select time_of_day,
    avg(rating) as avg_rating
    from sales
    group by time_of_day
    order by avg_rating desc;


-- Which time of the day do customers give most ratings per branch?

	select time_of_day,
    avg(rating) as avg_rating
    from sales
    where branch="A"
    group by time_of_day
    order by avg_rating desc;


-- Which day fo the week has the best avg ratings?

	select day_name,
    avg(rating) as avg_rating
    from sales
    group by day_name
    order by avg_rating desc;

-- Which day of the week has the best average ratings per branch?

	select day_name,
    avg(rating) as avg_rating
    from sales
    where branch="A"
    group by day_name
    order by avg_rating desc;
    
    


