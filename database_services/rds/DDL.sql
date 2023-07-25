CREATE TABLE people (
    id smallint not null primary key,
    last_name varchar(255) not null,
    first_name varchar(255) not null,
    gender varchar(6) not null,
    address varchar(255),
    city varchar(255),
    department varchar(255),
    country varchar(255),
    postal_code varchar(255),
    phone varchar(255),
    mobile_phone varchar(255),
    dob date not null,
    age smallint,
    email varchar(255)
);
