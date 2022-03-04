create table if not exists buses
(
	id int auto_increment
		primary key,
	bus_model int not null,
	driver int null,
	mileage int default 0 not null,
	can_be_used tinyint(1) default 1 not null,
	constraint buses_bus_models_id_fk
		foreign key (bus_model) references bus_models (id)
			on update cascade on delete cascade,
	constraint buses_drivers_id_fk
		foreign key (driver) references drivers (id)
			on update set null on delete set null
);

