-- Criando o banco de dados
CREATE DATABASE mechanical_workshop;
GO

USE mechanical_workshop;
GO

-- Tabela de cidades
CREATE TABLE cities (
    idCity INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    state CHAR(2) NOT NULL,
    region VARCHAR(20) NOT NULL CHECK (region IN ('Norte', 'Nordeste', 'Sul', 'Sudeste', 'Centro-Oeste'))
);
GO

-- Tabela de empregados
CREATE TABLE employees (
    idEmployee INT IDENTITY(1,1) PRIMARY KEY,
    idCity INT,
    Fname VARCHAR(25) NOT NULL,
    Mname VARCHAR(25) NOT NULL,
    Lname VARCHAR(25) NOT NULL,
    CPF CHAR(11) NOT NULL,
    PhoneNum CHAR(12) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    Profession VARCHAR(30) NOT NULL DEFAULT 'Mecânico'
        CHECK (Profession IN ('Mecânico', 'Mecânico de Manutenção', 'Mecânico Montador')),
    CEP CHAR(8) NOT NULL,
    CONSTRAINT unique_cpf_employee UNIQUE (CPF),
    CONSTRAINT unique_phone_employee UNIQUE (PhoneNum),
    CONSTRAINT unique_email_employee UNIQUE (Email),
    CONSTRAINT fk_employees_cities FOREIGN KEY (idCity) REFERENCES cities(idCity)
);
GO

-- Tabela de times
CREATE TABLE teams (
    idTeam INT IDENTITY(1,1) PRIMARY KEY,
    idEmployee INT,
    CONSTRAINT fk_employee_teams FOREIGN KEY (idEmployee) REFERENCES employees(idEmployee)
);
GO

-- Tabela de clientes
CREATE TABLE clients (
    idClient INT IDENTITY(1,1) PRIMARY KEY,
    idCity INT,
    Fname VARCHAR(25) NOT NULL,
    Mname VARCHAR(25) NOT NULL,
    Lname VARCHAR(25) NOT NULL,
    CPF CHAR(11) NOT NULL,
    CEP CHAR(8) NOT NULL,
    AdressReference VARCHAR(45),
    City VARCHAR(45) NOT NULL,
    PhoneNum CHAR(12) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    CONSTRAINT unique_cpf_client UNIQUE (CPF),
    CONSTRAINT unique_phone_client UNIQUE (PhoneNum),
    CONSTRAINT unique_email_client UNIQUE (Email),
    CONSTRAINT fk_clients_cities FOREIGN KEY (idCity) REFERENCES cities(idCity)
);
GO

-- Tabela de veículos
CREATE TABLE vehicles (
    idVehicle INT IDENTITY(1,1) PRIMARY KEY,
    idClient INT,
    Model VARCHAR(45) NOT NULL,
    Color VARCHAR(45) NOT NULL,
    Year CHAR(4) NOT NULL,
    LicensePlateNumber CHAR(7) NOT NULL UNIQUE,
    type VARCHAR(45) NOT NULL,
    CONSTRAINT fk_vehicles_clients FOREIGN KEY (idClient) REFERENCES clients(idClient)
);
GO

-- Tabela de fornecedores
CREATE TABLE suppliers (
    idSupplier INT IDENTITY(1,1) PRIMARY KEY,
    idCity INT,
    CNPJ CHAR(14) NOT NULL,
    CEP CHAR(8) NOT NULL,
    AdressReference VARCHAR(45),
    PhoneNum CHAR(16) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    CONSTRAINT unique_cnpj_suppliers UNIQUE (CNPJ),
    CONSTRAINT unique_phone_suppliers UNIQUE (PhoneNum),
    CONSTRAINT unique_email_suppliers UNIQUE (Email),
    CONSTRAINT fk_suppliers_cities FOREIGN KEY (idCity) REFERENCES cities(idCity)
);
GO

-- Tabela de produtos em estoque
CREATE TABLE stockProducts (
    idProduct INT IDENTITY(1,1) PRIMARY KEY,
    Product VARCHAR(45) NOT NULL,
    SalePrice FLOAT DEFAULT 0.0,
    PurchasePrice FLOAT DEFAULT 0.0,
    stockQuantity INT NOT NULL DEFAULT 0 CHECK (stockQuantity >= 0),
    expirationDate DATE NOT NULL,
    deliveryTime INT NOT NULL DEFAULT 1
);
GO

-- Tabela de relação fornecedores-produtos
CREATE TABLE suppliersWithProducts (
    idSupplier INT,
    idProduct INT,
    CONSTRAINT pk_SuppliersWithProducts PRIMARY KEY (idSupplier, idProduct),
    CONSTRAINT fk_SuppliersWithProducts_supplier FOREIGN KEY (idSupplier) REFERENCES suppliers(idSupplier),
    CONSTRAINT fk_SuppliersWithProducts_products FOREIGN KEY (idProduct) REFERENCES stockProducts(idProduct)
);
GO

-- Tabela de pedidos
CREATE TABLE orders (
    idOrder INT IDENTITY(1,1) PRIMARY KEY,
    idVehicle INT,
    idTeam INT,
    idClient INT,
    Status VARCHAR(45) NOT NULL,
    evaluationDate DATE NOT NULL,
    authDate DATE NOT NULL,
    begginDate DATE NOT NULL,
    endDate DATE NOT NULL,
    totalPrice FLOAT NOT NULL,
    paymentDate DATE NOT NULL,
    CONSTRAINT fk_orders_vehicles FOREIGN KEY (idVehicle) REFERENCES vehicles(idVehicle),
    CONSTRAINT fk_orders_teams FOREIGN KEY (idTeam) REFERENCES teams(idTeam),
    CONSTRAINT fk_orders_clients FOREIGN KEY (idClient) REFERENCES clients(idClient)
);
GO

-- Tabela de gestão de produtos nos pedidos
CREATE TABLE orderProductsManagement (
    idProduct INT,
    idOrder INT,
    CONSTRAINT pk_orderProductsManagement PRIMARY KEY (idProduct, idOrder),
    CONSTRAINT fk_orderProductsManagement_products FOREIGN KEY (idProduct) REFERENCES stockProducts(idProduct),
    CONSTRAINT fk_orderProductsManagement_orders FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);
GO

-- Tabela de serviços
CREATE TABLE services (
    idService INT IDENTITY(1,1) PRIMARY KEY,
    typeOfService VARCHAR(45) NOT NULL,
    description TEXT,
    price FLOAT DEFAULT 0.0,
    duration INT NOT NULL
);
GO

-- Tabela de gestão de serviços nos pedidos
CREATE TABLE orderServicesManagement (
    idService INT,
    idOrder INT,
    CONSTRAINT pk_orderServicesManagement PRIMARY KEY (idService, idOrder),
    CONSTRAINT fk_orderServicesManagement_orders FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
    CONSTRAINT fk_orderServicesManagement_services FOREIGN KEY (idService) REFERENCES services(idService)
);
GO

-- Tabela de pagamentos
CREATE TABLE payments (
    idPayment INT IDENTITY(1,1) PRIMARY KEY,
    idClient INT,
    typePayment VARCHAR(25)
        CHECK (typePayment IN ('Boleto', 'Cartão de Crédito', 'Dois Cartões', 'Pix')),
    CONSTRAINT fk_client_payment FOREIGN KEY (idClient) REFERENCES clients(idClient)
);
GO

-- Tabela de métodos de pagamento
CREATE TABLE paymentMethods (
    idPaymentMethod INT IDENTITY(1,1) PRIMARY KEY,
    idPayment INT,
    idOrder INT,
    CONSTRAINT fk_payment_methods_payments FOREIGN KEY (idPayment) REFERENCES payments(idPayment),
    CONSTRAINT fk_payment_methods_orders FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);
GO
