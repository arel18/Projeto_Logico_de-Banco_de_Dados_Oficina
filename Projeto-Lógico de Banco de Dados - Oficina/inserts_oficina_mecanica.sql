
-- Inserts para tabela cities
INSERT INTO cities (name, state, region) VALUES
('São Paulo', 'SP', 'Sudeste'),
('Rio de Janeiro', 'RJ', 'Sudeste'),
('Belo Horizonte', 'MG', 'Sudeste');

-- Inserts para tabela employees
INSERT INTO employees (idCity, Fname, Mname, Lname, CPF, PhoneNum, Email, Profession, CEP)
VALUES
(1, 'Carlos', 'A', 'Silva', '12345678900', '011912345678', 'carlos.silva@oficina.com', 'Mecânico', '01234567'),
(2, 'Fernanda', 'B', 'Oliveira', '98765432100', '021998765432', 'fernanda.oliveira@oficina.com', 'Mecânico Montador', '76543210');

-- Inserts para tabela teams
INSERT INTO teams (idEmployee)
VALUES
(1),
(2);

-- Inserts para tabela clients
INSERT INTO clients (idCity, Fname, Mname, Lname, CPF, CEP, AdressReference, City, PhoneNum, Email)
VALUES
(1, 'João', 'C', 'Santos', '12312312312', '04567890', 'Rua das Oficinas, 100', 'São Paulo', '011987654321', 'joao.santos@email.com'),
(2, 'Maria', 'D', 'Souza', '32132132132', '07654321', 'Av. Central, 200', 'Rio de Janeiro', '021912345678', 'maria.souza@email.com');

-- Inserts para tabela vehicles
INSERT INTO vehicles (idClient, Model, Color, Year, LicensePlateNumber, type)
VALUES
(1, 'Fiat Uno', 'Vermelho', '2012', 'ABC1234', 'Carro'),
(2, 'Honda Biz', 'Preto', '2018', 'XYZ4321', 'Moto');

-- Inserts para tabela suppliers
INSERT INTO suppliers (idCity, CNPJ, CEP, AdressReference, PhoneNum, Email)
VALUES
(3, '12345678000199', '30123456', 'Rua dos Fornecedores, 10', '03199887766', 'contato@fornecedor1.com'),
(1, '98765432000188', '04567890', 'Av. Auto Peças, 400', '01199887766', 'contato@fornecedor2.com');

-- Inserts para tabela stockProducts
INSERT INTO stockProducts (Product, SalePrice, PurchasePrice, stockQuantity, expirationDate, deliveryTime)
VALUES
('Óleo 10W40', 35.00, 25.00, 50, '2026-01-01', 2),
('Filtro de Ar', 20.00, 10.00, 100, '2025-12-01', 1);

-- Inserts para tabela suppliersWithProducts
INSERT INTO suppliersWithProducts (idSupplier, idProduct)
VALUES
(1, 1),
(2, 2);

-- Inserts para tabela orders
INSERT INTO orders (idVehicle, idTeam, idClient, Status, evaluationDate, authDate, begginDate, endDate, totalPrice, paymentDate)
VALUES
(1, 1, 1, 'Finalizado', '2025-08-01', '2025-08-02', '2025-08-03', '2025-08-05', 120.00, '2025-08-05'),
(2, 2, 2, 'Em andamento', '2025-08-02', '2025-08-03', '2025-08-04', '2025-08-07', 200.00, '2025-08-07');

-- Inserts para tabela orderProductsManagement
INSERT INTO orderProductsManagement (idProduct, idOrder)
VALUES
(1, 1),
(2, 2);

-- Inserts para tabela services
INSERT INTO services (typeOfService, description, price, duration)
VALUES
('Troca de óleo', 'Troca do óleo do motor com filtro', 50.00, 30),
('Alinhamento', 'Alinhamento e balanceamento das rodas', 70.00, 45);

-- Inserts para tabela orderServicesManagement
INSERT INTO orderServicesManagement (idService, idOrder)
VALUES
(1, 1),
(2, 2);

-- Inserts para tabela payments
INSERT INTO payments (idClient, typePayment)
VALUES
(1, 'Pix'),
(2, 'Cartão de Crédito');

-- Inserts para tabela paymentMethods
INSERT INTO paymentMethods (idPayment, idOrder)
VALUES
(1, 1),
(2, 2);
