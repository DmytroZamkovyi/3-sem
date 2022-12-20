-- Використання COUNT
SELECT COUNT(*) FROM employee WHERE employee.tariff > 200;

-- Використання SUM
SELECT SUM(employee.tariff) FROM employee;

-- Використання UPPER
SELECT UPPER(employee.first_name) FROM employee;

-- Використання LOWER
SELECT LOWER(employee.first_name) FROM employee;

-- Використання функцыъ по роботы з датами
SELECT id, AGE(CURRENT_DATE, treaty.date_conclusion) FROM treaty;

-- Використання групування по декільком стовпцям
SELECT COUNT(employee."id"), employee.tariff FROM employee GROUP BY employee.tariff;

-- Використання HAVING
SELECT COUNT(employee."id"), employee.tariff FROM employee GROUP BY employee.tariff HAVING COUNT(employee."id") > 1;

-- Використання HAVING без GROUP BY
SELECT MAX(tariff) FROM employee HAVING MAX(tariff) > 500;

-- Використання ROW_NUMBER
SELECT ROW_NUMBER() over(ORDER BY(employee."id")), employee.first_name, employee.tariff FROM employee;

-- Використання сортування по декільком стовпцям
SELECT employee."id", employee.first_name, employee.lasr_name, employee.tariff FROM employee ORDER BY employee.first_name, employee.lasr_name;

-- Створення VIEW
CREATE VIEW viewA AS SELECT treaty.id, employee.first_name, treaty.type_insurance FROM employee JOIN treaty USING(id) GROUP BY treaty.id, employee.first_name, treaty.type_insurance ORDER BY treaty.id;

-- Створення VIEW із використанням створеного раніше VIEW
CREATE VIEW viewB AS SELECT viewA.id, viewA.first_name, employee.tariff, viewA.type_insurance FROM employee JOIN viewA USING(id) GROUP BY viewA.id, viewA.first_name, employee.tariff, viewA.type_insurance ORDER BY viewA.id;

-- Використання ALTER VIEW
ALTER VIEW viewa RENAME TO view_a;
ALTER VIEW viewb RENAME TO view_b;

-- Вивід створених VIEW
SELECT * FROM view_a;
SELECT * FROM view_b;

-- Отримання довідкової інформації про створенні представлення
SELECT pg_get_viewdef('view_a');
SELECT pg_get_viewdef('view_b');