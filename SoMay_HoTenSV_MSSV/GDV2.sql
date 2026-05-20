USE AdventureWorks2008R2
GO

-- Xem Vendor
SELECT * FROM Purchasing.Vendor
GO

-- Xem don hang nua dau nam 2008
SELECT VendorID,TotalDue
FROM Purchasing.PurchaseOrderHeader
WHERE DueDate<'2008-07-01'
GO

-- Doi ten Vendor
UPDATE Purchasing.Vendor
SET Name='ABC'
WHERE BusinessEntityID=1
GO