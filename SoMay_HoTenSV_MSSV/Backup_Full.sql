/* Cau 2a - Full Backup */
USE master;
GO

BACKUP DATABASE AdventureWorks2008R2
TO DISK = 'T:\AdventureWorks2008R2_FULL.bak'
WITH INIT, NAME = 'Full Backup AdventureWorks2008R2';
GO
