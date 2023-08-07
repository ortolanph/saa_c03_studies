select *
  from people;

select count(*)
  from people;

select distinct gender
  from people;

select distinct country
  from people;

select gender, count(gender)
  from people
 group by gender;

select country, count(country)
  from people
 group by country;

select country, department, city
  from people
 order by country, department, city;

select avg(age) as age_average
  from people;

select first_name, last_name
  from people
 where age between 0 and 10;

select first_name, last_name
  from people
  where age between 11 and 20;

select first_name, last_name
  from people
 where age between 21 and 30;

select first_name, last_name
  from people
 where age between 31 and 40;

select first_name, last_name
  from people
 where age between 41 and 50;

select first_name, last_name
  from people
 where age > 50;

select first_name, last_name, gender, phone, mobile_phone, email
  from people
  where extract(DAY FROM dob) = extract(DAY FROM current_date)
    and extract(MONTH from dob) = extract(MONTH FROM current_date);
