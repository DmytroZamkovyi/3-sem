-- !Створення таблиць
CREATE TABLE object_insurance -- Об'єкти страхування
(
    id SERIAL,
    object_name VARCHAR(40) NOT NULL,
    object_type VARCHAR(40) NOT NULL,
    risks VARCHAR(255)
);

CREATE TABLE insurer_address -- Адреси страхувальників
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
);

CREATE TABLE employee_address -- Адреси працівників
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
);

CREATE TABLE branch_address -- Адреси філій
(
    id SERIAL,
    region VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    house SMALLINT NOT NULL,
    office SMALLINT
);

CREATE TABLE branch -- Філія
(
    id SERIAL,
    id_address INTEGER NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE
);

CREATE TABLE insurer -- Страхувальник
(
    id SERIAL,
    first_name VARCHAR(40) NOT NULL,
    lasr_name VARCHAR(40) NOT NULL,
    fathers_name VARCHAR(40),
    id_address INTEGER NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE
);

CREATE TABLE employee -- Страховий агент
(
    id SERIAL,
    first_name VARCHAR(40) NOT NULL,
    lasr_name VARCHAR(40) NOT NULL,
    fathers_name VARCHAR(40),
    id_address INTEGER NOT NULL,
    phone_number INTEGER NOT NULL,
    tariff REAL NOT NULL,
    id_branch INTEGER NOT NULL
);

CREATE TABLE treatyxxx -- Договір
(
    id SERIAL,
    id_employee INTEGER NOT NULL,
    id_insurer INTEGER NOT NULL,
    date_conclusion DATE NOT NULL,
    id_object INTEGER NOT NULL,
    type_insurancexxx VARCHAR(40)
);

CREATE TABLE finances -- Фінанси
(
    id_period SERIAL NOT NULL,
    year SMALLINT NOT NULL,
    month VARCHAR(10),
    salary REAL NOT NULL,
    xxx INTEGER -- Непотрібний стовпець
);

CREATE TABLE xxx -- Заздалегіть непотрібна таблиця
(
    xxx1 INTEGER,
    xxx2 INTEGER,
    xxx3 INTEGER,
    xxx4 INTEGER
);



-- !Редагування таблиць
ALTER TABLE branch -- Додав стовбець
ADD branch_name VARCHAR(250);

ALTER TABLE branch -- Змінив тип стовця
ALTER branch_name TYPE VARCHAR(40);

ALTER TABLE branch -- Додав обмаження стовпця
ALTER COLUMN branch_name
SET NOT NULL;

ALTER TABLE employee -- Додав перевірку
ADD CONSTRAINT check_phone_number CHECK(phone_number BETWEEN 100000000000 AND 999999999999);

ALTER TABLE insurer
ADD CONSTRAINT check_phone_number CHECK(phone_number BETWEEN 100000000000 AND 999999999999);

ALTER TABLE branch
ADD CONSTRAINT check_phone_number CHECK(phone_number BETWEEN 100000000000 AND 999999999999);

ALTER TABLE xxx -- Зайва перевірка
ADD CONSTRAINT check_xxx CHECK(xxx1 BETWEEN 100000000000 AND 999999999999);

ALTER TABLE treatyxxx -- Прейменував колонку
RENAME COLUMN type_insurancexxx TO type_insurance;

ALTER TABLE treatyxxx -- Перейменував таблицю
RENAME TO treaty;



-- !Видалення таблиць
ALTER TABLE finances -- Видалив стовбець
DROP COLUMN xxx;

ALTER TABLE xxx -- Видалив обмеження стовпця
DROP CONSTRAINT check_xxx;

ALTER TABLE branch
ALTER COLUMN branch_name
DROP NOT NULL;

DROP TABLE xxx; -- Видалення таблиці



-- !Додавання ключів
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



-- !Створення типів користувачів
CREATE ROLE programmer CREATEDB CREATEROLE;

CREATE ROLE director;

CREATE ROLE employee CREATEDB;



-- !Створення користувачів
CREATE ROLE programmer_sam PASSWORD 'pilot21' LOGIN;

CREATE ROLE director_joe PASSWORD 'awerty656' LOGIN;

CREATE ROLE employee_kate PASSWORD 'kate_pass_12' LOGIN;



-- !Надань прав ролей користувачам
GRANT programmer TO programmer_sam;

GRANT director TO director_joe;

GRANT employee TO employee_kate;



-- !Імпорт даних
