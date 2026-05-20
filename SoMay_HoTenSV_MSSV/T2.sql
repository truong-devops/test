/* Cua so query T2 - chay trong luc T1 dang WAITFOR */
USE AdventureWorks2008R2;
GO

SELECT PurchaseOrderID, Freight
FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID = 1;
GO
