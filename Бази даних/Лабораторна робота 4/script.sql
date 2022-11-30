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

