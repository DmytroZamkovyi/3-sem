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
    phone_number BIGINT NOT NULL,
    tariff INTEGER NOT NULL,
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
INSERT INTO object_insurance VALUES
(1, 'Mercedes W124', 'Автомобіль', 'Автомобіль 1995року'),
(2, 'Subaru Forester', 'Автомобіль', '-'),
(3, 'Peugeot 208', 'Автомобіль', 'Водій часто потрапляє у ДТП, криворука відьма'),
(4, 'Квартира 145 ', 'Будинок', 'Розкол будинку навпіл'),
(5, 'Велосипед "Україна"', 'Велосипед', 'Викрадення з прибудинкової території'),
(6, 'Музей', 'Будинок', 'Рашистська ракета'),
(7, 'Lenovo m3', 'Ноутбук', 'Не витримає напруги після ДТЕКу'),
(8, 'Золотий годинник', 'Годинник', 'Цигани'),
(9, 'МММ', 'Фінансові вкладення(піраміда)', 'Власниця була замішана в скамі'),
(10, 'Гума на БМВ', 'Зимова гума', '-'),
(11, 'ЖК Навігатор', 'Квартира', 'Власниця - трудоголік'),
(12, 'BMW', 'Автомобіль', 'Власниця не має навіть сотки'),
(13, 'Василь', 'Кіт', 'Втече при першій можливості'),
(14, 'Ставицький', 'Людина', 'Кончена дура житомирська, контужена'),
(15, 'Лєнка', 'Нервова система', 'Ображена на весь світ'),
(16, 'Кукуха', 'Нервова система', 'Може поплисти');

INSERT INTO insurer_address VALUES
(1, 'м. Київ', 'Київ', 'Хрещатик', 1, 1),
(2, 'Житомирська', 'Бердичів', 'Хліборобів', 43, 6),
(3, 'м. Київ', 'Київ', 'Половецька', 16, 45),
(4, 'Дніпровська', 'Павлоград', 'Рудова', 35, 2),
(5, 'Тернопільска', 'Рогачин', 'Парних', 12, 53),
(6, 'Черкаська', 'Канів', 'Григорівська', 4, 5),
(7, 'Полтавька', 'Миргород', 'Нимирівська', 9, 12),
(8, 'Донецька', 'Покровськ', 'Нагірна', 53, 98),
(9, 'Ченігівська', 'Козелець', 'Островського', 11, 6),
(10, 'Львівська', 'Трускавець', 'Жадана', 22, 8),
(11, 'Одеська', 'Затока', 'Пляжна', 27, 3),
(12, 'Закарпатська', 'Рахів', 'Краковська', 10, 7),
(13, 'Херсонська', 'Чаплинка', 'Стриха', 16, 4),
(14, 'Рівненська', 'Сарни', 'Оболми', 38, 9),
(15, 'Запорізька', 'Енергодар', 'Квітуча', 49, 10);

INSERT INTO employee_address VALUES
(1, 'Харківська', 'Харків', 'Міська', 44, 4),
(2, 'Хмельницька', 'Кам"янець-Польськ', 'Спортивна', 74, 1),
(3, 'Рівненська', 'Острог', 'Прорізна', 23, 2),
(4, 'Закарпатська', 'Ужгород', 'Білицька', 11, 5),
(5, 'Черкаська', 'Сміла', 'Хорова', 10, 8),
(6, 'Полтавська', 'Кременчук', 'Гвардейська', 33, 7),
(7, 'Запорізька', 'Запоріжжя', 'Польова', 56, 3),
(8, 'Кіровоградська', 'Кропивницький', 'Дрімуча', 81, 9),
(9, 'Донецька', 'Нью-Йорк', 'Кримська', 30, 10),
(10, 'Луганська', 'Золоте', 'Водяна', 17, 6),
(11, 'Київська', 'Обухів', 'Уманцева', 44, 12),
(12, 'Ченігівська', 'Ніжин', 'Таврійська', 25, 34),
(13, 'Харківська', 'Белгород (БНР)', 'Балтійська', 67, 27),
(14, 'Луцька', 'Ковель', 'Половецька', 8, 11),
(15, 'АР Крим', 'Сімферополь', 'Татарська', 3, 13);

INSERT INTO branch_address VALUES
(1, 'Лівівська', 'Львів', 'Центральна', 12, 54),
(2, 'Київська', 'Біла Церква', 'Свободи', 22, 10),
(3, 'Івано-Франківська', 'Яремче', 'Весняна', 5, 3),
(4, 'Дніпровська', 'Дніпро', 'Литовська', 10, 15),
(5, 'Чернівецька', 'Кицмань', 'Богдана Хмельницького', 23, 9),
(6, 'Тернопільська', 'Кобазрівка', 'Овруцька', 19, 6),
(7, 'Луцька', 'Торчин', 'Виговського', 7, 3),
(8, 'Ченігівська', 'Десна', 'Зарічна', 89, 4),
(9, 'Сумська', 'Конотоп', 'Обласна', 34, 45),
(10, 'Миколаївська', 'Баштанка', 'Ткацька', 28, 67),
(11, 'Житомирська', 'Малин', 'провулок Житній', 11, 80),
(12, 'Вінницька', 'Вінниця', 'Квартальна', 64, 11),
(13, 'Одеська', 'Черноморськ', 'Подільська', 33, 2),
(14, 'Харківська', 'Салтівка', 'Кучарова', 17, 16),
(15, 'Херсонська', 'Каховка', 'Міністерська', 20, 21);

INSERT INTO branch VALUES
(1, 1, 380509872563, 'ПЕРША ФІЛІЯ'),
(2, 2, 380621372060, 'БІЛОЦЕРКІВСЬКА ФІЛІЯ'),
(3, 3, 380570009183, 'ФІЛАЯ АМПЕР'),
(4, 4, 380907050640, 'ФІЛІЯ БЛОКБАСТЕР'),
(5, 5, 380376765699, 'ДЕСНЯНСЬКА ФІЛІЯ'),
(6, 6, 380979296709, 'ФІЛІЯ 95'),
(7, 7, 380247026921, 'ФІЛІЯ БРОНТЕХМАШ'),
(8, 8, 380741338754, 'ФІЛІЯ СОЛОДКИЙ КУШ'),
(9, 9, 380457139238, 'ФІЛІЯ ФРАГМЕНТ'),
(10, 10, 380155902440, 'ФІЛІЯ ХОФМАНИТА'),
(11, 11, 380330749765, 'ХОЛМСЬКА ФІЛІЯ'),
(12, 12, 380483418676, 'ФІЛІЯ ЗАЛІЗНЯК'),
(13, 13, 380910269151, 'ФІЛІЯ 656'),
(14, 14, 380432565377, 'ДЕРОБРОБ ФІЛІЯ'),
(15, 15, 380974389042, 'ОБЛАСНА ФІЛІЯ');

INSERT INTO insurer VALUES
(1, 'Порошенко', 'Петро', 'Олексійович', 1, 380678523459),
(2, 'Словець', 'Анастасія', 'Якимівна', 2, 380954781660),
(3, 'Кушніренко', 'Інна', 'Віталіївна', 3, 380972593852),
(4, 'Анніна', 'Тетяна', 'Димитрівна', 4, 380984584783),
(5, 'Усенко', 'Оксана', 'Володимирівна', 5, 380974674379),
(6, 'Кравець', 'Ксенія', 'Йосипівна', 6, 380978532674),
(7, 'Бурлака', 'Євгенія', 'Кирилівна', 7, 380955119921),
(8, 'Кияниця', 'Світлана', 'Павлівна', 8, 380660249462),
(9, 'Фесан', 'Ольга', 'Андріївна', 9, 380983763676),
(10, 'Мурдза', 'Ірина', 'Михайлівна', 10, 380934129549),
(11, 'Ярошик', 'Катерина', 'Олександрівна', 11, 380502345350),
(12, 'Савченко', 'Діана', 'Валеріївна', 12, 380987592715),
(13, 'Печена', 'Марія', 'Павлівна', 13, 380989520563),
(14, 'Артющенко', 'Наталія', 'Іванівна', 14, 380973942972),
(15, 'Якимчук', 'Олена', 'Володимирівна', 15, 380679863106);

INSERT INTO employee VALUES
(1, 'Іванов', 'Іван', 'Іванович', 1, 380934568523, 500, 1),
(2, 'Жупанов', 'Олег', 'Панасович', 2, 380976356530, 450, 2),
(3, 'Бойко', 'Олександр', 'Тарасович', 3, 380960327042, 350, 3),
(4, 'Карпенко', 'Павло', 'Миколайович', 4, 380937689522, 220, 4),
(5, 'Токмач', 'Микита', 'Денисович', 5, 380985174158, 600, 5),
(6, 'Філюк', 'Андрій', 'Костянтинович', 6, 380949874301, 150, 6),
(7, 'Жмишенко', 'Євгеній', 'Віталійович', 7, 380959326278, 300, 7),
(8, 'Савченко', 'Захар', 'Борисович', 8, 380978794893, 700, 8),
(9, 'Цимбал', 'Ілля', 'Федорович', 9, 380988438914, 270, 9),
(10, 'Нестеренко', 'Дмитро', 'Вікторович', 10, 380966739245, 360, 10),
(11, 'Джоган', 'Володимир', 'Григорович', 11, 380895392056, 110, 11),
(12, 'Власов', 'Артем', 'Романович', 12, 380975875736, 228, 12),
(13, 'Маков', 'Дем"ян', 'Вячеславочив', 13, 380968493211, 400, 13),
(14, 'Хоменко', 'Семен', 'Ярославович', 14, 380936899214, 200, 14),
(15, 'Антонюк', 'Юрій', 'Леонідович', 15, 380983763675, 100, 15);

INSERT INTO treaty VALUES
(1, 1, 1, '2022-03-22', 1, 'Повне'),
(2, 2, 2, '2015-05-06', 2, 'Часткове'),
(3, 3, 3, '2009-07-06', 3, 'Звичайне'),
(4, 4, 4, '2020-05-29', 4, 'Мінімальне'),
(5, 5, 5, '2016-08-07', 5, 'Часткове'),
(6, 6, 6, '2013-11-09', 6, 'Звичайне'),
(7, 7, 7, '2019-08-12', 7, 'Повне'),
(8, 8, 8, '2012-05-29', 8, 'Мінімальне'),
(9, 9, 9, '2015-12-21', 9, 'Повне'),
(10, 10, 10, '2017-09-22', 10, 'Мінімальне'),
(11, 11, 11, '2015-06-04', 11, 'Повне'),
(12, 12, 12, '2019-10-20', 12, 'Звичайне'),
(13, 13, 13, '2022-02-24', 13, 'Повне'),
(14, 14, 14, '2019-05-04', 14, 'Мінімальне'),
(15, 15, 15, '2017-05-16', 15, 'Часткове'),
(16, 4, 3, '2022-11-15', 16, 'Максимальне');

INSERT INTO finances VALUES
(1, 2022, 'Лютий', 150000),
(2, 2015, 'Червень', 230000),
(3, 2012, 'Вересень', 560000),
(4, 2020, 'Квітень', 180000),
(5, 2019, 'Жовтень', 436540),
(6, 2016, 'Травень', 345000),
(7, 2005, 'Липень', 111000),
(8, 2009, 'Листопад', 245000),
(9, 2011, 'Серпень', 580000),
(10, 2008, 'Грудень', 971000),
(11, 2017, 'Березень', 210000),
(12, 2013, 'Січень', 630500),
(13, 2018, 'Жовтень', 409500),
(14, 2014, 'Квітень', 125000),
(15, 2021, 'Березень', 103200);
