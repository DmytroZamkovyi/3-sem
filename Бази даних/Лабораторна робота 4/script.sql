SELECT COUNT(*) FROM employee WHERE employee.tariff > 200;

SELECT SUM(employee.tariff) FROM employee;

SELECT UPPER(employee.first_name) FROM employee;

SELECT LOWER(employee.first_name) FROM employee;

SELECT AGE(CURRENT_DATE, treaty.date_conclusion) FROM treaty;

SELECT COUNT(employee."id"), employee.tariff FROM employee GROUP BY employee.tariff;

SELECT COUNT(employee."id"), employee.tariff FROM employee GROUP BY employee.tariff HAVING COUNT(employee."id") >= 2;

SELECT MAX(tariff) FROM employee HAVING MAX(tariff) > 200;

SELECT ROW_NUMBER() over(ORDER BY(employee."id")), employee.first_name, employee.tariff FROM employee;

SELECT employee."id", employee.first_name, employee.lasr_name, employee.tariff FROM employee ORDER BY employee.first_name, employee.lasr_name;

CREATE OR REPLACE VIEW viewA AS SELECT treaty.id, employee.first_name, treaty.type_insurance FROM employee JOIN treaty USING(id) GROUP BY treaty.id, employee.first_name, treaty.type_insurance ORDER BY treaty.id; SELECT * FROM viewA;

CREATE OR REPLACE VIEW viewB AS SELECT viewA.id, viewA.first_name, employee.tariff, viewA.type_insurance FROM employee JOIN viewA USING(id) GROUP BY viewA.id, viewA.first_name, employee.tariff, viewA.type_insurance ORDER BY viewA.id; SELECT * FROM viewB;

--!ALTER VIEW viewB AS SELECT viewA.id, viewA.first_name, employee.tariff, employee.phone_number, viewA.type_insurance FROM employee JOIN viewA USING(id) GROUP BY viewA.id, viewA.first_name, employee.tariff, employee.phone_number, viewA.type_insurance ORDER BY viewA.id; SELECT * FROM viewB;

select pg_get_viewdef('viewA', true); select pg_get_viewdef('viewB', true);