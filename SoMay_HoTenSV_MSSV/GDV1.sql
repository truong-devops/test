/* Dang nhap bang user GDV1 roi chay file nay */
USE AdventureWorks2008R2;
GO

-- GDV1 xem VendorID, OrderDate, LineTotal trong nam 2008
SELECT h.VendorID, h.OrderDate, d.LineTotal
FROM Purchasing.PurchaseOrderHeader h
JOIN Purchasing.PurchaseOrderDetail d
     ON h.PurchaseOrderID = d.PurchaseOrderID
WHERE YEAR(h.OrderDate) = 2008;
GO

-- GDV1 xem Vendor, CreditRating cua cac don hang co DueDate nua dau nam 2008
-- Cau nay se LOI vi GDV1 bi cam xem/sua bang Vendor
SELECT v.Name AS Vendor, v.CreditRating
FROM Purchasing.PurchaseOrderHeader h
JOIN Purchasing.Vendor v ON h.VendorID = v.BusinessEntityID
WHERE h.DueDate >= '2008-01-01'
  AND h.DueDate <  '2008-07-01';
GO
