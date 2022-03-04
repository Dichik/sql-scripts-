create table if not exists trip
(
	id int auto_increment
		primary key,
	creation_date date not null,
	trip_date date not null,
	time_hours int default 0 not null,
	trip_type int null,
	bus int null,
	prepaid_expense float default 0 not null,
	price float default 0 not null,
	organization int null,
	constraint trip_buses_id_fk
		foreign key (bus) references buses (id)
			on update set null on delete set null,
	constraint trip_organization_id_fk
		foreign key (organization) references organization (id)
			on update set null on delete set null,
	constraint trip_trip_types_id_fk
		foreign key (trip_type) references trip_types (id)
			on update set null on delete set null
);

