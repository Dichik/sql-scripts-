-- 1 - повертає імена всіх викладачів, які викладають хоча б один предмет
select (select first_name from staff where staff.id=staff_id), sum(1) 
from tutor_course group by tutor_course.staff_id having count(1) > 0;

-- 2 - отримуємо список студентів і sum of поточний стан оцінок
select (select first_name from student where id=student_id), sum(mark) 
from mark group by student_id;

-- 3 - отримуємо список активностей на поточний місяць і місяць перед цим
select activity.name, activity.date, (select first_name from staff where id=staff_id) 
from activity where date < (now() + interval '1 month') and date > (now() - interval '1 month');

-- 4 - отримуємо всіх студентів, які є наймолодшими на навчанні
select first_name, second_name, age, m_number, email, name, description from student as st, category as ct 
where ct.name=st.studied_at and st.age=(select min(age) from student)

-- 5 - отримуємо загальну суму всіх зарплат персоналу, які викладають, або нал к-сь їхніх курсів
select sum(salary) from staff where total_courses > 0

-- 6 - отримуємо незадіяні автомобілі в найближчих екзаменах
select distinct vehicle_type_desc from vehicle_type
where id not in (select distinct vehicle_type_id from finals)

-- 7 - отримуємо кількість студентів, які навчаються за певною категорією (on the most popular)
select distinct st.studied_at, sum(1) from student as st, category as c group by st.studied_at, c.name;
select st.studied_at, sum(1) from student as st, category as c group by st.studied_at, c.name having st.studied_at=c.name;

-- 8 - отримуємо викладача, який має найбільшу кількість курсів (для підвищення)
select t.first_name, max(sum)
from (select (select first_name from staff where staff_id=id), sum(1) from tutor_course group by staff_id) as t
group by t.first_name order by max(sum) DESC limit 1;

-- 9 - отримуємо кількість тем по кожному курсу (більше 0)
-- select category_id, sum(1) from category_course group by category_id
select cc.category_id, (select name from topic where id=tc.topic_id) 
from category_course as cc inner join topic_course as tc using(course_id) order by cc.category_id;

-- 10 - отримуємо 5 студентів, які мають найкращу успішність
select (select first_name from student where id=student_id), sum(mark) 
from mark group by student_id order by sum(mark) desc limit 5;

-- 11 - отримуємо кількість вільних місць по кожному курсу
select cr.name, left_places as was,
(left_places - (select sum(1) 
                    from category_course as cc 
                    group by cc.course_id 
                    having cc.course_id=cr.id)
) as left_places from course as cr; 

-- 12 - отримуємо список викладачів і скільки курсів вони можуть провести
select (select first_name from staff where staff.id=tc.staff_id),
((select total_courses from staff where staff.id=tc.staff_id)-sum(1)) as can_take 
from tutor_course as tc group by tc.staff_id;

-- 13 - кількість екзаменів по кожній категорії
select (select name from category where name=category_id), sum(1) from category_course group by category_id;

-- 14 - скільки разів використвовуватимуть транспортний засіб на екзаменах відсортований
select pf.vehicle_type_desc, sum(1) from (select name, (select name from course where course.id=course_id), date, course_id,
(select vehicle_type_desc from vehicle_type where id=finals.vehicle_type_id) from finals) as pf group by pf.vehicle_type_desc 
order by sum(1) desc;

-- 15 - об'єднуємо студента і к-сть викладачів з якими у нього/неї будуть заняття (number of different tutors per student)
select distinct st.first_name, sum(1) from (
	select ( select name from course where course.id=course_id), 
		(select first_name from staff where id=staff_id), category_id from tutor_course 
	inner join category_course using(course_id)
) as tt, student as st group by st.first_name, tt.category_id, st.studied_at having tt.category_id=st.studied_at;

-- 16 - обираємо імена апер / лавер персоналу (студентів), які підпадають під шаблон (error with a \' need change bages)
select distinct upper(st.second_name), st.salary, (select job_title_desc from job_title where id=st.job_title_id) 
from staff as st where st.second_name like '%''%';

-- 17 - обираємо активності, екзамени, які припадають на вихідні
select name, date, score from activity where extract(dow from date) in (6,0);

-- 18 - якщо наприклад поламадася машина, список екзаменів, яким потрібно обрати новий незадіяний транспорт (в найближчі два дні)
select f.name, f.date, vt.vehicle_type_desc from vehicle_type as vt, finals as f 
where f.vehicle_type_id=1 and vt.id=f.vehicle_type_id;

-- 19 - якщо викладач захворів, то знайти список, тих викладачів, які його можуть замінити - Arlan - sick and need to find another teacher
select (select first_name from staff where staff.id=staff_id), tc.course_id from staff as st, tutor_course as tc 
group by tc.staff_id, course_id having tc.course_id=(select id from course 
where name='sagittis sapien cum sociis natoque') and tc.staff_id!=(select id from staff where first_name='Arlan')

-- 20 - список тем, які не є в курсах (тобто можуть бути винесені для самостійного опрацювання)
select name from topic where id not in (select topic_id from topic_course);