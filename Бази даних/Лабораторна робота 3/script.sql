SELECT * FROM employee;

SELECT * FROM employee WHERE employee.tariff >= 450;

SELECT * FROM treaty WHERE treaty.date_conclusion < '2018-01-01' AND treaty.type_insurance = 'Повне';

SELECT * FROM treaty WHERE NOT treaty.type_insurance = 'Повне';

SELECT * FROM treaty WHERE treaty.type_insurance = 'Повне' OR treaty.type_insurance = 'Звичайне'

SELECT * FROM treaty WHERE (treaty.type_insurance = 'Повне' AND treaty.date_conclusion > '2015-01-01') OR (NOT treaty.type_insurance = 'Звичайне' AND treaty.date_conclusion < '2015-01-01');

SELECT employee.tariff/100 FROM employee WHERE employee.tariff > 200;

SELECT * FROM employee WHERE employee.tariff/100 > 2;

SELECT * FROM employee WHERE employee.tariff IN (100, 200, 300);

SELECT * FROM employee WHERE employee.tariff BETWEEN 200 AND 500;

SELECT * FROM employee WHERE employee.first_name LIKE 'Ж%';

SELECT * FROM employee WHERE employee.fathers_name IS NOT NULL;

SELECT e.first_name, e.tariff, t.type_insurance FROM employee e JOIN treaty t ON e."id" = t.id_employee;

SELECT A.first_name, A.tariff, A.type_insurance FROM (SELECT e.first_name, e.tariff, t.type_insurance, t.date_conclusion FROM employee e JOIN treaty t ON e."id" = t.id_employee) AS A WHERE A.tariff > (SELECT "avg"(tariff) FROM employee);

SELECT * FROM treaty WHERE EXISTS(SELECT * FROM employee);

SELECT * FROM insurer WHERE insurer.id IN (SELECT treaty.id_insurer FROM treaty);

SELECT * FROM insurer CROSS JOIN employee;

SELECT i.first_name, t.id_object FROM insurer i JOIN treaty t ON i.id = t.id_insurer;

SELECT i.first_name, i.phone_number, t.date_conclusion, t.type_insurance FROM insurer i JOIN treaty t ON i."id" = t.id_insurer AND i.phone_number > (SELECT "avg"(i.phone_number) FROM insurer i);

SELECT * FROM insurer i INNER JOIN treaty t ON i."id" = t.id_insurer;

SELECT * FROM insurer i LEFT JOIN treaty t ON i."id" = t.id_insurer;

SELECT * FROM insurer i RIGHT JOIN treaty t ON i."id" = t.id_insurer;

(SELECT * FROM insurer i LEFT JOIN treaty t ON i."id" = t.id_insurer) UNION (SELECT * FROM insurer i RIGHT JOIN treaty t ON i."id" = t.id_insurer);