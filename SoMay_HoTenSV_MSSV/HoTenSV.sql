/* Ho ten: ....................  MSSV: ............ */
USE master;
GO

-- Xoa neu da ton tai (de chay lai khong loi)
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'GDV1') DROP LOGIN GDV1;
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'GDV2') DROP LOGIN GDV2;
GO

CREATE LOGIN GDV1 WITH PASSWORD = 'GDV1', CHECK_POLICY = OFF;
CREATE LOGIN GDV2 WITH PASSWORD = 'GDV2', CHECK_POLICY = OFF;
GO

USE AdventureWorks2008R2;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'GDV1') DROP USER GDV1;
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'GDV2') DROP USER GDV2;
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'NhanVien') DROP ROLE NhanVien;
GO

CREATE USER GDV1 FOR LOGIN GDV1;
CREATE USER GDV2 FOR LOGIN GDV2;
CREATE ROLE NhanVien;
GO

EXEC sp_addrolemember 'NhanVien', 'GDV2';
GO

-- Cap quyen cho GDV1
GRANT SELECT, UPDATE ON Purchasing.PurchaseOrderDetail TO GDV1;
GRANT SELECT, UPDATE ON Purchasing.PurchaseOrderHeader TO GDV1;
DENY  SELECT, UPDATE ON Purchasing.Vendor TO GDV1;
GO

-- Cap quyen cho role NhanVien (GDV2 nam trong role nay)
GRANT SELECT, INSERT, UPDATE ON Purchasing.PurchaseOrderDetail TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON Purchasing.PurchaseOrderHeader TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON Purchasing.Vendor TO NhanVien;
GO

-- Thu hoi quyen va xoa role/user (chay sau khi da test xong)
/*
USE AdventureWorks2008R2;
GO
REVOKE SELECT, UPDATE ON Purchasing.PurchaseOrderDetail FROM GDV1;
REVOKE SELECT, UPDATE ON Purchasing.PurchaseOrderHeader FROM GDV1;
REVOKE SELECT, INSERT, UPDATE ON Purchasing.PurchaseOrderDetail FROM NhanVien;
REVOKE SELECT, INSERT, UPDATE ON Purchasing.PurchaseOrderHeader FROM NhanVien;
REVOKE SELECT, INSERT, UPDATE ON Purchasing.Vendor FROM NhanVien;
GO

EXEC sp_droprolemember 'NhanVien', 'GDV2';
DROP USER GDV1;
DROP USER GDV2;
DROP ROLE NhanVien;
GO

USE master;
GO
DROP LOGIN GDV1;
DROP LOGIN GDV2;
GO
*/
