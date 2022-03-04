create table if not exists bus_models
(
	id int auto_increment
		primary key,
	brand int not null,
	model varchar(50) not null,
	seats int not null,
	constraint bus_models_brands_id_fk
		foreign key (brand) references brands (id)
			on update cascade on delete cascade
);

