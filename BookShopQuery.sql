USE BookShop

--1
SELECT *
FROM Books
WHERE Pages BETWEEN 500 AND 650

--2
SELECT *
FROM Books
WHERE Name LIKE 'А%' OR Name LIKE 'З%'

--3
SELECT *
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
WHERE Themes.Name = 'Детектив' AND Books.Id IN (SELECT Sales.BookId
												FROM Sales
												WHERE Sales.Quantity > 30)

--4
SELECT *
FROM Books
WHERE Name LIKE '%Microsoft%' AND Name NOT LIKE '%Windows%'

--5
SELECT Books.Name, Themes.Name as 'Theme', Authors.Name + ' ' + Authors.Surname as 'Author'
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
		   JOIN Authors ON Books.AuthorId = Authors.Id
WHERE (Books.Price/Books.Pages) < 0.65

--6
SELECT *
FROM Books
WHERE (SELECT COUNT(*) 
	   FROM STRING_SPLIT(Name, ' ')) = 4

--7
SELECT Books.Name
FROM Books
WHERE Books.Name NOT LIKE '%А%'

SELECT Themes.Name
FROM Themes
WHERE Themes.Name <> 'Программирование'

SELECT Authors.Name + ' ' + Authors.Surname as 'Author'
FROM Authors
WHERE (Authors.Name + ' ' + Authors.Surname <> 'Герберт Шилдт')

SELECT Price
FROM Sales
WHERE Price BETWEEN 10 AND 20

SELECT Quantity
FROM Sales
WHERE Quantity >= 8 

SELECT Shops.Name
FROM Shops JOIN Countries ON Shops.CountryId = Countries.Id
WHERE Countries.Name NOT IN ('Украина', 'Россия')

--8
SELECT 'Количество авторов', COUNT(*)
FROM Authors

SELECT 'Количество книг', COUNT(*)
FROM Books

SELECT 'Средняя цена продажи', AVG(Sales.Price)
FROM Sales

SELECT 'Среднее количество страниц', Avg(Books.Pages)
FROM Books

--9
SELECT Themes.Name, SUM(Books.Pages) as 'Pages Sum'
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
GROUP BY Themes.Name

--10
SELECT COUNT(Books.Name) as 'Books of the author', SUM(Books.Pages) as 'Pages Sum'
FROM Books JOIN Authors ON Books.AuthorId = Authors.Id
GROUP BY Authors.Id

--11
SELECT TOP 1 *
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
ORDER BY Books.Pages DESC

--12
SELECT Themes.Name, AVG(Books.Pages) as 'AVG Pages'
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
GROUP BY Themes.Name
HAVING AVG(Books.Pages) <= 400

--13
SELECT Themes.Name, Sum(Books.Pages) as 'Pages Sum'
FROM Books JOIN Themes ON Books.ThemeId = Themes.Id
WHERE Themes.Name IN ('Программирование', 'Администрирование', 'Дизайн')
GROUP BY Themes.Name
HAVING Sum(Books.Pages) > 400

--14
SELECT Books.Name as 'Book', Countries.Name as 'Country', Shops.Name as 'Shop', Sales.SaleDate, Sales.Quantity
FROM Sales JOIN Books ON Sales.BookId = Books.Id
		   JOIN Shops ON Sales.ShopId = Shops.Id, Countries
WHERE Shops.CountryId = Countries.Id

--15
SELECT TOP 1 Shops.Name
FROM Sales JOIN Shops ON Sales.ShopId = Shops.Id
ORDER BY (Sales.Price * Sales.Quantity) DESC