commit; 

BEGIN;

-- [category] data created
CREATE TABLE IF NOT EXISTS public.category
(
    name character(255) NOT NULL,
    description character(1000) NOT NULL,
    PRIMARY KEY (name)
);

-- [course] data created
CREATE TABLE IF NOT EXISTS public.course
(
    id bigint NOT NULL,
    name character(255) NOT NULL,
    left_places integer NOT NULL DEFAULT 10,
    PRIMARY KEY (id)
);

-- [student] data created
CREATE TABLE IF NOT EXISTS public.student
(
    id bigint NOT NULL,
    first_name character(255) NOT NULL,
    second_name character(255) NOT NULL,
    age integer,
    m_number character(10) NOT NULL,
    email character(255) NOT NULL,
    studied_at character(255) NOT NULL,
    PRIMARY KEY (id),
    constraint fk_studied_at
        foreign key (studied_at)
            references category(name) on delete cascade
);

-- [job_title] data created 
create table if not exists public.job_title 
(
    id bigint not null, 
    job_title_desc character(255),
    primary key (id)
);

-- [staff] data created
CREATE TABLE IF NOT EXISTS public.staff
(
    id bigint NOT NULL,
    first_name character(255) NOT NULL,
    second_name character(255) NOT NULL,
    salary double precision NOT NULL,
    total_courses integer NOT NULL,
    job_title_id bigint NOT NULL,
    PRIMARY KEY (id),
    constraint fk_job_title_id
        foreign key (job_title_id)
            references job_title(id) on delete cascade
);

-- [activity] data created
CREATE TABLE IF NOT EXISTS public.activity
(
    id bigint NOT NULL,
    name character(255) NOT NULL,
    date date NOT NULL,
    time_start time without time zone,
    staff_id bigint NOT NULL,
    description character(255) NOT NULL,
    score integer DEFAULT 0,
    PRIMARY KEY (id),
    constraint fk_staff_id
        foreign key (staff_id)
            references staff(id)
);

-- [vehicle_type] data creted
create table if not exists public.vehicle_type
(
    id bigint not null, 
    vehicle_type_desc character(255) not null,
    primary key (id)
);

-- [finals] data created
CREATE TABLE IF NOT EXISTS public.finals
(
    id bigint NOT NULL,
    name character(255) NOT NULL,
    course_id bigint NOT NULL,
    date date NOT NULL,
    time_start time without time zone NOT NULL,
    vehicle_type_id bigint not null, 
    PRIMARY KEY (id),
    constraint fk_course_id 
        foreign key (course_id) 
            references course(id) on delete cascade,
    constraint fk_vehicle_type_id
        foreign key (vehicle_type_id)
            references vehicle_type(id) on delete cascade
);

-- [mark] data created
CREATE TABLE IF NOT EXISTS public.mark
(
    id bigint NOT NULL,
    mark double precision NOT NULL,
    student_id bigint NOT NULL,
    activity_id bigint NOT NULL,
    PRIMARY KEY (id),
    constraint fk_student_id
        foreign key (student_id)
            references student(id) on delete cascade,
    constraint fk_activity_id
        foreign key (activity_id)
            references activity(id) on delete cascade
);

-- [topic] data created
CREATE TABLE IF NOT EXISTS public.topic
(
    id bigint NOT NULL,
    name character(255) NOT NULL,
    description character(1000) NOT NULL,
    PRIMARY KEY (id)
);

-- [topic_course] data created
CREATE TABLE IF NOT EXISTS public.topic_course
(
    topic_id bigint NOT NULL,
    course_id bigint NOT NULL,
    primary key(topic_id, course_id),
    constraint fk_topic_id
        foreign key (topic_id)
            references topic(id) on delete cascade,
    constraint fk_course_id
        foreign key (course_id) 
            references course(id) on delete cascade
);

-- [category_course] data created
CREATE TABLE IF NOT EXISTS public.category_course
(
    category_id character(255) NOT NULL,
    course_id bigint NOT NULL,
    PRIMARY KEY (category_id, course_id),
    constraint fk_category_id
        foreign key (category_id) 
            references category(name) on delete cascade,
    constraint fk_course_id
        foreign key (course_id)
            references course(id) on delete cascade
);

-- [tutor_course] data created
CREATE TABLE IF NOT EXISTS public.tutor_course
(
    staff_id bigint NOT NULL,
    course_id bigint NOT NULL,
    PRIMARY KEY (staff_id, course_id),
    constraint fk_staff_id
        foreign key (staff_id)
            references staff(id) on delete cascade,
    constraint fk_course_id
        foreign key (course_id)
            references course(id) on delete cascade
);

END;