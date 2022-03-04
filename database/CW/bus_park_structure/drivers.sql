create table if not exists drivers
(
	id int auto_increment
		primary key,
	name varchar(50) not null,
	surname varchar(50) not null
);

