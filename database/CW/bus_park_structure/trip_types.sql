create table if not exists trip_types
(
	id int auto_increment
		primary key,
	type varchar(50) not null,
	description text null,
	tax_percentage float default 0 not null,
	discount_percentage float default 0 not null,
	constraint trip_types_trip_type_uindex
		unique (type)
);

