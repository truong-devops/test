/* Ho ten: .............
   MSSV: ...............
   Lop: ................ */

USE master
GO

-- Tao login
CREATE LOGIN GDV1 WITH PASSWORD='123', CHECK_POLICY=OFF
CREATE LOGIN GDV2 WITH PASSWORD='123', CHECK_POLICY=OFF
GO

USE AdventureWorks2008R2
GO

-- Tao user
CREATE USER GDV1 FOR LOGIN GDV1
CREATE USER GDV2 FOR LOGIN GDV2
GO

-- Tao role
CREATE ROLE NhanVien
GO

-- Them GDV2 vao role
ALTER ROLE NhanVien ADD MEMBER GDV2
GO

--------------------------------------------------
-- Cap quyen GDV1
--------------------------------------------------

GRANT SELECT,UPDATE ON Purchasing.PurchaseOrderDetail TO GDV1

GRANT SELECT,UPDATE ON Purchasing.PurchaseOrderHeader TO GDV1

DENY SELECT,UPDATE ON Purchasing.Vendor TO GDV1
GO

--------------------------------------------------
-- Cap quyen role NhanVien
--------------------------------------------------

GRANT SELECT,INSERT,UPDATE ON Purchasing.PurchaseOrderDetail TO NhanVien

GRANT SELECT,INSERT,UPDATE ON Purchasing.PurchaseOrderHeader TO NhanVien

GRANT SELECT,INSERT,UPDATE ON Purchasing.Vendor TO NhanVien
GO


/* =================================================
   Cau 2a - Full Backup
================================================= */

BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\backup_full.bak'
GO


/* =================================================
   Cau 2b - Differential Backup
================================================= */

DELETE FROM Production.ProductCostHistory

BACKUP DATABASE AdventureWorks2008R2
TO DISK='T:\backup_diff.bak'
WITH DIFFERENTIAL
GO


/* =================================================
   Cau 2c - Log Backup
================================================= */

UPDATE HumanResources.EmployeePayHistory
SET PayFrequency=2

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
   Cau 2f - Trigger
================================================= */

ALTER TABLE Production.Product
ADD NumChangesCost INT DEFAULT 0
GO

CREATE TRIGGER trg_ProductCost
ON Production.ProductCostHistory
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM Production.Product p
        JOIN inserted i
        ON p.ProductID=i.ProductID
    )
    BEGIN
        INSERT INTO Production.ProductCostHistory
        SELECT *
        FROM inserted

        UPDATE Production.Product
        SET NumChangesCost=NumChangesCost+1
        WHERE ProductID IN
        (
            SELECT ProductID
            FROM inserted
        )
    END
    ELSE
    BEGIN
        RAISERROR('Khong ton tai san pham',16,1)
        ROLLBACK TRAN
    END
END
GO

-- Test dung
INSERT INTO Production.ProductCostHistory
(ProductID,StartDate,StandardCost,ModifiedDate)
VALUES (1,GETDATE(),100,GETDATE())
GO

-- Test sai
INSERT INTO Production.ProductCostHistory
(ProductID,StartDate,StandardCost,ModifiedDate)
VALUES (99999,GETDATE(),100,GETDATE())
GO