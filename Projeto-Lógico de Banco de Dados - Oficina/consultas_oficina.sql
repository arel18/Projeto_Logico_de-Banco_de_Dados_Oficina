
-- 1. Pedidos com dados do cliente, veículo e equipe
SELECT 
    o.idOrder,
    c.Fname + ' ' + c.Lname AS ClientName,
    v.Model AS VehicleModel,
    t.idTeam,
    e.Fname + ' ' + e.Lname AS EmployeeName,
    o.Status,
    o.totalPrice,
    o.paymentDate
FROM orders o
INNER JOIN clients c ON o.idClient = c.idClient
INNER JOIN vehicles v ON o.idVehicle = v.idVehicle
INNER JOIN teams t ON o.idTeam = t.idTeam
INNER JOIN employees e ON t.idEmployee = e.idEmployee
ORDER BY o.paymentDate DESC;

-- 2. Produtos utilizados em um pedido específico
SELECT 
    o.idOrder,
    p.Product,
    p.SalePrice
FROM orders o
INNER JOIN orderProductsManagement opm ON o.idOrder = opm.idOrder
INNER JOIN stockProducts p ON opm.idProduct = p.idProduct
WHERE o.idOrder = 1;

-- 3. Valor total de serviços por pedido com total > R$ 100
SELECT 
    o.idOrder,
    SUM(s.price) AS TotalServicesValue
FROM orders o
INNER JOIN orderServicesManagement osm ON o.idOrder = osm.idOrder
INNER JOIN services s ON osm.idService = s.idService
GROUP BY o.idOrder
HAVING SUM(s.price) > 100
ORDER BY TotalServicesValue DESC;

-- 4. Clientes com mais de 1 pedido e valor médio gasto
SELECT 
    c.idClient,
    c.Fname + ' ' + c.Lname AS ClientName,
    COUNT(o.idOrder) AS TotalOrders,
    AVG(o.totalPrice) AS AvgSpent
FROM clients c
INNER JOIN orders o ON c.idClient = o.idClient
GROUP BY c.idClient, c.Fname, c.Lname
HAVING COUNT(o.idOrder) > 1
ORDER BY AvgSpent DESC;

-- 5. Serviços com duração maior que 30 minutos
SELECT 
    s.typeOfService,
    s.duration,
    COUNT(osm.idOrder) AS TotalTimesUsed
FROM services s
LEFT JOIN orderServicesManagement osm ON s.idService = osm.idService
WHERE s.duration > 30
GROUP BY s.typeOfService, s.duration
ORDER BY TotalTimesUsed DESC;

-- 6. Fornecedores e quantidade de produtos fornecidos
SELECT 
    s.SocialName,
    COUNT(swp.idProduct) AS TotalProducts
FROM suppliers s
INNER JOIN suppliersWithProducts swp ON s.idSupplier = swp.idSupplier
GROUP BY s.SocialName
HAVING COUNT(swp.idProduct) >= 1
ORDER BY TotalProducts DESC;

-- 7. Produtos com estoque abaixo de 50 unidades
SELECT 
    idProduct,
    Product,
    stockQuantity,
    expirationDate
FROM stockProducts
WHERE stockQuantity < 50
ORDER BY stockQuantity ASC;
