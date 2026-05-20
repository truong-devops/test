USE AdventureWorks2008R2
GO

-- doi 3 so cuoi MSSV
UPDATE Purchasing.PurchaseOrderDetail
SET ModifiedDate=GETDATE()
WHERE PurchaseOrderDetailID=123
GO