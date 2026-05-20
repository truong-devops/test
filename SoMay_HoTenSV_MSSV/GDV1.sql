USE AdventureWorks2008R2
GO

-- Xem du lieu
SELECT VendorID,OrderDate,LineTotal
FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate)=2008
GO

-- Thu xem Vendor -> bi loi
SELECT * FROM Purchasing.Vendor
GO