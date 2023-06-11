-- Filter the list down by date, location & type 
SELECT * 
from crime_scene_report
where type = 'murder' and date = 20180115 AND city = 'SQL City';

-- Search for witness 1 who lives at the last house on Northwestern Dr 
select *
FROM person 
WHERE address_street_name LIKE '%NorthWestern%' 
order by address_number DESC;

-- Search for witness 2 who bears Annabel & lives on Franklin Ave from the Crime Scene Report 
select *
from person
WHERE name like '%Annabel%' AND address_street_name like '%Franklin%';

-- Now I compare their statements. For witness 1 :-
SELECT * 
from interview 
where person_id = 14887;

-- For witness 2 :-
SELECT * 
from interview 
where person_id = 16371;

-- Filter the get fit table by membership id and status 
SELECT * 
from get_fit_now_member 
where id like '%48Z%' and membership_status = 'gold';

-- Filter by licence plate 
select * 
from drivers_license
WHERE plate_number like '%H42W%' AND gender = 'male';

-- Filter by license id 
SELECT * 
FROM person
where license_id = '423327';

-- Filter by person id 
select * 
from interview
WHERE person_id = 67318;

-- Filter drivers_license by height, hair color and car model
select * 
from drivers_license
WHERE (height BETWEEN 65 AND 67) AND (hair_color = 'red') AND (car_make = 'Tesla');

-- Filter the facebook by events name & date. Run the result against the drivers license & person tables with id as primary key.
select d.id, d.gender, d.height, d.car_model, d.car_make, p.name
from drivers_license d
JOIN person p 
ON d.id = p.license_id
WHERE (d.height BETWEEN 65 AND 67) AND (d.hair_color = 'red') AND (d.car_make = 'Tesla') 
       AND p.id IN(
                   select f.person_id 
                   from facebook_event_checkin f
                   WHERE f.event_name = 'SQL Symphony Concert' AND date LIKE '%201712%' 
                   GROUP BY person_id
                   HAVING COUNT (*) = 3
                   );
                   
-- Curiosity compels me to look into her income   
SELECT p.id, p.name, p.ssn, i.annual_income
FROM person p 
join income i
on p.ssn = i.ssn
WHERE p.name LIKE '%Miranda%'
