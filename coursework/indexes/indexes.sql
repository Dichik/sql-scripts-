-- indexes
create index staff_id_index on staff(id);
create index staff_in_tutor_index on tutor_course(staff_id);
-- 234 msec - was 
-- 175 msec - become

create index category_index on category(name);
create index category_course_index on category_course(category_id);
-- 210 msec - was
-- 107 msec - become


-- etc
create index course_index on course(id);
create index student_first_name_index on student(first_name);
create index staff_first_name_index on staff(first_name);
create index category_course_course_id_index on category_course(course_id);
create index tutor_course_course_id_index on tutor_course(course_id);
create index student_studied_at_index on student(studied_at);
