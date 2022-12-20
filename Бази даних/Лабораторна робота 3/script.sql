-- Найпротіше вибірка
SELECT * FROM employee;

-- Оператор порівняння
SELECT * FROM employee WHERE employee.tariff >= 450;

-- Використання AND
SELECT * FROM treaty WHERE treaty.date_conclusion < '2018-01-01' AND treaty.type_insurance = 'Повне';

-- Використання OR
SELECT * FROM treaty WHERE treaty.type_insurance = 'Повне' OR treaty.type_insurance = 'Звичайне';

-- Використання NOT
SELECT * FROM treaty WHERE NOT treaty.type_insurance = 'Повне';

-- Комбінації AND, OR та NOT
SELECT * FROM treaty WHERE (treaty.type_insurance = 'Повне' AND treaty.date_conclusion > '2015-01-01') OR (NOT treaty.type_insurance = 'Звичайне' AND treaty.date_conclusion < '2015-01-01');

-- Вираз над умовою
SELECT employee.first_name, employee.tariff + 30 FROM employee WHERE employee.tariff > 200;

-- Вираз над стовпцями
SELECT * FROM employee WHERE employee.tariff + 30 > 200;

-- Приналежність множини
SELECT * FROM treaty WHERE treaty.type_insurance IN ('Повне', 'Часткове'); 

-- Приналежність діапазону
SELECT * FROM employee WHERE employee.tariff BETWEEN 200 AND 400;

-- Відповідність шаблону
SELECT * FROM employee WHERE employee.first_name LIKE 'Ж%';

-- Перевірка на невизначені значення
SELECT * FROM employee WHERE employee.fathers_name IS NOT NULL;

-- Підзапит у SELECT
SELECT employee.first_name, employee.tariff, treaty.type_insurance FROM employee JOIN treaty ON employee.id = treaty.id_employee;

-- Підзапит у FROM
SELECT A.first_name, A.tariff, A.type_insurance FROM (SELECT employee.first_name, employee.tariff, treaty.type_insurance, treaty.date_conclusion FROM employee JOIN treaty ON employee.id = treaty.id_employee) AS A WHERE A.tariff > (SELECT "avg"(tariff) FROM employee);

-- Використання EXISTS
SELECT * FROM treaty WHERE EXISTS(SELECT * FROM employee);

-- Використання IN
SELECT * FROM insurer WHERE insurer.id IN (SELECT treaty.id_insurer FROM treaty);

-- Декартовий добуток
SELECT * FROM insurer CROSS JOIN employee;

-- Рівність
SELECT i.first_name, t.id_object FROM insurer i JOIN treaty t ON i.id = t.id_insurer;

-- Умова відбору та рівность
SELECT e.first_name, e.tariff, t.date_conclusion, t.type_insurance FROM employee e JOIN treaty t ON e.id = t.id_employee AND e.tariff > (SELECT "avg"(employee.tariff) FROM employee);

-- Внутрішнє з'єднання
SELECT * FROM insurer INNER JOIN treaty ON insurer.id = treaty.id_insurer;

-- Ліве з'єднання
SELECT * FROM insurer i LEFT JOIN treaty t ON i."id" = t.id_insurer;

-- Праве з'єднання
SELECT * FROM insurer i RIGHT JOIN treaty t ON i."id" = t.id_insurer;

-- Об'єднання запитів
(SELECT * FROM insurer i LEFT JOIN treaty t ON i."id" = t.id_insurer) UNION (SELECT * FROM insurer i RIGHT JOIN treaty t ON i."id" = t.id_insurer);