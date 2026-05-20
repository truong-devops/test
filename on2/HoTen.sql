/* Ho ten: ............
   MSSV: ..............
   Lop: ............... */

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

-- Them user vao role
ALTER ROLE NhanVien ADD MEMBER NV1
ALTER ROLE NhanVien ADD MEMBER NV2
ALTER ROLE db_datareader ADD MEMBER QL
GO

-- Cap quyen cho role
GRANT SELECT,INSERT,UPDATE,DELETE ON Person.PersonPhone TO NhanVien
GO


/* =================================================
   Cau 1d
================================================= */


/* =================================================
   Cau 1e - Thu hoi quyen
================================================= */

REVOKE SELECT,INSERT,UPDATE,DELETE ON Person.PersonPhone FROM NhanVien

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


/* =================================================
   Cau 2a - Full Backup
================================================= */

UPDATE HumanResources.EmployeePayHistory
SET Rate =
CASE
    WHEN DepartmentID IN
    (
        SELECT DepartmentID
        FROM HumanResources.Department
        WHERE Name IN ('Production','Production Control')
    )
    THEN Rate*1.2
    ELSE Rate*1.15
END

--backup full
BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\backup_full.bak'
GO


/* =================================================
   Cau 2b - Differential Backup
================================================= */

DELETE FROM Purchasing.PurchaseOrderDetail

BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\backup_diff.bak'
WITH DIFFERENTIAL
GO


/* =================================================
   Cau 2c - Log Backup
   doi 4 so cuoi MSSV
================================================= */

INSERT INTO Person.PersonPhone
VALUES (1234,'123-456-7890',1,GETDATE())

BACKUP LOG AdventureWorks2008R2
TO DISK='T:\backup_log.trn'
GO


/* =================================================
   Cau 2d - Restore
================================================= */

USE master
GO

DROP DATABASE AdventureWorks2008R2
GO

RESTORE DATABASE AdventureWorks2008R2
FROM DISK='T:\backup_full.bak'
WITH NORECOVERY
GO

RESTORE DATABASE AdventureWorks2008R2
FROM DISK='T:\backup_diff.bak'
WITH NORECOVERY
GO

RESTORE LOG AdventureWorks2008R2
FROM DISK='T:\backup_log.trn'
WITH RECOVERY
GO


/* =================================================
   Cau 3 - Trigger
================================================= */

CREATE TRIGGER trg_ProductReview
ON Production.ProductReview
AFTER UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT *
        FROM Production.Product p
        JOIN inserted i
        ON p.ProductID=i.ProductID
    )
    BEGIN
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
SET Comments='Test'
WHERE ProductID=709
GO

-- Test sai
UPDATE Production.ProductReview
SET ProductID=999999 WHERE ProductReviewID=1
GO