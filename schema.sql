USE RestaurantDB_Lab6;
GO

CREATE TABLE dbo.Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(30),
    Role NVARCHAR(30) NOT NULL DEFAULT 'Client',
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    IsActive BIT NOT NULL DEFAULT 1,
    SessionVersion INT NOT NULL DEFAULT 0,
    CONSTRAINT CK_Users_Role CHECK (Role IN ('Client', 'Employee', 'Chef', 'Bartender', 'Admin'))
);

CREATE TABLE dbo.Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Station NVARCHAR(20) NOT NULL DEFAULT 'Kitchen',
    CONSTRAINT CK_Categories_Station CHECK (Station IN ('Kitchen', 'Bar'))
);

CREATE TABLE dbo.DiningTables (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Number INT NOT NULL UNIQUE,
    Seats INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_DiningTables_Number CHECK (Number > 0),
    CONSTRAINT CK_DiningTables_Seats CHECK (Seats > 0)
);

CREATE TABLE dbo.GitHubSyncTest (
    Id INT PRIMARY KEY,
    TestName NVARCHAR(100),
    Description NVARCHAR(200)
);

CREATE TABLE dbo.Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500),
    Price DECIMAL(10,2) NOT NULL,
    ImageUrl NVARCHAR(500),
    PreparationTime INT NOT NULL DEFAULT 15,
    IsAvailable BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(Id),
    CONSTRAINT CK_Products_Price CHECK (Price > 0),
    CONSTRAINT CK_Products_PreparationTime CHECK (PreparationTime >= 0)
);

CREATE TABLE dbo.Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    TotalPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
    Status NVARCHAR(50) NOT NULL DEFAULT N'Асүйге жіберілді',
    TableNumber INT,
    AssignedEmployeeId INT,
    Notes NVARCHAR(500),
    CancellationReason NVARCHAR(500),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(Id),
    CONSTRAINT FK_Orders_Employee FOREIGN KEY (AssignedEmployeeId) REFERENCES dbo.Users(Id),
    CONSTRAINT CK_Orders_TotalPrice CHECK (TotalPrice >= 0)
);

CREATE TABLE dbo.OrderItems (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Station NVARCHAR(20) NOT NULL,
    PreparationStatus NVARCHAR(30) NOT NULL DEFAULT 'Waiting',
    PreparedByUserId INT,
    UpdatedAt DATETIME2,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id),
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id),
    CONSTRAINT FK_OrderItems_PreparedBy FOREIGN KEY (PreparedByUserId) REFERENCES dbo.Users(Id),
    CONSTRAINT CK_OrderItems_Quantity CHECK (Quantity > 0),
    CONSTRAINT CK_OrderItems_Price CHECK (Price >= 0),
    CONSTRAINT CK_OrderItems_Station CHECK (Station IN ('Kitchen', 'Bar')),
    CONSTRAINT CK_OrderItems_PreparationStatus CHECK (PreparationStatus IN ('Waiting', 'Preparing', 'Plating', 'Ready'))
);

CREATE TABLE dbo.Payments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentStatus NVARCHAR(50) NOT NULL DEFAULT N'Ожидается',
    PaymentDate DATETIME2,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id),
    CONSTRAINT CK_Payments_Amount CHECK (Amount > 0)
);
