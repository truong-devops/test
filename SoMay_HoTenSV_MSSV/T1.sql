/* Cua so query T1 - demo giao tac don gian */
USE AdventureWorks2008R2;
GO

BEGIN TRAN;

UPDATE TOP (1) Purchasing.PurchaseOrderHeader
SET Freight = Freight + 1
WHERE PurchaseOrderID = 1;

-- De yen cua so nay, qua T2 chay de thay bi cho khoa
WAITFOR DELAY '00:00:10';

COMMIT TRAN;
GO
