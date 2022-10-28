CREATE TABLE object_insurance -- Об'єкти страхування
(
    id SERIAL,
    object_name VARCHAR(20) NOT NULL,
    object_type VARCHAR(20) NOT NULL,
    risks VARCHAR(255)
    -- PRIMARY KEY (id)
);

CREATE TABLE insurer_address -- Адреси страхувальників
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
    -- PRIMARY KEY (id)
);

CREATE TABLE employee_address -- Адреси працівників
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
    -- PRIMARY KEY (id)
);

CREATE TABLE branch_address -- Адреси філій
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
    -- PRIMARY KEY (id)
);

CREATE TABLE branch -- Філія
(
    id SERIAL,
    id_address INTEGER NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE,
    CHECK(phone_number >100000000000 AND phone_number <999999999999)
    -- FOREIGN KEY (id_address) REFERENCES branch_address (id),
    -- PRIMARY KEY (id)
);

CREATE TABLE insurer -- Страхувальник
(
    id SERIAL,
    first_name VARCHAR(20) NOT NULL,
    lasr_name VARCHAR(20) NOT NULL,
    fathers_name VARCHAR(20),
    id_address INTEGER NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE,
    CHECK(phone_number >100000000000 AND phone_number <999999999999)
    -- FOREIGN KEY (id_address) REFERENCES insurer_address(id),
    -- PRIMARY KEY (id)
);

CREATE TABLE employee -- Страховий агент
(
    id SERIAL,
    first_name VARCHAR(20) NOT NULL,
    lasr_name VARCHAR(20) NOT NULL,
    fathers_name VARCHAR(20),
    id_address INTEGER NOT NULL,
    phone_number INTEGER NOT NULL,
    tariff REAL NOT NULL,
    id_branch INTEGER NOT NULL
    -- FOREIGN KEY (id_address) REFERENCES employee_address(id),
    -- FOREIGN KEY (id_branch) REFERENCES branch(id),
    -- PRIMARY KEY (id)
);

CREATE TABLE treatyxxx -- Договір
(
    id SERIAL,
    id_employee INTEGER NOT NULL,
    id_insurer INTEGER NOT NULL,
    date_conclusion DATE NOT NULL,
    id_object INTEGER NOT NULL,
    type_insurancexxx VARCHAR(20)
    -- FOREIGN KEY (id_employee) REFERENCES employee(id),
    -- FOREIGN KEY (id_object) REFERENCES object_insurance(id),
    -- PRIMARY KEY (id)
);

CREATE TABLE finances -- Фінанси
(
    id_period SERIAL NOT NULL,
    year SMALLINT NOT NULL,
    month VARCHAR(10),
    salary REAL NOT NULL,
    xxx INTEGER
);

CREATE TABLE xxx -- Заздалегіть непотрібна таблиця
(
    xxx1 INTEGER,
    xxx2 INTEGER,
    xxx3 INTEGER,
    xxx4 INTEGER
);



ALTER TABLE branch -- Додав стовбець
ADD branch_name VARCHAR(250);

ALTER TABLE branch -- Змінив тип стовця
ALTER branch_name TYPE VARCHAR(40);

ALTER TABLE branch -- Додав обмаження стовпця
ALTER COLUMN branch_name 
SET NOT NULL;

ALTER TABLE employee -- Додав перевірку
ADD CHECK(phone_number >100000000000 AND phone_number <999999999999);

ALTER TABLE treatyxxx -- Прейменував колонку
RENAME COLUMN type_insurancexxx TO type_insurance;

ALTER TABLE treatyxxx -- Перейменував таблицю
RENAME TO treaty;



ALTER TABLE finances -- Видалив стовбець
DROP COLUMN xxx;

ALTER TABLE branch -- Видалив обмеження стовпця
ALTER COLUMN branch_name 
DROP NOT NULL;

DROP TABLE xxx; -- Видалення таблиці



ALTER TABLE object_insurance
ADD PRIMARY KEY (id);

ALTER TABLE insurer_address
ADD PRIMARY KEY (id);

ALTER TABLE employee_address
ADD PRIMARY KEY (id);

ALTER TABLE branch_address
ADD PRIMARY KEY (id);

ALTER TABLE branch
ADD PRIMARY KEY (id);

ALTER TABLE branch
ADD FOREIGN KEY (id_address) REFERENCES branch_address (id);

ALTER TABLE insurer
ADD PRIMARY KEY (id);

ALTER TABLE insurer
ADD FOREIGN KEY (id_address) REFERENCES insurer_address(id);

ALTER TABLE employee
ADD PRIMARY KEY (id);

ALTER TABLE employee
ADD FOREIGN KEY (id_address) REFERENCES employee_address(id);

ALTER TABLE employee
ADD FOREIGN KEY (id_branch) REFERENCES branch(id);

ALTER TABLE treaty
ADD PRIMARY KEY (id);

ALTER TABLE treaty
ADD FOREIGN KEY (id_employee) REFERENCES employee(id);

ALTER TABLE treaty
ADD FOREIGN KEY (id_object) REFERENCES object_insurance(id);

ALTER TABLE treaty
ADD FOREIGN KEY (id_insurer) REFERENCES insurer(id);




