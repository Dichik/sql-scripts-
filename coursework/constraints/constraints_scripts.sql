alter table staff add constraint salary_in_range check (
	salary BETWEEN 300 and 500
);

alter table student add constraint student_age_in_range check (
	age between 16 and 90
);

alter table finals add constraint finals_later_than_now check (
	date > now()
);

alter table student add constraint ch_student_email check(
	email ~* '^[a-zA-Z0-9_+&-]+(?:.[a-zA-Z0-9_+&-]+)*@(?:[a-zA-Z0-9-]+.)+[a-zA-Z]{2,7}'
);

alter table student add constraint check_first_letter check (
	first_name ~* '^[A-Z][a-z]+'
);

alter table student add constraint check_first_letter_s_name check (
	second_name ~* '^[A-Z]([a-z''])+'
);

alter table staff add constraint check_first_letter check (
	first_name ~* '^[A-Z][a-z]+'
);

alter table staff add constraint check_first_letter_s_name check (
	second_name ~* '^[A-Z]([a-z''])+'
);

alter table student add constraint check_m_number check (
	m_number ~* '\d{3}-\d{3}-\d{2}'
);

alter table category add constraint name_like check (
	name ~* 'category[A-E][1|2]'
);