create table if not exists cece
(
    id     int auto_increment,
    naming text not null,
    constraint cece_id_uindex
        unique (id)
);

alter table cece
    add primary key (id);

create table if not exists companies
(
    id       int auto_increment,
    naming   text null,
    location text null,
    constraint companies_id_uindex
        unique (id)
);

alter table companies
    add primary key (id);

create table if not exists estimate
(
    id         int auto_increment,
    cece_id    int   null,
    sum        float null,
    naming     text  null,
    company_id int   null,
    constraint estimate_id_uindex
        unique (id),
    constraint estimate_cece_id_fk
        foreign key (cece_id) references cece (id),
    constraint estimate_companies_id_fk
        foreign key (company_id) references companies (id)
);

alter table estimate
    add primary key (id);

create table if not exists estimate_change
(
    id          int auto_increment,
    estimate_id int   null,
    naming      int   null,
    sum         float null,
    constraint estimate_change_id_uindex
        unique (id),
    constraint estimate_change_estimate_id_fk
        foreign key (estimate_id) references estimate (id)
);

alter table estimate_change
    add primary key (id);

create table if not exists treasury
(
    id       int auto_increment,
    naming   text null,
    location text null,
    constraint treasury_id_uindex
        unique (id)
);

alter table treasury
    add primary key (id);

create table if not exists payment_orders
(
    id          int auto_increment,
    cece_id     int   null,
    sum         float not null,
    directed_to int   null,
    created_by  int   null,
    created_at  date  not null,
    constraint ` payment_orders_id_uindex`
        unique (id),
    constraint payment_orders_cece_id_fk
        foreign key (cece_id) references cece (id),
    constraint payment_orders_companies_id_fk
        foreign key (created_by) references companies (id),
    constraint payment_orders_treasury_id_fk
        foreign key (directed_to) references treasury (id)
);

alter table payment_orders
    add primary key (id);


