/* Dang nhap bang user GDV2 roi chay file nay */
USE AdventureWorks2008R2;
GO

-- GDV2 xem ten Vendor, TotalDue cua don hang co StockedQty > 100
SELECT v.Name AS Vendor, h.TotalDue
FROM Purchasing.PurchaseOrderHeader h
JOIN Purchasing.PurchaseOrderDetail d ON h.PurchaseOrderID = d.PurchaseOrderID
JOIN Purchasing.Vendor v ON h.VendorID = v.BusinessEntityID
WHERE d.StockedQty > 100;
GO

-- GDV2 doi ten Vendor tuy y (lay 1 dong de test)
UPDATE TOP (1) Purchasing.Vendor
SET Name = Name + '_GDV2'
WHERE BusinessEntityID IN (SELECT TOP 1 BusinessEntityID FROM Purchasing.Vendor ORDER BY BusinessEntityID);
GO

-- Kiem tra lai
SELECT TOP 5 BusinessEntityID, Name
FROM Purchasing.Vendor
ORDER BY BusinessEntityID;
GO
