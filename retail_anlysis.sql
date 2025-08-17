# Seasonal Trends: 
# Does the business have high and low seasons? 
# Which months show the highest and lowest sales revenue?

select 
extract(month from date) as `months`,
sum(`Total Amount`) as `Revenue per Month`
from retail.retail_sales_dataset
group by `months`
order by `Revenue per Month` desc;

# Weekly Sales Patterns: 
# What is the sales trend across a typical week? 
# Which day of the week is the busiest in terms of sales revenue and number of transactions?

select dayname(`date`) as Day_Name, sum(`Total Amount`) as Revenue
from retail.retail_sales_dataset
group by (Day_Name)
order by Revenue;

# Sales Performance Analysis and Demographic Preferences:
# Which products are the top sellers by quantity sold?
# Which product categories are most popular among male versus female customers:

with male_sales as
(select `Product Category`,
sum(`Quantity`) as`Male Quantity`, 
sum(`Total Amount`) as `Male Revenue`
from retail.retail_sales_dataset
where `Gender` = 'Male'
group by `Product Category`),
total_sales as
(select `Product Category`,
sum(`Quantity`) as`Total Quantity`, 
sum(`Total Amount`) as `Total Revenue`
from retail.retail_sales_dataset
group by `Product Category`)
select ts.`Product Category`, 
ms.`Male Quantity` as `Male Quantity`,
(ts.`Total Quantity` - ms.`Male Quantity`) as `Female Quantity`,
ts.`Total Quantity`,
ms.`Male Revenue` as `Male Revenue`,
(ts.`Total Revenue` - ms.`Male Revenue`) as `Female Revenue`,
ts.`Total Revenue`
from total_sales as ts
join male_sales as ms
on ts.`Product Category` = ms.`Product Category`;

# Customer Age Distribution: 
# What is the age distribution of our customers? 
# Which age groups are the largest and which have the highest spending?

select sum(`Total Amount`) as `Total Revenue`,
count(distinct `Customer ID`) as `Number of Customer`,
case
when age <=29 and age >= 18 then '18-29'
when age <=39 and age >= 30 then '30-39'
when age <=49 and age >= 40 then '40-49'
when age <=59 and age >= 50 then '50-59'
when age >= 60 then '60 or above'
end as `Age Group`
from retail.retail_sales_dataset
group by `Age Group`
order by `Age Group`;



