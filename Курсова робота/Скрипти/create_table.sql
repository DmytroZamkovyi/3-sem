CREATE TABLE ZNO_result (
    id SERIAL,
    id_abiturient INTEGER NOT NULL,
    id_subject INTEGER NOT NULL,
    result SMALLINT NOT NULL
);

CREATE TABLE ZNO_list (
    id SERIAL,
    subject_name VARCHAR(40) NOT NULL,
    min_score INTEGER NOT NULL
);

CREATE TABLE enrolled_abiturient (
    id SERIAL,
    id_statement INTEGER NOT NULL,
    scholarship BOOLEAN NOT NULL
);

CREATE TABLE abiturient (
    id SERIAL,
    first_name VARCHAR(40) NOT NULL,
    lasr_name VARCHAR(40) NOT NULL,
    fathers_name VARCHAR(40),
    birthday DATE,
    phone_number BIGINT NOT NULL UNIQUE,
    email VARCHAR(40) NOT NULL UNIQUE,
    certificate_score SMALLINT,
    quota SMALLINT,
    is_conditions BOOLEAN NOT NULL,
    is_dormitory BOOLEAN NOT NULL
);

CREATE TABLE document (
    id SERIAL,
    id_abiturient INTEGER NOT NULL,
    short_description VARCHAR(40) NOT NULL,
    document_url VARCHAR(255) NOT NULL
);

CREATE TABLE department_priority (
    id SERIAL,
    id_departament INTEGER NOT NULL,
    id_statement INTEGER NOT NULL,
    priorities SMALLINT
);

CREATE TABLE statements (
    id SERIAL,
    id_abiturient INTEGER NOT NULL,
    id_specialty INTEGER NOT NULL,
    id_faculty INTEGER NOT NULL,
    priorities SMALLINT,
    score SMALLINT NOT NULL,
    course SMALLINT
);

CREATE TABLE department (
    id SERIAL,
    id_faculty INTEGER NOT NULL,
    id_specialty INTEGER NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE
);

CREATE TABLE specialty (
    id SERIAL,
    specialty_name VARCHAR(100) NOT NULL
);

CREATE TABLE faculty (
    id SERIAL,
    full_name INTEGER NOT NULL,
    short_name INTEGER NOT NULL,
    budget_places INTEGER,
    contract_places INTEGER,
    phone_number BIGINT NOT NULL UNIQUE
);