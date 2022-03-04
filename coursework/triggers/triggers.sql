-- 1 - к-сть курсів у викладача
create or replace function can_take_courses(_id bigint)
	returns bigint
	as
$$
	select lf.can_take from (select staff_id,((select total_courses from staff where staff.id=tc.staff_id)-sum(1)) as can_take 
			from tutor_course as tc group by tc.staff_id
			) as lf where lf.staff_id=_id;
$$
language sql immutable strict;

create or replace function available_to_take_course()
	returns trigger 
	language plpgsql 
	as
$$
begin 
	if can_take_courses(staff_id) > 0 then
		INSERT INTO tutor_course(staff_id,course_id) VALUES (new.staff_id,new.course_id);
	end if;
	return new;
end;
$$;

create trigger check_if_can_take
before insert on tutor_course 
execute procedure available_to_take_course();

-- 2 - підвищення зарплати всім робітникам, або макс допустима
create or replace function choose_min(a double precision, b double precision)
returns double precision as
$$
	select case when a + 0.05*b < 500 
				then a + 0.05*b
				else 500
				end
$$
LANGUAGE SQL IMMUTABLE STRICT;

create or replace function increase_salary()
	returns trigger 
	language plpgsql 
	as
$$
begin
	if new.salary != old.salary then
		update staff set salary=(select choose_min(old.salary, new.salary));
	end if;
	
	return new;
end;
$$

create trigger staff_salary_changes
before update on staff for each row 
execute procedure increase_salary();
-- 3 - збільшення на рік вік студентів, якщо рік змінився
create or replace function change_age()
	returns trigger 
	language plpgsql 
	as
$$
begin 
	if extract('year' from (now() - interval '1 day')) <> extract('year' from now()) then
		update student set age=old.age+1;
	end if;
	
	return new;
end;
$$

create trigger change_students_age 
after update on student
execute procedure change_age();
-- 4 - не можна додати транспорт, якщо більше 5 незадіяних
create or replace function count_vehicles_on_finals(_id bigint)
	returns boolean
	as
$$
	select case when (select count(1) from finals where id=_id) > 0
		then true
		else false
	end
$$
language sql immutable strict;

create or replace function need_vehicle()
	returns trigger 
	language plpgsql 
	as
$$
begin 
	if (select count(1) from vehicle_type) - (select count(1) from vehicle_type having (select count_vehicles_on_finals(1))='true') < 5 then
		insert into vehicle_type(id, vehicle_type_decs) values (new.id, new.vehicle_type_decs);
	end if;
	return new;
end;
$$

create trigger add_new_vehicle_if_needed
before insert on vehicle_type 
execute procedure need_vehicle();
-- 5 - не додавати персонал (тотал курси = 0) тільки 2 дозволено
create or replace function count_not_tutor()
	returns bigint
	as
$$
	select count(1) from staff where total_courses=0;
$$
language sql immutable strict;

create or replace function need_not_tutor_staff()
	returns trigger 
	language plpgsql 
	as
$$
begin 
	if (select count_not_tutor()) < 2 then
		insert into staff(id,first_name,second_name,salary,total_courses,job_title_id) 
		values (new.id,new.first_name,new.second_name,new.salary,new.total_courses,new.job_title_id);
	end if;
	return new;
end;
$$;

create trigger add_new_staff_if_needed
before insert on staff 
execute procedure need_not_tutor_staff();