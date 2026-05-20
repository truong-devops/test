/* Ho ten: .............
   MSSV: ...............
   Lop: ................ */

USE master
GO

-- Tao login
CREATE LOGIN NV1 WITH PASSWORD='123', CHECK_POLICY=OFF
CREATE LOGIN NV2 WITH PASSWORD='123', CHECK_POLICY=OFF
CREATE LOGIN QL  WITH PASSWORD='123', CHECK_POLICY=OFF
GO

USE AdventureWorks2008R2
GO

-- Tao user
CREATE USER NV1 FOR LOGIN NV1
CREATE USER NV2 FOR LOGIN NV2
CREATE USER QL  FOR LOGIN QL
GO

-- Tao role
CREATE ROLE NhanVien
GO

-- Them vao role
ALTER ROLE NhanVien ADD MEMBER NV1
ALTER ROLE NhanVien ADD MEMBER NV2

ALTER ROLE db_datareader ADD MEMBER QL
GO

-- Cap quyen cho role
GRANT SELECT,INSERT,UPDATE,DELETE ON Purchasing.PurchaseOrderDetail TO NhanVien
GO


/* =========================================
   Cau 1d
========================================= */



/* =========================================
   Cau 1e
========================================= */

REVOKE SELECT,INSERT,UPDATE,DELETE ON Purchasing.PurchaseOrderDetail FROM NhanVien

ALTER ROLE NhanVien DROP MEMBER NV1
ALTER ROLE NhanVien DROP MEMBER NV2

DROP ROLE NhanVien

DROP USER NV1
DROP USER NV2
DROP USER QL
GO

USE master
GO

DROP LOGIN NV1
DROP LOGIN NV2
DROP LOGIN QL
GO


/* =========================================
   Cau 2a - Full Backup
========================================= */

UPDATE HumanResources.EmployeePayHistory
SET Rate=
CASE
    WHEN ShiftID IN
    (
        SELECT ShiftID
        FROM HumanResources.Shift
        WHERE Name='Chiều'
    )
    THEN Rate*1.15
    ELSE Rate*1.25
END
GO

BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\full.bak'
GO


/* =========================================
   Cau 2b - Differential Backup
========================================= */

DELETE FROM Sales.SalesTerritoryHistory
GO

BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\diff.bak'
WITH DIFFERENTIAL
GO


/* =========================================
   Cau 2c - Log Backup
========================================= */

-- doi 4 so cuoi MSSV
INSERT INTO Person.PersonPhone
VALUES (1234,'123-456-7890',1,GETDATE())
GO

BACKUP LOG AdventureWorks2008R2
TO DISK='T:\log.trn'
GO


/* =========================================
   Cau 2d - Restore
========================================= */

USE master
GO

DROP DATABASE AdventureWorks2008R2
GO

RESTORE DATABASE AdventureWorks2008R2
FROM DISK='T:\full.bak'
WITH NORECOVERY
GO

RESTORE DATABASE AdventureWorks2008R2
FROM DISK='T:\diff.bak'
WITH NORECOVERY
GO

RESTORE LOG AdventureWorks2008R2
FROM DISK='T:\log.trn'
WITH RECOVERY
GO


/* =========================================
   Cau 3 - Trigger
========================================= */

CREATE TRIGGER trg_ProductReview
ON Production.ProductReview
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM Production.Product p
        JOIN inserted i
        ON p.ProductID=i.ProductID
    )
    BEGIN
        UPDATE Production.ProductReview
        SET Comments=i.Comments
        FROM inserted i
        WHERE ProductReview.ProductReviewID=i.ProductReviewID

        SELECT p.ProductID,Color,StandardCost,Rating,Comments
        FROM Production.Product p
        JOIN inserted i
        ON p.ProductID=i.ProductID
    END
    ELSE
    BEGIN
        RAISERROR('Khong ton tai san pham',16,1)
        ROLLBACK TRAN
    END
END
GO

-- Test dung
UPDATE Production.ProductReview
SET Comments='TEST'
WHERE ProductID=709
GO

-- Test sai
UPDATE Production.ProductReview
SET ProductID=99999
WHERE ProductReviewID=1
GO