USE RestaurantDB_Lab6;
GO

CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) UNIQUE
);

CREATE TABLE Products (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price INT NOT NULL CHECK (Price > 0)
);

CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY,
    CustomerId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0),
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

CREATE TABLE Payments (
    Id INT PRIMARY KEY,
    OrderId INT NOT NULL,
    Amount INT NOT NULL CHECK (Amount > 0),
    Method NVARCHAR(30) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id)
);

INSERT INTO Customers VALUES
(1, N'Медет', N'87010000001'),
(2, N'Айдос', N'87010000002'),
(3, N'Аружан', N'87010000003'),
(4, N'Данияр', N'87010000004'),
(5, N'Мадина', N'87010000005'),
(6, N'Ерасыл', N'87010000006'),
(7, N'Әлия', N'87010000007'),
(8, N'Нұрбек', N'87010000008'),
(9, N'Диана', N'87010000009'),
(10, N'Арман', N'87010000010'),
(11, N'Айгерім', N'87010000011'),
(12, N'Бекзат', N'87010000012'),
(13, N'Алина', N'87010000013'),
(14, N'Нұрсұлтан', N'87010000014'),
(15, N'Жанель', N'87010000015');

INSERT INTO Products VALUES
(1, N'Бургер', N'Фастфуд', 2500),
(2, N'Чизбургер', N'Фастфуд', 2800),
(3, N'Пицца Маргарита', N'Пицца', 3200),
(4, N'Пицца Пепперони', N'Пицца', 3900),
(5, N'Цезарь', N'Салат', 2700),
(6, N'Грек салаты', N'Салат', 2400),
(7, N'Палау', N'Ыстық тағам', 3000),
(8, N'Манты', N'Ыстық тағам', 2800),
(9, N'Лағман', N'Ыстық тағам', 2600),
(10, N'Сорпа', N'Ыстық тағам', 1800),
(11, N'Чизкейк', N'Десерт', 1800),
(12, N'Балмұздақ', N'Десерт', 1000),
(13, N'Кола', N'Сусын', 700),
(14, N'Лимонад', N'Сусын', 1200),
(15, N'Капучино', N'Сусын', 1300);

INSERT INTO Employees VALUES
(1, N'Арман', N'Администратор'),
(2, N'Айдос', N'Аспаз'),
(3, N'Данияр', N'Аспаз'),
(4, N'Мадина', N'Даяшы'),
(5, N'Аружан', N'Даяшы'),
(6, N'Ерасыл', N'Бармен'),
(7, N'Әлия', N'Кассир'),
(8, N'Нұрбек', N'Даяшы'),
(9, N'Диана', N'Бармен'),
(10, N'Бекзат', N'Аспаз'),
(11, N'Айгерім', N'Кассир'),
(12, N'Нұрсұлтан', N'Даяшы'),
(13, N'Жанель', N'Администратор'),
(14, N'Алина', N'Даяшы'),
(15, N'Руслан', N'Аспаз');

INSERT INTO Orders VALUES
(1, 1, 3, 2, '2026-10-01'),
(2, 2, 1, 1, '2026-10-01'),
(3, 3, 5, 2, '2026-10-02'),
(4, 4, 7, 1, '2026-10-02'),
(5, 5, 13, 3, '2026-10-03'),
(6, 6, 4, 2, '2026-10-03'),
(7, 7, 8, 1, '2026-10-04'),
(8, 8, 10, 2, '2026-10-04'),
(9, 9, 11, 1, '2026-10-05'),
(10, 10, 14, 2, '2026-10-05'),
(11, 11, 2, 1, '2026-10-06'),
(12, 12, 6, 2, '2026-10-06'),
(13, 13, 9, 1, '2026-10-07'),
(14, 14, 12, 3, '2026-10-07'),
(15, 15, 15, 2, '2026-10-08');

INSERT INTO Payments VALUES
(1, 1, 6400, N'Kaspi'),
(2, 2, 2500, N'Қолма-қол'),
(3, 3, 5400, N'Kaspi'),
(4, 4, 3000, N'Карта'),
(5, 5, 2100, N'Kaspi'),
(6, 6, 7800, N'Қолма-қол'),
(7, 7, 2800, N'Карта'),
(8, 8, 3600, N'Kaspi'),
(9, 9, 1800, N'Қолма-қол'),
(10, 10, 2400, N'Kaspi'),
(11, 11, 2800, N'Карта'),
(12, 12, 4800, N'Kaspi'),
(13, 13, 2600, N'Қолма-қол'),
(14, 14, 3000, N'Kaspi'),
(15, 15, 2600, N'Карта');

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM Payments;
GO
