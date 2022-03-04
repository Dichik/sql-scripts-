-- 1
create view topics_and_tutors_per_category
as (
	select (select name from course where course.id=course_id), 
		(select first_name from staff where id=staff_id), category_id 
		from tutor_course 
		inner join category_course using(course_id) order by category_id
 );
-- useful for #15
select distinct st.first_name, sum(1) from topics_and_tutors_per_category as tt, student as st 
group by st.first_name, tt.category_id, st.studied_at having tt.category_id=st.studied_at;




-- 2
create view total_courses_in_progress
as (
	select course_id, sum(1) from category_course as cc, course as cr 
	group by cc.course_id, cr.id having cc.course_id=cr.id
);

-- useful for #11
select cr.name, left_places as was,
(left_places - (select sum from total_courses_in_progress where course_id=cr.id)) 
as left_places from course as cr; 




-- 3
create view courses_per_tutor_in_progress
as (
	select (select first_name from staff where staff_id=id), sum(1) from tutor_course group by staff_id
);

-- useful for #8
select t.first_name, max(sum)
from courses_per_tutor_in_progress as t
group by t.first_name order by max(sum) DESC limit 1;




-- 4
create view diff_vehicles
as (
	select distinct vehicle_type_id from finals
);

-- useful for #6
select distinct vehicle_type_desc from vehicle_type
where id not in (select vehicle_type_id from diff_vehicles);
