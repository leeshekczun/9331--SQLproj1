-- COMP9311 17s1 Project 1
--
-- MyMyUNSW Solution Template


-- Q1: buildings that have more than 30 rooms

create table BuildingRooms as 
select buildings.id, count(*) as roomnumber
from buildings,rooms
where buildings.id = rooms.building
group by buildings.id;

create or replace view Q1(unswid, name)
as
select unswid,name 
from buildings,buildingrooms 
where buildingrooms.id = buildings.id and roomnumber > 30;

--... SQL statements, possibly using other views/functions defined by you ...




-- Q2: get details of the current Deans of Faculty

create or replace view Q2(name, faculty, phone, starting)
as
select people.name, longname, staff.phone, affiliations.starting
from staff_roles, affiliations, orgunits, orgunit_types, staff, people
where staff_roles.name = 'Dean' and staff_roles.id = role and affiliations.orgunit = orgunits.id
and affiliations.staff = staff.id and orgunits.utype = orgunit_types.id and orgunit_types.name = 'Faculty'
and staff.id = people.id and affiliations.ending is null;

--... SQL statements, possibly using other views/functions defined by you ...



-- Q3: get details of the longest-serving and shortest-serving current Deans of Faculty

create table tq2
as
select 'Longest serving' as status, name, faculty, starting
from q2
where starting = (select min(starting) from q2);

insert into tq2
(select 'Shortest serving' as status, name, faculty, starting from q2
where starting = (select max(starting) from q2));

alter table tq2
alter status type text;

create or replace view Q3(status, name, faculty, starting)
as
select * from tq2;
--... SQL statements, possibly using other views/functions defined by you ...



-- Q4 UOC/ETFS ratio

create table tq4 
as 
select id, uoc/eftsload as ratio 
from subjects 
where eftsload is not null and eftsload != 0;

alter table tq4
alter ratio type numeric(4,1);

create or replace view Q4(ratio,nsubjects)
as
select ratio, count(*) as nsubjects
from tq4
group by ratio;

--... SQL statements, possibly using other views/functions defined by you ...