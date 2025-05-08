--USE master
--CREATE DATABASE BookShop

USE BookShop
CREATE TABLE Themes(
	Id int not null primary key identity(1, 1),
	Name nvarchar(100) not null CHECK(Name<>'') UNIQUE
);

CREATE TABLE Countries(
	Id int not null primary key identity(1, 1),
	Name nvarchar(50) not null CHECK(Name<>'') UNIQUE
);

CREATE TABLE Shops(
	Id int not null primary key identity(1, 1),
	Name nvarchar(MAX) not null CHECK(Name<>''),
	CountryId int foreign key references Countries(Id)
	ON DELETE Set null
	ON UPDATE Set null
);

CREATE TABLE Authors(
	Id int not null primary key identity(1, 1),
	Name nvarchar(MAX) not null CHECK(Name<>''),
	Surname nvarchar(MAX) not null CHECK(Surname<>''),
	CountryId int foreign key references Countries(Id)
	ON DELETE Set null
	ON UPDATE Set null
);

CREATE TABLE Books(
	Id int not null primary key identity(1, 1),
	Name nvarchar(MAX) not null CHECK(Name<>''),
	Pages int not null CHECK(Pages>0),
	Price money not null CHECK(Price>0),
	PublishDate date not null CHECK(PublishDate<GETDATE()),
	AuthorId int foreign key references Authors(Id)
	ON DELETE Set null
	ON UPDATE Set null,
	ThemeId int foreign key references Themes(Id)
	ON DELETE Set null
	ON UPDATE Set null
);

CREATE TABLE Sales(
	Id int not null primary key identity(1, 1),
	Price money not null CHECK(Price>0),
	Quantity int not null CHECK(Quantity>0),
	SaleDate date not null CHECK(SaleDate<=GETDATE()) DEFAULT GETDATE(),
	BookId int foreign key references Books(Id)
	ON DELETE Set null
	ON UPDATE Set null,
	ShopId int foreign key references Shops(Id)
);

INSERT INTO Themes (Name)
VALUES ('Програмування'),
	   ('Адміністрування'),
	   ('Детектив'),
	   ('Фантастика'),
	   ('Наукова література'),
	   ('Мікросхеми'),
	   ('Дизайн'),
	   ('Мікрософт'),
	   ('Філософія'),
	   ('Класика')

INSERT INTO Countries (Name)
VALUES ('Україна'),
	   ('США'),
	   ('Канада'),
	   ('Франція'),
	   ('Німеччина'),
	   ('Італія'),
	   ('Японія'),
	   ('Індія'),
	   ('Польща'),
	   ('Іспанія')

INSERT INTO Shops (Name, CountryId)
VALUES ('BookWorld', 2),
	   ('ЧитайМісто', 1),
	   ('ReadMore', 3),
	   ('Librairie Paris', 4),
	   ('Berlin Books', 5),
	   ('RomaLibri', 6),
	   ('Tokyo Pages', 7),
	   ('Indie Reads', 8),
	   ('Warsaw Pages', 9),
	   ('Barcelona Books', 10)

INSERT INTO Authors (Name, Surname, CountryId)
VALUES ('Герберт', 'Шилдт', 2),
	   ('Артур', 'Конан Дойл', 4),
	   ('Джордж', 'Оруелл', 5),
	   ('Вільям', 'Шекспір', 5),
	   ('Марк', 'Твен', 2),
	   ('Мікеланджело', 'Ріккарді', 6),
	   ('Сатору', 'Накамура', 7),
	   ('Іван', 'Франко', 1),
	   ('Тарас', 'Шевченко', 1),
	   ('Роберт', 'Кіясакі', 3)

INSERT INTO Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId)
VALUES ('Програмування на Java', 800, 150.00, '2019-03-10', 1, 1),
	   ('Пригоди Шерлока Холмса', 600, 120.00, '1892-11-01', 2, 3),
	   ('1984', 500, 110.00, '1949-06-08', 3, 4),
	   ('Макбет', 320, 90.00, '1606-01-01', 4, 10),
	   ('Життя на Міссісіпі', 480, 85.00, '1883-05-01', 5, 10),
	   ('Мистецтво дизайну', 350, 200.00, '2020-06-12', 6, 7),
	   ('Японські мікросхеми', 700, 250.00, '2021-08-18', 7, 6),
	   ('Збірка поезій', 220, 70.00, '1880-02-15', 8, 9),
	   ('Кобзар', 350, 75.00, '1840-03-01', 9, 9),
	   ('Microsoft Programming Guide', 900, 300.00, '2022-09-01', 10, 8)

INSERT INTO Sales (Price, Quantity, SaleDate, BookId, ShopId)
VALUES (150.00, 12, '2023-01-10', 1, 1),
	   (120.00, 35, '2023-02-15', 2, 2),
	   (110.00, 7, '2023-03-05', 3, 3),
	   (90.00, 5, '2023-04-01', 4, 4),
	   (85.00, 9, '2023-04-18', 5, 5),
	   (200.00, 3, '2023-05-23', 6, 6),
	   (250.00, 4, '2023-06-30', 7, 7),
	   (70.00, 10, '2023-07-10', 8, 8),
	   (75.00, 11, '2023-08-15', 9, 9),
	   (300.00, 15, '2023-09-20', 10, 10)
