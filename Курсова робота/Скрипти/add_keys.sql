ALTER TABLE ZNO_result
ADD PRIMARY KEY (id);

ALTER TABLE ZNO_list
ADD PRIMARY KEY (id);

ALTER TABLE enrolled_abiturient
ADD PRIMARY KEY (id);

ALTER TABLE abiturient
ADD PRIMARY KEY (id);

ALTER TABLE document
ADD PRIMARY KEY (id);

ALTER TABLE department_priority
ADD PRIMARY KEY (id);

ALTER TABLE statements
ADD PRIMARY KEY (id);

ALTER TABLE department
ADD PRIMARY KEY (id);

ALTER TABLE specialty
ADD PRIMARY KEY (id);

ALTER TABLE faculty
ADD PRIMARY KEY (id);

ALTER TABLE ZNO_result
ADD FOREIGN KEY (id_abiturient) REFERENCES abiturient(id),
ADD FOREIGN KEY (id_subject) REFERENCES ZNO_list(id);

ALTER TABLE enrolled_abiturient
ADD FOREIGN KEY (id_statement) REFERENCES statements(id);

ALTER TABLE document
ADD FOREIGN KEY (id_abiturient) REFERENCES abiturient(id);

ALTER TABLE department_priority
ADD FOREIGN KEY (id_departament) REFERENCES department(id),
ADD FOREIGN KEY (id_statement) REFERENCES statements(id);

ALTER TABLE statements
ADD FOREIGN KEY (id_abiturient) REFERENCES abiturient(id),
ADD FOREIGN KEY (id_specialty) REFERENCES specialty(id),
ADD FOREIGN KEY (id_faculty) REFERENCES faculty(id);

ALTER TABLE department
ADD FOREIGN KEY (id_faculty) REFERENCES faculty(id),
ADD FOREIGN KEY (id_specialty) REFERENCES specialty(id);